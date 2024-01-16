//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_reminder/components/sign_in_button.dart';
import 'package:medi_reminder/components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //instances of auth and firestore
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  //text editing controllers
  final email=TextEditingController();

  final password=TextEditingController();

  final confirpass=TextEditingController();

  //sign user UP method
  void signUserUp() async{

    //loading Screen
    showDialog(
      context:context,
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );



    //try creating the user
    try {
      //password and confirmed pass check
      if(password.text==confirpass.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        //saving user info in a separate doc
        // Get the current user
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Create a document reference for the user in the "Users" collection
          DocumentReference userDocRef = _firestore.collection("Users").doc(user.uid);

          // Set the user information in the document
          await userDocRef.set({
            'email': user.email,
            'uid':user.uid,
            // Add more fields as needed
          });
        }


      }else{
        //showing error message
        showErrorMessage("passwords don't match");
      }

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
      backgroundColor: Colors.white,
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
                  'Let\'s create an account!',
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

                const SizedBox(height: 10),

                //confirm password
                MyTextField(controller: confirpass, hintText: 'confirm password', obscureText: true),


                //forgot password

                const SizedBox(height: 20),

                //sign in button

                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),

                const SizedBox(height: 20),

                //Register

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
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
