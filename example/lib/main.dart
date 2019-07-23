import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:smartlook_flutter/smartlook_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isRecording = false;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    try {
      await SmartlookFlutter.setup("");
    } on PlatformException catch(exception) {
      print(exception.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Smartlook example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(isRecording ? "Recording..." : "Stopped"),
            ),
            Center(
              child: OutlineButton(
                onPressed: () async {
                  if(await SmartlookFlutter.start()) {
                    setState(() {
                      this.isRecording = true;
                    });
                  }
                },
                child: Text('Start recording'),
                )
            ),
            Center(
              child: OutlineButton(
                onPressed: () async {
                  if(await SmartlookFlutter.stop()){
                    setState(() {
                      this.isRecording = false;
                    });
                  }
                },
                child: Text('Stop recording'),
                )
            ),
            Center(
              child: Container(
                width: 200.0,
                child: TextField(
                  decoration: InputDecoration(labelText: "Input"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
