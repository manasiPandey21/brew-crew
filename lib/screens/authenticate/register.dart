import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../shared/constants.dart';
 class Register extends StatefulWidget {

   State<Register> createState() => _RegisterState();
   final Function toggleView;

   Register({required this.toggleView});
 }

 class _RegisterState extends State<Register> {
   final AuthService _auth=AuthService();
   final _formKey=GlobalKey<FormState>();
   bool loading=false ;
   String email="";
   String password="";
   String error="";
   @override
   Widget build(BuildContext context) {
     return loading?Loading() :Scaffold(
       backgroundColor: Colors.brown[100],
       appBar: AppBar(
         backgroundColor: Colors.brown[400],
         elevation: 0.0,
         title: Text("Register to Brew Crew"),
         actions: <Widget>[
           ElevatedButton.icon(
               onPressed: (){
                 widget.toggleView();
               },
               style: ElevatedButton.styleFrom(
                 primary: Colors.brown[400], // Background color
               ),
               icon: Icon(Icons.person),
               label: Text("SignIn")
           )
         ],
       ),
       body: Container(
         padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
         child:Form(
           key:_formKey,
           child: Column(
             children: <Widget>[
               SizedBox(height: 20.0),
               TextFormField(
                   decoration:textInputDecoration.copyWith(hintText: 'Email'),
                   validator: (String? val) {
                     if (val!=null && val.isEmpty) {
                       return "Cannot be empty";
                     }
                     return null;
                   },
                   onChanged: (val) {
                     setState(() {
                       email=val;
                     });
                   }
               ),
               SizedBox(height: 20.0),
               TextFormField(
                 decoration:textInputDecoration.copyWith(hintText: "Password"),
                   obscureText: true,
                   validator: (String? val) {
                     if (val!=null && val.length<6) {
                       return "Enter a password 6+ char long";
                     }
                     return null;
                   },
                   onChanged: (val) {
                     setState(() {
                       password=val;
                     });
                   }
               ),
               SizedBox(height: 20.0),
               ElevatedButton(
                   child: Text(
                     "Register",
                     style: TextStyle(color: Colors.white),
                   ),
                 style: ElevatedButton.styleFrom(
                   primary: Colors.pink, // Background color
                 ),
                   onPressed:() async{
                     if(_formKey.currentState!.validate()){
                       setState(() {
                         loading=true;
                       });
                       dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                       if(result==null){
                         setState(() => error="please supply a valid email");
                         loading=false;
                       }
                     }
                   },


               ),
               SizedBox(height: 12.0,),
               Text(
                 error,
                 style: TextStyle(color: Colors.red,fontSize: 14),
               )
             ],

           ),
         ),
       ),
     );
   }
 }
