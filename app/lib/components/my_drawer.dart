import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_reminder/components/BMIpage.dart';
import 'package:medi_reminder/services/chat/chatPage.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //logo
          DrawerHeader(child: Center(
            child: Icon(
                Icons.settings_accessibility,
              color: Theme.of(context).colorScheme.primary,
              size: 64,
            ),
          ),
          ),
          
          //home
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: const Text("H O M E"),
              leading: Icon(Icons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: (){
                //pop the drawer
                Navigator.pop(context);
              },
            ),
          ),

          //drawer
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: const Text("C H A T"),
              leading:  Icon(Icons.chat_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: (){
                //pop the drawer
                Navigator.pop(context);

                //navigation to the BMI PAGE
                Navigator.push(context, MaterialPageRoute(builder: (context)=>chatPage(),
                ),
                );
              },
            ),
          ),

          //logout

          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: const Text("B M I Calculator"),
              leading:  Icon(Icons.calculate,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: (){
                //pop the drawer
                Navigator.pop(context);

                //navigation to the BMI PAGE
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const BMIpage(),
                ),
                );
              },
            ),
          ),
          //BMI
          const SizedBox(height: 300),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: Icon(Icons.logout_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: signUserOut,
            ),
          ),
        ],
      ),
    );
  }
}
