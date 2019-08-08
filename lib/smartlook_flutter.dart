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

  static Future<bool> identify(String userId, String email, String name) async {
    return _channel.invokeMethod('identify', {'userId': userId, "email": email, "name": name});
  }
}
