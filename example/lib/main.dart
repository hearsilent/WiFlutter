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
                    await _wiFlutterPlugin.connect();
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
