import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project_mobile/models/api.dart';
import 'package:project_mobile/pages/Homepage.dart';

class LoginPage extends StatefulWidget {
  static const buttonSize = 60.0;

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _string = '';
  final String _password = '123456';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(color: Colors.purple.shade50, boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(2.0, 5.0),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            )
          ]),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.lock_outline,
                              size: 80.0,
                              color: Colors.black54,
                            ),
                            Text(
                              'กรุณาใส่รหัสผ่าน',
                              style: TextStyle(
                                  fontSize: 25.0, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0; i < _string.length; i++)
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  width: 35.0,
                                  height: 35.0,
                                ),
                              ),
                            for (var i = 0;
                                i < (_password.length - _string.length);
                                i++)
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black38,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  width: 35.0,
                                  height: 35.0,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 1; i <= 3; i++) buildButton(i),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 4; i <= 6; i++) buildButton(i),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 7; i <= 9; i++) buildButton(i),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _string = "";
                            });
                          },
                          borderRadius:
                              BorderRadius.circular(LoginPage.buttonSize / 2),
                          child: Container(
                            alignment: Alignment.center,
                            width: LoginPage.buttonSize,
                            height: LoginPage.buttonSize,
                            child: const Icon(Icons.close),
                          ),
                        ),
                      ),
                      buildButton(0),
                      buildButton(-1),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextButton(
                      child: const Text('ลืมรหัสผ่าน'),
                      style: TextButton.styleFrom(
                        primary: Colors.black38,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(int num) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () async {
          if (num == -1) {
            setState(() {
              var length = _string.length;
              _string = _string.substring(0, length - 1);
            });
          } else {
            if (_string.length < 6) {
              setState(() {
                _string = '$_string$num';
              });
            }
          }
          final url = Uri.parse('https://cpsu-test-api.herokuapp.com/login');
          final response = await http.post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'pin': _string}),
          );
          var json = jsonDecode(response.body);
          var apiResult = Api.fromJson(json);

          if (apiResult.data == true && _string == _password) {
            setState(() {
              _string = "";
            });

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (_password != _string && _string.length == 6) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Incorrect PIN'),
                    content: const Text('Please try again'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      )
                    ],
                  );
                });
            _string = "";
          }
        },
        borderRadius: BorderRadius.circular(LoginPage.buttonSize / 2),
        child: Container(
          decoration: (num == -1)
              ? null
              : BoxDecoration(
                  color: Colors.purple.shade100,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
          alignment: Alignment.center,
          width: LoginPage.buttonSize,
          height: LoginPage.buttonSize,
          child: (num == -1)
              ? const Icon(Icons.backspace_outlined)
              : Text(
                  '$num',
                  style: const TextStyle(
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
        ),
      ),
    );
  }
}
