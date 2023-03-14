import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';


class Home extends StatelessWidget {
 // Home({Key? key}) : super(key: key);
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      //doubt
      value:DatabaseService().brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
                onPressed: () async{
                  await _auth.SignOut();
                },
                icon: Icon(Icons.person),
                label: Text("logOut")
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
