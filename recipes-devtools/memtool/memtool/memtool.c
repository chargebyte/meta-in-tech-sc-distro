/*
 * Copyright 2006 Freescale Semiconductor, Inc. All Rights Reserved.
 */

/*
 * The code contained herein is licensed under the GNU General Public
 * License. You may obtain a copy of the GNU General Public License
 * Version 2 or later at the following locations:
 *
 * http://www.opensource.org/licenses/gpl-license.html
 * http://www.gnu.org/copyleft/gpl.html
 */


#include <stddef.h>
#include <stdio.h>
#include <sys/types.h>
#include <stdint.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>

#if __SIZEOF_POINTER__ == 8
#define addr_t unsigned long long int
#define PRIaddr_t "llX"
#define SUPPORT_64BIT 1
#else
#define addr_t unsigned long int
#define PRIaddr_t "lX"
#define SUPPORT_64BIT 0
#endif

unsigned char g_size = __SIZEOF_POINTER__;
addr_t g_paddr;
int g_is_write;
unsigned long long int g_value = 0;
unsigned long int g_count = 1;

/* platform specific padding of hex-pointers */
#define PTR_PADDING __SIZEOF_POINTER__ * 2

int parse_cmdline(int argc, char ** argv)
{
	int cur_arg = 0;
	char * str;

	if (argc < 2)
		return -1;

	cur_arg++;
        if (strcmp(argv[cur_arg], "-8") == 0) {
		cur_arg++;
                g_size = 1;
        }
	else if (strcmp(argv[cur_arg], "-16") == 0) {
		cur_arg++;
                g_size = 2;
        }
	else if (strcmp(argv[cur_arg], "-32") == 0) {
		cur_arg++;
                g_size = 4;
        }
#if SUPPORT_64BIT == 1
	else if (strcmp(argv[cur_arg], "-64") == 0) {
		cur_arg++;
                g_size = 8;
        }
#endif
	if (cur_arg >= argc)
		return -1;

	g_paddr = strtoull(argv[cur_arg], NULL, 16);
	if (!g_paddr)
		return -1;

	if ( str = strchr(argv[cur_arg], '=') ) {
		g_is_write = 1;
		if (strlen(str) > 1) {
			str++;
			g_value = strtoull(str, NULL, 16);
			return 0;
		}
	}
	if (++cur_arg >= argc)
		return -1;

	if ((argv[cur_arg])[0] == '=' ) {
		g_is_write = 1;
		if (strlen(argv[cur_arg]) > 1) {
			(argv[cur_arg])++;
		} else {
			if (++cur_arg >= argc)
				return -1;
		}
		g_value = strtoull(argv[cur_arg], NULL, 16);
	}
	else {
		if (g_is_write)
			g_value = strtoull(argv[cur_arg], NULL, 16);
		else
			g_count = strtoul(argv[cur_arg], NULL, 16);
	}
	return 0;
}

void read_mem(void * addr, unsigned long int count, unsigned char size)
{
	unsigned long int i;
	uint8_t * addr8 = addr;
	uint16_t * addr16 = addr;
	uint32_t * addr32 = addr;
	uint64_t * addr64 = addr;

	switch (size)
	{
		case 1:
			for (i = 0; i < count; i++) {
				if ( (i % 16) == 0 )
					printf("\n0x%0*" PRIaddr_t ": ", PTR_PADDING, g_paddr);
				printf(" %02" PRIX8, addr8[i]);
				g_paddr++;
			}
			break;
		case 2:
			for (i = 0; i < count; i++) {
				if ( (i % 8) == 0 )
					printf("\n0x%0*" PRIaddr_t ": ", PTR_PADDING, g_paddr);
				printf(" %04" PRIX16, addr16[i]);
				g_paddr += 2;
			}
			break;
		case 4:
			for (i = 0; i < count; i++) {
				if ( (i % 4) == 0 )
					printf("\n0x%0*" PRIaddr_t ": ", PTR_PADDING, g_paddr);
				printf(" %08" PRIX32, addr32[i]);
				g_paddr += 4;
			}
			break;
		case 8:
			for (i = 0; i < count; i++) {
				if ( (i % 2) == 0 )
					printf("\n0x%0*" PRIaddr_t ": ", PTR_PADDING, g_paddr);
				printf(" %016" PRIX64, addr64[i]);
				g_paddr += 8;
			}
			break;
	}
	printf("\n\n");
}

void write_mem(void * addr, unsigned long long int value, unsigned char size)
{
	uint8_t * addr8 = addr;
	uint16_t * addr16 = addr;
	uint32_t * addr32 = addr;
	uint64_t * addr64 = addr;

	switch (size)
	{
		case 1:
			*addr8 = value;
			break;
		case 2:
			*addr16 = value;
			break;
		case 4:
			*addr32 = value;
			break;
		case 8:
			*addr64 = value;
			break;
	}
}

int main(int argc, char **argv)
{
	int fd;
	void * mem;
	void * aligned_vaddr;
	size_t aligned_size;
	addr_t aligned_paddr;

	if (parse_cmdline(argc, argv)) {
		printf("Usage:\n\n" \
		       "Read memory: memtool [-8 | -16 | -32%1$s] <phys addr> <count>\n" \
		       "Write memory: memtool [-8 | -16 | -32%1$s] <phys addr>=<value>\n\n" \
		       "Default access size is %2$u-bit.\n\nAddress, count and value are all in hex.\n",
		       SUPPORT_64BIT ? " | -64" : "", __SIZEOF_POINTER__ * 8);
		return 1;
	}

	/* Align address to access size */
	g_paddr &= ~(g_size - 1);

	aligned_paddr = g_paddr & ~(4096 - 1);
	aligned_size = g_paddr - aligned_paddr + (g_count * g_size);
	aligned_size = (aligned_size + 4096 - 1) & ~(4096 - 1);

	if (g_is_write)
		printf("Writing %d-bit value 0x%llX to address 0x%0*" PRIaddr_t "\n", g_size*8, g_value, PTR_PADDING, g_paddr);
	else
		printf("Reading 0x%lX count starting at address 0x%0*" PRIaddr_t "\n", g_count, PTR_PADDING, g_paddr);

	if ((fd = open("/dev/mem", O_RDWR, 0)) < 0)
		return 1;

	aligned_vaddr = mmap(NULL, aligned_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, aligned_paddr);
	if (aligned_vaddr == NULL) {
		printf("Error mapping address\n");
		close(fd);
		return 1;
	}

	mem = (void *)((addr_t)aligned_vaddr + (g_paddr - aligned_paddr));

	if (g_is_write) {
		write_mem(mem, g_value, g_size);
	}
	else {
		read_mem(mem, g_count, g_size);
	}

	munmap(aligned_vaddr, aligned_size);
	close(fd);
	return 0;
}
