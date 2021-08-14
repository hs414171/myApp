import 'package:dsc_app/views/home.dart';
import 'package:dsc_app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool globalStatus = false;
  String globalUser = "";

  Future<void> checkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var localStatus = prefs.getBool('status');
    var localUser = prefs.getString('user');
    if (localStatus != null) {
      setState(() {
        globalStatus = localStatus;
        globalUser = localUser.toString();
      });
    }
  }

  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (globalStatus)
        ? HomePage(
            user: globalUser,
          )
        : Login();
  }
}
