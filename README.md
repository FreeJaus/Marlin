This is just a fork. Check the official repo at [MarlinFirmware/Marlin](https://github.com/MarlinFirmware/Marlin).

# Possible contributions

## Joystick support, as a replacement for rotatory encoders and/or buttons

- [MarlinFirmware/Marlin#2775](https://github.com/MarlinFirmware/Marlin/issues/2775)
- [MarlinFirmware/Marlin#280](https://github.com/MarlinFirmware/Marlin/pull/2803)
- [MarlinFirmware/Marlin#2912](https://github.com/MarlinFirmware/Marlin/issues/2912)

Among 16 available ADC pins, only five seem to be used in the GT2560A+: ADC0, ADC1, ADC8, ADC9, ADC10. The most interesting pins to be used for a joystick are ADC2 and ADC3, 95 and 94 respectively. These are not shared with any other functionality, so no limitation is introduced.

## LCD

- Bootscreen for alphanumeric dot matrix LCDs, such as those controlled by HD44780, KS006... (16x2, 16x4, 20x2, 20x4...).
- Menu customization/customizer.
- References:
  - https://github.com/MarlinFirmware/Marlin/pull/7832
  - https://www.youtube.com/watch?v=3fGHgzZqaGs
  - http://marlinfw.org/tools/u8glib/converter.html

## Enable interrupts for end-stops and sensors

> Enable this feature if all enabled endstop pins are interrupt-capable. This will remove the need to poll the interrupt pins, saving many CPU cycles.

https://github.com/MarlinFirmware/Marlin/issues/5484

Endstop connectors in the GT2560A+ are connected to pins 58, 60, 72, 74, 76 and 78. None of these is interrupt-capable. However, there are ten PCINT pins available and unused: 65-69 and 82-86. Therefore, up to eight bridges should be soldered to move those connections to interrupt-capable pins. Shall paths to original pins be cut, those could be reused.

## Wireless (not wifi) control with NRF24L01+ + (CH340 | attiny)

- https://github.com/BastilleResearch/mousejack/issues/19
- https://github.com/insecurityofthings/uC_mousejack
- http://forum.arduino.cc/index.php?topic=410574.15

## marlin-config

[akaJes/marlin-config](https://github.com/akaJes/marlin-config) is a very interesting project, but dependencies (nodejs, electron, 'native' git...) make it uneasy to install. It's be useful to have a docker image, so that only drivers need to be installed on the host.

### Offset viewer

Visual feedback of bed, nozzle, sensor... offsets.
