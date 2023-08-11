import 'package:flutter/material.dart';
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
  final _wiFlutterPlugin = WiFlutter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
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
        ),
      ),
    );
  }
}
