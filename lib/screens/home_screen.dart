import 'package:flutter/material.dart';
import 'package:futter_detect_dev_mode/services/developer_option_services.dart';

import '../components/dialog_component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool devOptions = false;
  bool usbDebugging = false;
  @override
  void initState() {
    initCheck();
    super.initState();
  }

  void initCheck() async {
    devOptions = await DeveloperOptionService.isDeveloperOptionEnabled();
    usbDebugging = await DeveloperOptionService.isUsbDebuggingEnabled();

    if (devOptions) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
           usbDebugging: usbDebugging,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Hello World")));
  }
}
