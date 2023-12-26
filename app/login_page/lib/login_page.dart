//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/components/sign_in_button.dart';
import 'package:untitled3/components/text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

    const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    //text editing controllers
  final email=TextEditingController();

  final password=TextEditingController();

  //after log in method
    void logUserIn() async{

      //loading Screen
      showDialog(
        context:context,
        builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
         );
        },
      );



      //try Sign in screen
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        // pop the loading circle
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop the loading circle
        Navigator.pop(context);

        //showing error message
        showErrorMessage(e.code);
      }
    }

  // wrong password/email message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return  AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
               const SizedBox(height: 50),
            
              //logo
              const Icon(
                Icons.lock,
                size: 100,
                color: Colors.deepPurple,
            
              ),
                const SizedBox(height: 50),
            
                //message
              const Text(
                'Welcome to your Medi Reminder!',
                style: TextStyle(color: Colors.black,
                fontSize: 16,
                ),
              ),
            
              const SizedBox(height: 20),
            
            
                //username
                MyTextField(controller: email, hintText: 'email', obscureText: false),
            
              const SizedBox(height: 10),
            
            
              //password
              MyTextField(controller: password, hintText: 'password', obscureText: true),
            
              //forgot password
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'forgot password?',
                      style: TextStyle(
                          color:Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            
                const SizedBox(height: 20),
            
              //sign in button
            
             MyButton(
               text: "Log in",
                onTap: logUserIn,
            ),
            
                const SizedBox(height: 20),
            
              //Register

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
            
            ],),
          ),
        ),
      ),
    );
  }
}
