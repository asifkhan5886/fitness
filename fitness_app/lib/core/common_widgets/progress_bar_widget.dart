import 'package:flutter/material.dart';

class ProgressDialog {
  static final GlobalKey<State> _keyLoader = GlobalKey<State>();

  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Center(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  ),
                ),
              ));
        });
  }

  static hideLoadingDialog(BuildContext context) {
    if (context != null) {
      Navigator.of(context, rootNavigator: false).pop();
    } else {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: false).pop();
    }
  }
}
