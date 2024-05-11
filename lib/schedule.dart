import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScheduleScreen extends StatelessWidget {
  DateTime? currentTime;
  bool close_flag = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!close_flag) {
          PressFirstBack(didPop);
        }
        else {
          if (currentTime!.difference(DateTime.now()) > const Duration(seconds: 1)) {
            PressFirstBack(didPop);
          } else {
            SystemNavigator.pop();
          }
        }

      },

      child: Scaffold(
        body: Center(
          child: Text("Mario"),
        )
      ),
    );
  }
  void PressFirstBack(bool didPop) {
    print("뒤로가기 버튼 눌림 : " + didPop.toString());
    close_flag = true;
    Timer(Duration(seconds: 1), () {
      close_flag = false;
    });
    currentTime = DateTime.now();
    Fluttertoast.showToast(
      msg: "정말로 종료하겠습니까?!!!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      fontSize: 14.0,
    );
  }
}
