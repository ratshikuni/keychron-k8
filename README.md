# Keychron K8 Reverse Engineering

These are unofficial firmwares, please use at your own discretion.

# Keychron K8

### NOTE: This code in this repository may be outdated. Please see the [SonixQMK repository](https://github.com/SonixQMK/qmk_firmware) for the latest Keychron firmwares.

### [Direct link to all Keychron firmwares folder here](https://github.com/SonixQMK/qmk_firmware/tree/sn32_master/keyboards/keychron)

___
This fork brings QMK to the Keychron K8.

If you have never touched QMK before: https://docs.qmk.fm/#/newbs. Make sure you have QMK MSYS set up.

**Progress:**
- QMK custom keymaps are working properly
- RGB works properly, no more flickering
- Bluetooth does not work, currently waiting for QMK to release an official Bluetooth API
- VIA does not work, currently no EEPROM support

**Setup repo + dependencies**
1. Clone this repository: https://github.com/SonixQMK/qmk_firmware, and make sure you are on the sn32_master branch
2. In the root of the `qmk_firmware` directory, run these commands:
   - `git submodule add https://github.com/SonixQMK/ChibiOS-Contrib.git`
   - `make git-submodule`
   - `util/qmk_install.sh`
3. You should be able to compile firmwares now:
   - Open QMK_MSYS, cd to the qmk_firmware directory root, then run these commands:
      - `qmk setup` (if you haven't already)
      - `make keychron/k8/rgb/ansi:default`

**Instructions on how to flash QMK to the K8:**
1. Customize your keymap and compile your firmware
   - Keymaps can be found under `keyboards/keychron/k8/keymaps`
   - For example, if you want a firmware for the Keychron K8 ANSI, edit the `keymap.c` under `keyboards/keychron/k8/keymaps/ansi`
   - Then run `make keychron/k8/rgb/ansi:ansi` in QMK_MSYS
2. Download this flashing tool and run it: https://github.com/qmk/qmk_firmware/files/5862715/SONiX_USB_MCU_ISP_Tool_V2.3.1.7-.zip
3. Click 'Load File' and select `SN32F24xB` on the right, then choose your *.hex QMK firmware file
4. VID - `0C45`, PID - `7040`
5. Put your K8 into DFU/bootloader mode:
    - Remove the spacebar and short the `BOOT` pin to `P7` pin
    - Note: There are 5 pins on the left of the spacebar switch, `BOOT` and `P7` are the two rightmost pins
6. Connect your K8 to your computer
7. Click 'Flash' in the Sonix flashing tool
8. Enjoy


## TODO List - QMK support
- [x] Ability to safely flash bootloader
- [x] Ability to revert to factory firmware
- [x] Confirm Chibios functionality
- [x] Get QMK Working
- [x] Get RGB working
- [ ] Get VIA working (currently no EEPROM support, which is required for VIA)
- [ ] Bluetooth functionality (currently waiting on official Bluetooth support from QMK)

## Chips
* Main MCU - HFD2201KBA - appears to be based on/clone of [SONIX SN32F24xB](http://www.sonix.com.tw/article-tw-4315-30347)

![mcu-hfd](./img/mcu-hfd.png)

* Bt module [CYPRESS CYW20730A2KFBG](https://www.infinite-electronic.ru/datasheet/2a-CYW20730A2KFBG.pdf)

![k4-bt](./img/k4-bt.png)

* Charge IC - TPU5000

![k4-charge](./img/k4-charge.png)

## Key Matrix & MCU
![Keyboard-layout](./img/k8-layout.png)

![Key-Matrix](./img/k8-wiring.png)

## MCU-Diagram - Keyboard matrix diagram on the MCU

| --- | col | C0 | C1 | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9 | C10 | C11 | C12 | C13 | C14 | C15 | C16 |
| --- | --- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --- | --- | --- | --- | --- | --- | --- |
| row | pin | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 34 | 35 | 36  | 37  | 38  | 39  | 40  | 41  | 42  |
| R0  | 64  |    |    |    |    |    |    |    |    |    |    |     |     |     |     |     |     |     |
| R1  | 63  |    |    |    |    |    |    |    |    |    |    |     |     |     |     |     |     |     |
| R2  | 62  |    |    |    |    |    |    |    |    |    |    |     |     |     |     |     |     |     |
| R3  | 61  |    |    |    |    |    |    |    |    |    |    |     |     |     |     |     |     |     |
| R4  | 60  |    |    |    |    |    |    |    |    |    |    |     |     |     |     |     |     |     |
| R5  | 59  |    |    |    |    |    |    |    |    |    |    |     |     |     |     |     |     |     |

## MCU-Diagram - LED matrix

|   g  |   b  |   r  |  --- |  --- |  --- | col | C0 | C1 | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9 | C10 | C11 | C12 | C13 | C14 | C15 | C16 |
|  --- |  --- |  --- |  --- |  --- |  --- | --- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --  | --  | --  | --  | --  | --  | --  |
|  ch1 |  ch2 |  ch3 |  pin |  pin |  pin | pin | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 34 | 35 | 36  | 37  | 38  | 39  | 40  | 41  | 42  |
|  Q13 |  Q7  |  Q1  |  01  |  02  |  04  | --- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --- | --- | --- | --- | --- | --- | --- |
|  Q14 |  Q8  |  Q2  |  05  |  06  |  07  | --- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --- | --- | --- | --- | --- | --- | --- |
|  Q15 |  Q9  |  Q3  |  08  |  09  |  10  | --- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --- | --- | --- | --- | --- | --- | --- |
|  Q16 |  Q10 |  Q4  |  11  |  12  |  13  | --- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --- | --- | --- | --- | --- | --- | --- |
|  Q17 |  Q11 |  Q5  |  14  |  15  |  47  | --- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --- | --- | --- | --- | --- | --- | --- |
|  Q18 |  Q12 |  Q6  |  50  |  49  |  48  | --- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --- | --- | --- | --- | --- | --- | --- |


## MCU-Diagram - mac/win and bt/off/cable dip switches

- Bluetooth / O / Cable Mode: pin 57
- Win - Android / Mac - iOS Mode: pin 58


## MCU Pinout - SN32F248BF
![MCU-Pins](./img/MCU_SN32F248BF.png)

## Bluetooth module
![k4-bluetooth-CYW20730.png](./img/K4-bt-CYW20730.png)

seems to be wired like the Blitzwolf BW-KB1(https://github.com/IslamAlam/blitzwolf-bw-kb-1)
