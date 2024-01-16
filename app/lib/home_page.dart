import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_reminder/components/my_drawer.dart';
import 'package:sizer/sizer.dart';
import 'package:medi_reminder/constants.dart';
import 'package:medi_reminder/new_entry_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Info about the user is written here
  final user = FirebaseAuth.instance.currentUser!;

  // SignOut method is declared here >_<
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(

            title: Center(
              child: Text(
                "Logged in as: ${user.email ?? ""}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          drawer: MyDrawer(),
          body: Padding(
            padding: EdgeInsets.all(2.w), // h cng
            child: const Column(
              children: [
                TopContainer(),
                // Use Spacer instead of SizedBox
                Spacer(),
                Flexible(
                  child: BottomContainer(),
                ),
              ],
            ),
          ),
          floatingActionButton: InkResponse(
            onTap: () {
              // Go to new entry page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewEntryPage(),
                ),
              );
            },
            child: SizedBox(
              width: 10.w,
              height: 9.h,
              child: Card(
                color: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
                ),
                elevation: 4.0, // Add elevation for a subtle shadow effect
                child: Center(
                  child: Icon(
                    Icons.add_outlined,
                    color: KScaffoldColor,
                    size: 24.sp, // Adjust the size as needed
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            bottom: 1.h, // h cng
          ),
          child: const Text(
            'Worry less\nLive Healthier.',
            textAlign: TextAlign.start,
            style:TextStyle(
              color: Colors.deepPurple,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),



          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(bottom: 1.h), // h cng
          child: Text(
            'Welcome to Med Reminder.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        // Remove SizedBox
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 1.h), // h cng
          child: Text(
            '0',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        // Adjust the bottom padding as needed
        child: Text(
          'No Medicine?\nClick the green button below',
          textAlign: TextAlign.center,
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium,
        ),
      ),
    );
  }
}

