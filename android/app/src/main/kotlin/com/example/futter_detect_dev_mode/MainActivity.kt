package com.example.futter_detect_dev_mode   // ← keep your package name

import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val METHOD = "developerOption"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD)
            .setMethodCallHandler { call, result ->
                when (call.method) {

                    "isDevMode" -> {
                        val devEnabled = Settings.Secure.getInt(
                            contentResolver,
                            Settings.Global.DEVELOPMENT_SETTINGS_ENABLED,   // ✔ correct constant
                            0
                        ) == 1

                        result.success(devEnabled)
                    }

                    "isUsbDebugging" -> {
                        val usbEnabled = Settings.Secure.getInt(
                            contentResolver,
                            Settings.Secure.ADB_ENABLED,   // ✔ correct
                            0
                        ) == 1

                        result.success(usbEnabled)
                    }

                    else -> result.notImplemented()
                }
            }
    }
}
