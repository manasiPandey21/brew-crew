import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

import '../../shared/constants.dart';
import '../../shared/loading.dart';

class SignIn extends StatefulWidget {
  // const SignIn({Key? key}) : super(key: key);
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading=false;
  String email = "";
  String password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return  loading?Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign in to Brew Crew"),
        actions: <Widget>[
          ElevatedButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.brown[400], // Background color
            ),
            icon: Icon(Icons.person),
            label: Text(
              "Register",
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key:_formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                  decoration:textInputDecoration.copyWith(hintText: "email"),
                  validator: (String? val) {
                if (val!=null && val.isEmpty) {
                  return "Cannot be empty";
                }
                return null;
              }, onChanged: (val) {
                setState(() {
                  email = val;
                });
              }),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration:textInputDecoration.copyWith(hintText: "Password"),
                  obscureText: true,
                  validator: (String? val) {
                    if (val!=null && val.length < 6) {
                      return "Enter a password 6+ char long";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  }),
              SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading=true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);

                      if (result == null) {
                        setState(() =>
                            error = "could u plz enter a correct credential");
                            loading=false;
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink, // Background color
                  ),
                  child: Text(
                    "Sign in",
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(
                height: 12.0,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
