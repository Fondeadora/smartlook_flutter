package com.fondeadora.smartlook_flutter

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import com.smartlook.sdk.smartlook.Smartlook

class SmartlookFlutterPlugin: MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "com.fondeadora/smartlook_flutter")
      channel.setMethodCallHandler(SmartlookFlutterPlugin())
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when {
      call.method == "setup" -> {
        val apiKey = call.argument<String>("apiKey")

        if (apiKey.isNullOrEmpty()) {
          result.error("422", "Invalid API key", "API key must not be empty");
          return
        }
        
        Smartlook.setup(apiKey)
        result.success(true)
      }
      call.method == "start" -> {
        Smartlook.startRecording()
        result.success(true)
      }
      call.method == "stop" -> {
        Smartlook.stopRecording()
        result.success(true)
      }
      call.method == "startSensitiveMode" -> {
        Smartlook.startFullscreenSensitiveMode()
        result.success(true)
      }
      call.method == "stopSensitiveMode" -> {
        Smartlook.stopFullscreenSensitiveMode()
        result.success(true)
      }
      call.method == "identify" -> {
        val userId = call.argument<String>("userId")

        if (userId.isNullOrEmpty()) {
          result.error("422", "Invalid identifier", "User ID must not be empty");
          return
        }

        Smartlook.setUserIdentifier(userId)
        result.success(true)
      }
      else -> {
        result.notImplemented()
      }
    }
  }
}
