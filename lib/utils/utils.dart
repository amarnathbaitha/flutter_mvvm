import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        forwardAnimationCurve: Curves.easeIn,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        titleColor: Colors.black,
        messageColor: Colors.black,
        borderRadius: BorderRadius.circular(10),
      )..show(context),
    );
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("SnackBar")));
  }

  static void filedFocusChanged(
    BuildContext context,
    FocusNode current,
    FocusNode next,
  ) {
     current.unfocus();
     FocusScope.of(context).requestFocus(next);
  }
}
