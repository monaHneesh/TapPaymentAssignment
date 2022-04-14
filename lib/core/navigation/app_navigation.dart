import 'dart:async';

import 'package:flutter/material.dart';



class AppNavigation {

  static navigateToPageWidget(BuildContext context, Widget widget) {
    try {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget,
          ));
    } catch (e) {
      rethrow;
    }

  }






}
