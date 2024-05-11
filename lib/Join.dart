import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Join extends StatelessWidget {
  Join({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("회원가입"),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 40, 30, 15),
              child: Row(children: [
                Expanded(
                  child: TextField(
                      decoration: InputDecoration(
                    labelText: '아이디',
                  )),
                ),
                ElevatedButton(
                  onPressed: () async {
                    print("중복확인 눌림!");
                    Set id_set = new Set<String>();
                    final db = FirebaseFirestore.instance;
                    await db.collection("user").get().then((event) {
                      for (var doc in event.docs) {
                        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                        id_set.add(data["id"]);
                      }
                    });
                    print(id_set);
                  },
                  child: Text("중복확인"),
                )
              ]),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                child: PasswordField()
            ),
            ElevatedButton(
                onPressed: () {
                  print("제출버튼이 눌림");
                },
                child: Text("제출"))
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: '비밀번호',
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ));
  }
}
