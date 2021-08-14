import 'dart:convert';
import 'package:dsc_app/services/api.dart';
import 'package:dsc_app/views/home.dart';
import 'package:dsc_app/views/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: TextFormField(
                controller: _username,
                decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: Text('Login'),
                  onPressed: () async {
                    var res = await http.post(Uri.parse(APIRoutes.login),
                        headers: <String, String>{
                          'Content-Type': 'application/json'
                        },
                        body: jsonEncode(<String, dynamic>{
                          'username': _username.text,
                          'password': _password.text
                        }));

                    if (res.statusCode == 203) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                    user: _username.text,
                                  )));
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('status', true);
                      prefs.setString('user', _username.text);
                      prefs.setString('user', _username.text);
                    } else {
                      _username.clear();
                      _password.clear();
                      showDialogBox(context);
                    }
                  }),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Don\'t have an account? Try registering.')),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: Text('Register'),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Register()));
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}

showDialogBox(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Text("Invalid Credentials"),
    content: Text("The credentials you entered are wrong.\nPlease try again."),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
