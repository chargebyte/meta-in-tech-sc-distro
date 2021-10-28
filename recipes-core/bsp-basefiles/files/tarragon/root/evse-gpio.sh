#!/bin/sh
#
# Copyright (c) 2018 I2SE GmbH
#
# GPIO export script for Tarragon V0R3
#

GPIOS=""
GPIOS="$GPIOS 71"  # MX6ULL_PAD_LCD_DATA02__GPIO3_IO07, !MOTOR_1_DRV_IN1
GPIOS="$GPIOS 72"  # MX6ULL_PAD_LCD_DATA03__GPIO3_IO08, MOTOR_1_DRV_IN2
GPIOS="$GPIOS 73"  # MX6ULL_PAD_LCD_DATA04__GPIO3_IO09, MOTOR_2_DRV_IN1
GPIOS="$GPIOS 136"  # MX6ULL_PAD_SNVS_TAMPER8__GPIO5_IO08, MOTOR_2_DRV_IN2
GPIOS="$GPIOS 19"  # MX6UL_PAD_UART1_RTS_B__GPIO1_IO19, !MOTOR_1_FAULT
GPIOS="$GPIOS 25"  # MX6ULL_PAD_UART3_RX_DATA__GPIO1_IO25, !MOTOR_2_FAULT

GPIOS="$GPIOS 130"  # MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02, RELAY_2_SENSE VENTILATION
GPIOS="$GPIOS 76"  # MX6ULL_PAD_LCD_DATA07__GPIO3_IO12, RELAY_1_EN CONTACTOR
GPIOS="$GPIOS 77"  # MX6ULL_PAD_LCD_DATA08__GPIO3_IO13, RELAY_2_EN VENTILATION
GPIOS="$GPIOS 131"  # MX6ULL_PAD_SNVS_TAMPER3__GPIO5_IO03, RELAY_1_SENSE CONTACTOR

#GPIOS="$GPIOS 69"  # MX6ULL_PAD_LCD_DATA00__GPIO3_IO05, ENCLOSURE FAN ENABLE
GPIOS="$GPIOS 129"  # MX6ULL_PAD_SNVS_TAMPER1__GPIO5_IO01, ENCLOSURE FAN ROTATION DETECT

GPIOS="$GPIOS 18"  # MX6UL_PAD_UART1_CTS_B__GPIO1_IO18, RS485_1 DE
GPIOS="$GPIOS 120"  # MX6UL_PAD_CSI_DATA03__GPIO4_IO24, RS485_2 DE

GPIOS="$GPIOS 22"  # MX6ULL_PAD_UART2_CTS_B__GPIO1_IO22, ROTARY SWITCH 1_2
GPIOS="$GPIOS 23"  # MX6ULL_PAD_UART2_RTS_B__GPIO1_IO23, ROTARY SWITCH 1_4
GPIOS="$GPIOS 24"  # MX6ULL_PAD_UART3_TX_DATA__GPIO1_IO24, ROTARY SWITCH 1_8
GPIOS="$GPIOS 128"  # MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00, ROTARY SWITCH 1_1

GPIOS="$GPIOS 114"  # MX6UL_PAD_CSI_PIXCLK__GPIO4_IO18, ROTARY SWITCH 2_1
GPIOS="$GPIOS 92"  # MX6UL_PAD_LCD_DATA23__GPIO3_IO28, ROTARY SWITCH 2_2
GPIOS="$GPIOS 91"  # MX6UL_PAD_LCD_DATA22__GPIO3_IO27, ROTARY SWITCH 2_4
GPIOS="$GPIOS 90"  # MX6UL_PAD_LCD_DATA21__GPIO3_IO26, ROTARY SWITCH 2_8

GPIOS="$GPIOS 13"  # MX6ULL_PAD_JTAG_TDI__GPIO1_IO13, CP INVERT

GPIOS="$GPIOS 138"  # MX6ULL_PAD_BOOT_MODE0__GPIO5_IO10, CP_RST_POS_PEAK
GPIOS="$GPIOS 139"  # MX6ULL_PAD_BOOT_MODE1__GPIO5_IO11, CP_RST_NEG_PEAK

GPIOS="$GPIOS 84"  # MX6ULL_PAD_LCD_DATA15__GPIO3_IO20, PUSH_PULL_1
GPIOS="$GPIOS 85"  # MX6ULL_PAD_LCD_DATA16__GPIO3_IO21, PUSH_PULL_2
GPIOS="$GPIOS 86"  # MX6ULL_PAD_LCD_DATA17__GPIO3_IO22, PUSH_PULL_3
GPIOS="$GPIOS 87"  # MX6ULL_PAD_LCD_DATA18__GPIO3_IO23, PUSH_PULL_4
GPIOS="$GPIOS 88"  # MX6ULL_PAD_LCD_DATA19__GPIO3_IO24, PUSH_PULL_5
GPIOS="$GPIOS 89"  # MX6ULL_PAD_LCD_DATA20__GPIO3_IO25, PUSH_PULL_6

GPIOS="$GPIOS 135" # MX6ULL_PAD_SNVS_TAMPER7__GPIO5_IO07, !QCA7000_MAINS_RST
GPIOS="$GPIOS 80"  # MX6ULL_PAD_LCD_DATA11__GPIO3_IO16, !QCA7000_MAINS_BOOTLOADER
GPIOS="$GPIOS 81"  # MX6ULL_PAD_LCD_DATA12__GPIO3_IO17, !QCA7000_CP_RST
GPIOS="$GPIOS 82"  # MX6ULL_PAD_LCD_DATA13__GPIO3_IO18, !QCA7000_CP_BOOTLOADER

GPIOS="$GPIOS 121" # MX6UL_PAD_CSI_DATA04__GPIO4_IO25, DIG_IN_1
GPIOS="$GPIOS 122" # MX6UL_PAD_CSI_DATA05__GPIO4_IO26, DIG_IN_2
GPIOS="$GPIOS 124" # MX6UL_PAD_CSI_DATA07__GPIO4_IO28, DIG_IN_3
GPIOS="$GPIOS 123" # MX6UL_PAD_CSI_DATA06__GPIO4_IO27, DIG_IN_4
GPIOS="$GPIOS 116" # MX6UL_PAD_CSI_HSYNC__GPIO4_IO20, DIG_IN_5
GPIOS="$GPIOS 119" # MX6UL_PAD_CSI_DATA02__GPIO4_IO23, DIG_IN_6

GPIOS="$GPIOS 111" # MX6UL_PAD_NAND_CLE__GPIO4_IO15, BOARD_VARIANT_GPIO0
GPIOS="$GPIOS 109" # MX6UL_PAD_NAND_CE0_B__GPIO4_IO13, BOARD_VARIANT_GPIO1
GPIOS="$GPIOS 110" # MX6UL_PAD_NAND_CE1_B__GPIO4_IO14, BOARD_VARIANT_GPIO2
GPIOS="$GPIOS 112" # MX6UL_PAD_NAND_DQS__GPIO4_IO16, BOARD_VARIANT_GPIO3

GPIOS="$GPIOS 132" # MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04, MAINS PRESENT
GPIOS="$GPIOS 70"  # MX6UL_PAD_LCD_DATA01__GPIO3_IO06, EXT GPIO
GPIOS="$GPIOS 74"  # MX6UL_PAD_LCD_DATA05__GPIO3_IO10, STM32 BOOT0
GPIOS="$GPIOS 75"  # MX6UL_PAD_LCD_DATA06__GPIO3_IO11, !STM32 RESET

function usage {
        echo "Usage: $0 ACTION"
        echo "  ACTION = export | unexport"
        exit 1
}

case "$1" in
        "export")
                test $# -ne 1 && usage
                ;;
        "unexport")
                test $# -ne 1 && usage
                ;;
        *)
                usage
                ;;
esac

if [ "$1" == "export" ]; then

        for gpio in $GPIOS; do
                test -e /sys/class/gpio/gpio$gpio && continue
                echo "$gpio" > /sys/class/gpio/export
        done

elif [ "$1" == "unexport" ]; then

        for gpio in $GPIOS; do
                test ! -e /sys/class/gpio/gpio$gpio && continue
                echo "$gpio" > /sys/class/gpio/unexport
        done

fi

