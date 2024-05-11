import 'package:flutter/material.dart';

class LoginPendingScreen extends StatelessWidget{
  const LoginPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        )
    );
  }

}
