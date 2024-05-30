import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

extension FlushBarSuccessMessage on BuildContext {
  void flushBarSuccessMessage({required String message}) {
    showFlushbar(
        context: this,
        flushbar: Flushbar(
        duration: const Duration(seconds: 3),
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(10),

    backgroundGradient: LinearGradient(
    colors: [
    Colors.green.shade500,
    Colors.green.shade300,
    Colors.green.shade100
    ],
    stops: const [0.4, 0.7, 1],
    ),
    boxShadows: const [
    BoxShadow(
    color: Colors.black45,
    offset: Offset(3, 3),
    blurRadius: 3,
    ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    message: message,
    messageSize: 17,
    )..show(this));
  }
}

