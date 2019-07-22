#import "SmartlookFlutterPlugin.h"
#import <smartlook_flutter/smartlook_flutter-Swift.h>

@implementation SmartlookFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSmartlookFlutterPlugin registerWithRegistrar:registrar];
}
@end
