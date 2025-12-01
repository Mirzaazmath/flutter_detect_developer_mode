package com.example.futter_detect_dev_mode

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity(){

    private  val METHOD = "developerOption";
    override  fun configureFlutterEngine(flutterEngine:FlutterEngine){
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecuter.binaryMessenger,METHOD).setMethodCallHandler{
            call,result ->
            when(call.method){
                "isDevMode"->{
                    val  devEnabled = Settings.Secure.getInt(contentResoler,Settings.Global.DEVELOPMENT_SETTING_ENABLED,0)==1
                    result.success(devEnabled)
                }

                "isUsbDebugging"->{
                    val usbEnabled = Settings.Secure.getInt(contentResoler,Settings.Secure.ADB_ENABLED,0)==1
                    result.success(usbEnabled)
                }
            }
        }
    }

}
