package com.fondeadora.smartlook_flutter_example

import io.flutter.app.FlutterApplication
import android.content.Context
import android.support.multidex.MultiDex

class ExampleApplication : FlutterApplication() {

  override fun attachBaseContext(base: Context) {
    super.attachBaseContext(base)
    MultiDex.install(this)
  }

}
