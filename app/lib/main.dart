import 'package:flutter/material.dart';
import 'package:untitled3/auth_page.dart';
import 'package:untitled3/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:untitled3/constants.dart';
import 'package:sizer/sizer.dart';
//import 'pages/home_page.dart';


void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      home: AuthentPage(),
    );
  }
}



