import 'package:flutter/material.dart';
import 'package:futter_detect_dev_mode/services/developer_option_services.dart';

import '../components/dialog_component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>with WidgetsBindingObserver {
  bool devOptions = false;
  bool usbDebugging = false;
  bool isDialogOpen = false;
  @override
  void initState() {
    initCheck();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void initCheck() async {
    devOptions = await DeveloperOptionService.isDeveloperOptionEnabled();
    usbDebugging = await DeveloperOptionService.isUsbDebuggingEnabled();

    if (devOptions || usbDebugging) {
      isDialogOpen = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: CustomDialogBox(
              usbDebugging: usbDebugging,
            ),
          );
        },
      );
    }
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state)async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      print('App is in resumed state ');
      // Recheck developer settings
      bool dev = await DeveloperOptionService.isDeveloperOptionEnabled();
      bool usb = await DeveloperOptionService.isUsbDebuggingEnabled();

      // If both OFF → close dialog
      if (!dev && !usb && isDialogOpen) {
        Navigator.of(context, rootNavigator: true).pop(); // Close dialog
        isDialogOpen = false;
      }
    } else if (state == AppLifecycleState.paused) {
      print('App is in paused state (background)');
      // Perform actions when the app goes to the background, e.g., save data, pause tasks.
    } else if (state == AppLifecycleState.inactive) {
      print('App is in inactive state (e.g., system dialog opened)');
    } else if (state == AppLifecycleState.detached) {
      print('App is in detached state (e.g., app closed)');
    }
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Hello World")));
  }
}
