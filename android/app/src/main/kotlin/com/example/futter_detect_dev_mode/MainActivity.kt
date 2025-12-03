package com.example.futter_detect_dev_mode   // ← keep your package name

import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent

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
                            Settings.Global.DEVELOPMENT_SETTINGS_ENABLED,
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
                    "openDevSetting" -> {
                        try {
                            val intent = Intent(Settings.ACTION_APPLICATION_DEVELOPMENT_SETTINGS)
                            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            startActivity(intent)
                            result.success(true)
                        } catch (e: Exception) {
                            e.printStackTrace()
                            result.error("error", e.message, null)
                        }
                    }

                    else -> result.notImplemented()
                }
            }
    }
    private fun isAdbEnabledBySystemProp(): Boolean {
        return try {
            val value = Class.forName("android.os.SystemProperties")
                .getMethod("get", String::class.java)
                .invoke(null, "ro.debuggable") as String

            value == "1"
        } catch (e: Exception) {
            false
        }
    }
}
