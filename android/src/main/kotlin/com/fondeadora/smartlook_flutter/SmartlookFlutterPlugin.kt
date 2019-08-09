package com.fondeadora.smartlook_flutter

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import com.smartlook.sdk.smartlook.Smartlook
import android.app.Activity
import org.json.JSONObject

class SmartlookFlutterPlugin constructor(private val activity: Activity): MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "com.fondeadora/smartlook_flutter")
      channel.setMethodCallHandler(SmartlookFlutterPlugin(registrar.activity()))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    try {
      when (call.method) {
        "setup" -> {
          val apiKey = call.argument<String>("apiKey")

          if (apiKey.isNullOrEmpty()) {
            result.error("", "Invalid API key", "API key must not be empty")
            return
          }

          Smartlook.setup(apiKey, true)
        }
        "start" -> {
          Smartlook.startRecording()
        }
        "stop" -> {
          Smartlook.stopRecording()
        }
        "identify" -> {
          val userId = call.argument<String>("userId")
          val email = call.argument<String>("email")
          val name = call.argument<String>("name")

          if (userId.isNullOrEmpty() || email.isNullOrEmpty() || name.isNullOrEmpty()) {
            result.error("", "Invalid identifier", "User ID, email and name must not be empty")
            return
          }

          Smartlook.setUserIdentifier(userId, JSONObject("{ \"Email\": \"$email\", \"Name\": \"$name\" }"))
        }
        else -> {
          result.notImplemented()
        }
      }
    } catch (e: Exception) {
      result.error("", e.message, null)
      return
    }

    result.success(true)
  }
}
