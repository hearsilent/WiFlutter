# WiFlutter
[![pub](https://img.shields.io/pub/v/wiflutter)](https://pub.dev/packages/wiflutter)
[![license](https://img.shields.io/github/license/hearsilent/TagEditText.svg)](https://github.com/hearsilent/TagEditText/blob/main/LICENSE)

Control Wi-Fi in Flutter like a boss.

<img src="https://github.com/hearsilent/WiFlutter/raw/main/screenshots/like_a_boss.webp" height="500"> 

## Setup

The easiest way to add the **WiFlutter** library to your project is by adding it as a dependency to your `pubspec.yaml`
```yaml
dependencies:
  wiflutter: ^0.0.4
```

## Usage

Connect:
```dart
await _wiFlutterPlugin.connect(
  ssid: 'Diablo_III',
  password: 'st0x1_0xf_j0rdan',
  withInternet: false,
);
```

Disconnect:
```dart
await _wiFlutterPlugin.disconnect();
```

## Wi-Fi Challenge Rift Guide
|                      Description                      |      Android       |         iOS          |
| :---------------------------------------------------- | :----------------: | :------------------: |
| Connect/Disconnect.                                   | :white_check_mark: | :x:  				        |
| Wi-Fi Protected Access								                | :x:				         |  :x:  				        |
| Enable/Disable Wi-Fi                                  | :x:				         |  :x:  				        |
| Get Wi-Fi status                                      | :x:				         |  :x:  				        |
| Get Wi-Fi current SSID                                | :x:				         |  :x:  				        |
| Get Wi-Fi current IP                                  | :x:				         |  :x:  				        |


## Compatibility

Android LOLLIPOP 5.0+

## License

    MIT License

    Copyright (c) 2023 HearSilent

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

