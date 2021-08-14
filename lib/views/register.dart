import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dsc_app/views/login.dart';
import 'package:dsc_app/services/api.dart';

class Register extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Register',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: TextFormField(
                  controller: _username,
                  decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: _number,
                  decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    child: Text('Submit'),
                    onPressed: () async {
                      var res = await http.post(Uri.parse(APIRoutes.register),
                          headers: <String, String>{
                            'Content-Type': 'application/json'
                          },
                          body: jsonEncode(<String, dynamic>{
                            'username': _username.text,
                            'password': _password.text,
                            'email': _email.text,
                            'mobile': _number.text
                          }));

                      if (res.statusCode == 201) {
                        // NAVIGATE TO LOGIN
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        _email.clear();
                        _username.clear();
                        _password.clear();
                        _number.clear();
                        showDialogBoxReg(context);
                      }
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Already Have an account? Try signing in.'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: Text('Login'),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

showDialogBoxReg(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Text("Invalid Credentials"),
    content:
        Text("The credentials you entered already exist.\nPlease try again."),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
