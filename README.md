<a href="https://pub.dev/packages/wiflutter">
  <p align="center">  
    <img width="500px" src="screenshots/wiflutter_logo.webp">
  </p>
</a>

<p align="center">
  <a href="https://pub.dev/packages/wiflutter">
    <img src="https://img.shields.io/pub/v/wiflutter" alt="pub" />
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/github/license/hearsilent/WiFlutter.svg" alt="license"/>
  </a>
</p>

---

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
| Connect/Disconnect                                    | :white_check_mark: | :x:  				        |
| Fuzzing Connect                                       | :x:	               | :x:  				        |
| Wi-Fi Protected Access								                | :x:				         | :x:  				        |
| Enable/Disable Wi-Fi                                  | :x:				         | :x:  				        |
| Get Wi-Fi status                                      | :x:				         | :x:  				        |
| Get Wi-Fi current SSID                                | :x:				         | :x:  				        |
| Get Wi-Fi current IP                                  | :x:				         | :x:  				        |


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

