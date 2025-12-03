import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/developer_option_services.dart';

class CustomDialogBox extends StatefulWidget {
  final bool usbDebugging;
  const CustomDialogBox({super.key, required this.usbDebugging});

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding,
            ),
            margin: const EdgeInsets.only(top: Constants.avatarRadius),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
            ),
            child: Column(
              spacing: 20,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
               Container(
                 padding:EdgeInsets.all(20),
                 decoration:BoxDecoration(
                color: Colors.grey.shade100,
                   borderRadius: BorderRadius.circular(20)
            ),
                 child:  Text("Developer Options ${widget.usbDebugging? "and USB Debugging":""} is enabled.\n\n"
                     "For security reasons, please turn ${widget.usbDebugging? "them":"it"}  OFF to continue.",style: Theme.of(context).textTheme.titleSmall,),
               ),

                Row(
                  spacing: 10,
                  children: [
                    Expanded(child: GestureDetector(
                      onTap: () async{
                        await DeveloperOptionService.openDevSetting(widget.usbDebugging);
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueAccent,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Open Setting",
                          style:  Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),),
                    Expanded(child: GestureDetector(
                      onTap: () {
                        // For entire app to close
                        SystemNavigator.pop();
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Close App",
                          style:  Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),)
                  ],
                )
              ],
            ),
          ),
          Positioned(
            left: Constants.padding,
            right: Constants.padding,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 40,
              child: Center(
                child: Icon(
                  Icons.security_update_warning,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
