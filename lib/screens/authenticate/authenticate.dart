import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSgnIn=true;
  void toggleView(){
    setState(() =>showSgnIn=!showSgnIn);
  }
  @override
  Widget build(BuildContext context) {
    if (showSgnIn) {
      return SignIn(toggleView:toggleView);
    } else {
      return Register(toggleView:toggleView);
    }
  }
  }

