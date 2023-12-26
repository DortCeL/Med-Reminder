import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
   HomePage({super.key});

  //info about user is written here

  final user=FirebaseAuth.instance.currentUser!;

  //signUserOut method is declared here >_<
  void signUserOut(){
  FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout),
        ),
       ],
      ),
      body: Center(child: Text("Logged in as: "+user.email!,
        style: TextStyle(fontSize: 20),
      ),
      ),
    );
  }
}
