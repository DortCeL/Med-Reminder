import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pageinfo1/constants.dart';
import 'package:sizer/sizer.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Med Reminder',
        theme: ThemeData.dark().copyWith(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: KScaffoldColor,
          //appbar theme
          appBarTheme: AppBarTheme(
              toolbarHeight: 7.h,
              backgroundColor: KScaffoldColor,
              elevation: 0,
              iconTheme: IconThemeData(
                color: KSecondaryColor,
                size: 20.sp,
              ),
              titleTextStyle: GoogleFonts.mulish(
                color: KTextColor,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.normal,
                fontSize: 16.sp,
              )),
          textTheme: TextTheme(
            headlineMedium: TextStyle(
              fontSize: 28.sp,
              color: KSecondaryColor,
              fontWeight: FontWeight.w400,
            ),
            headlineLarge: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: KTextColor,
            ),
            headlineSmall:
                GoogleFonts.poppins(fontSize: 12.sp, color: KTextColor),
            labelMedium: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: KTextColor,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: KTextLightColor,
                  width: 0.7,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: KTextColor,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              )
            ),
          timePickerTheme: TimePickerThemeData(
            backgroundColor: KScaffoldColor,
            hourMinuteColor: KTextColor,
            hourMinuteTextColor: KScaffoldColor,
            dayPeriodColor: KTextColor,
            dayPeriodTextColor: KScaffoldColor,
            dialBackgroundColor: KTextColor,
            dialTextColor: KScaffoldColor,
            entryModeIconColor: KOtherColor,
            dayPeriodTextStyle: GoogleFonts.aBeeZee(
              fontSize: 8.sp,
            ),
          ),
        ),
        home: const HomePage(),
      );
    });
  }
}
