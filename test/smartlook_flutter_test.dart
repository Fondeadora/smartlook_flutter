import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartlook_flutter/smartlook_flutter.dart';

void main() {
  group('smartlook_flutter', () {
    const MethodChannel channel =
        MethodChannel('com.fondeadora/smartlook_flutter');
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);

        switch (methodCall.method) {
          case 'setup':
            return true;
          case 'start':
            return true;
          case 'stop':
            return true;
          case 'startSensitiveMode':
            return true;
          case 'stopSensitiveMode':
            return true;
          case 'identify':
            return true;
          default:
            return null;
        }
      });

      log.clear();
    });

    tearDown(() {
      channel.setMockMethodCallHandler(null);
    });

    test('setup', () async {
      expect(await SmartlookFlutter.setup('api_key'), true);
      expect(await SmartlookFlutter.start(), true);
      expect(await SmartlookFlutter.stop(), true);
      expect(await SmartlookFlutter.startSensitiveMode(), true);
      expect(await SmartlookFlutter.stopSensitiveMode(), true);
      expect(await SmartlookFlutter.identify('uuid'), true);
      expect(log, <Matcher>[
        isMethodCall('setup', arguments: {'apiKey': 'api_key'}),
        isMethodCall('start', arguments: null),
        isMethodCall('stop', arguments: null),
        isMethodCall('startSensitiveMode', arguments: null),
        isMethodCall('stopSensitiveMode', arguments: null),
        isMethodCall('identify', arguments: {'userId': 'uuid'})
      ]);
    });
  });
}
