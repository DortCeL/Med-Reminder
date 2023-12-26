import 'package:flutter/material.dart';
class MyLogIn extends StatelessWidget {
  const MyLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:SafeArea(
          child:Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                Text('welcome to medi reminder',
                  style:TextStyle(color:Colors.deepPurple,
                  fontSize: 20,
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
