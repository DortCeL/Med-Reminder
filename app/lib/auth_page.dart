import 'dart:developer';
import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/login_page.dart';
import 'home_page.dart';
import 'log_in_or_register_page.dart';
class AuthentPage extends StatelessWidget {
  const AuthentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            // user is logged in
              if(snapshot.hasData){
                return HomePage();
              }
              else{
                return LoginOrRegisterPage();
              }

            //user not logged in
          }

      ),

    );
  }
}
