
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DeveloperOptionService {
  // here we have initialize the platform channel
  static const platform = MethodChannel("developerOption");
  // this method is for checking whether the developer mode is enabled or not
  static Future<bool> isDeveloperOptionEnabled() async {
    try {
      // here we are invoking the method by passing the string as a identifier
      final result = await platform.invokeMethod("isDevMode");
      return result == true;
    } catch (e) {
      debugPrint(
        "Error While Calling :  isDeveloperOptionEnabled \n Reason == $e",
      );
      return false;
    }
  }

  // this method is for checking whether the usb debugging mode is enabled or not
  static Future<bool> isUsbDebuggingEnabled() async {
    try {
      // here we are invoking the method by passing the string as a identifier
      final result = await platform.invokeMethod("isUsbDebugging");
      return result == true;
    } catch (e) {
      debugPrint(
        "Error While Calling :  isUsbDebuggingEnabled \n Reason == $e",
      );
      return false;
    }
  }


}
