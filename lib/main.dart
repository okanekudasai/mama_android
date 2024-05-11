import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mama/schedule.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mama/firebase_options.dart';
import 'package:mama/util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'Join.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool is_pending = false;

  void _handle_login_button_press() async {
    setState(() {
      is_pending = true;
    });
  }
  void _handle_login_fail() {
    setState(() {
      is_pending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(!is_pending)
                Column(
                  children: [
                    const Text("어서오세요"),
                    const SizedBox(height: 40),
                    const TextField(
                        decoration: InputDecoration(
                          labelText: '아이디',
                        )
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: '비밀번호',
                        )
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        _handle_login_button_press();

                        bool success = false;

                        Future<bool> s = Util().make_bool_request(true);
                        s.then((val) {
                          if (val) {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScheduleScreen()
                              )
                            );
                          } else {
                            _handle_login_fail();
                          }
                        });
                      },
                      child: const Text("로그인"),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Join()));
                      },
                      child: Text("회원 가입")
                    )
                  ],
                ),
              if (is_pending)
                const CircularProgressIndicator(),
            ],
          )
        )
      )
    );
  }
}


