import 'dart:async';

import 'package:flutter/services.dart';

class SmartlookFlutter {
  static const MethodChannel _channel =
      const MethodChannel('com.fondeadora/smartlook_flutter');

  static Future<bool> setup(String apiKey) async {
    return _channel.invokeMethod('setup', {'apiKey': apiKey});
  }

  static Future<bool> start() async {
    return _channel.invokeMethod('start');
  }

  static Future<bool> stop() async {
    return _channel.invokeMethod('stop');
  }

  static Future<bool> startSensitiveMode() async {
    return _channel.invokeMethod('startSensitiveMode');
  }

  static Future<bool> stopSensitiveMode() async {
    return _channel.invokeMethod('stopSensitiveMode');
  }

  static Future<bool> identify(String userId) async {
    return _channel.invokeMethod('identify', {'userId': userId});
  }
}
