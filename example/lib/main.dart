import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:wiflutter/wiflutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
<<<<<<< HEAD
  final _wiFlutterPlugin = WiFlutter();
=======
  String _platformVersion = 'Unknown';
  final _wiflutterPlugin = Wiflutter();
>>>>>>> 1d0974c (Create flutter plugin project)

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
=======
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _wiflutterPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
>>>>>>> 1d0974c (Create flutter plugin project)
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
<<<<<<< HEAD
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await _wiFlutterPlugin.connect(
                      ssid: 'Diablo_III',
                      password: 'st0x1_0xf_j0rdan',
                      withInternet: false,
                      timeoutInSeconds: 40,
                    );
                  },
                  child: const Text("Connect")),
              ElevatedButton(
                  onPressed: () async {
                    await _wiFlutterPlugin.disconnect();
                  },
                  child: const Text("Disconnect")),
            ],
          ),
=======
          child: Text('Running on: $_platformVersion\n'),
>>>>>>> 1d0974c (Create flutter plugin project)
        ),
      ),
    );
  }
}
