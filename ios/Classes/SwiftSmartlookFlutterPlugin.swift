import Flutter
import UIKit
import Smartlook
import SwiftTryCatch

public class SwiftSmartlookFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.fondeadora/smartlook_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftSmartlookFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    SwiftTryCatch.try({
      
      switch(call.method){
        
      case "setup":
        if let args = call.arguments as? [String: Any],
          let apiKey = args["apiKey"] as? String {
          
          Smartlook.setup(withKey: apiKey)
        } else {
          result(false)
          return
        }
        
      case "identify":
        if let args = call.arguments as? [String: Any],
          let userId = args["userId"] as? String,
          let email = args["email"] as? String,
          let name = args["name"] as? String {
          Smartlook.setUserIdentifier(userId)
          Smartlook.setSessionProperty(value: email, forName: "Email")
          Smartlook.setSessionProperty(value: name, forName: "Name")
        } else {
          result(false)
          return
        }
        
      case "start":
        Smartlook.startRecording()
        
      case "stop":
        Smartlook.stopRecording()
        
      default:
        result(FlutterMethodNotImplemented)
      }
      
    }, catch: { (error) in
      result(FlutterError(code: "",
                          message: error?.description,
                          details: nil))
      return
      
    }, finally: nil)
    
    result(true)
  }
}
