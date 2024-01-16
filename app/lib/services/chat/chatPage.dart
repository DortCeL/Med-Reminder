//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:medi_reminder/auth_page.dart';
import 'package:medi_reminder/components/my_drawer.dart';
import 'package:medi_reminder/services/chat/chat_services.dart';
import 'package:medi_reminder/components/user_tile.dart';
import 'package:medi_reminder/services/chat/chatting_page.dart';
import 'package:medi_reminder/login_page.dart';
class chatPage extends StatelessWidget {
  chatPage({super.key});

  //chat service

  final ChatService _chatService=ChatService();
  final AuthentPage _authService=AuthentPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.deepPurple,
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: _buildUserList(),
    );
  }

  //build a list of users except the current user
  Widget _buildUserList(){
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder:(context,snapshot){
          //error
          if(snapshot.hasError){
            return const Text("Error");
          }

          //loading
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Text("loading..");
          }
          //return list View
          return ListView(
            children: snapshot.data!.map<Widget>((userData) => _builderListItem(userData,context))
                .toList(),
          );
      },
    );
  }

  //build individual list tile for users
  Widget _builderListItem(Map<String,dynamic>userData,BuildContext context){
      //display all users expcet current user
    if(userData["email"]!=_authService.getCurrentUser()!.email){
      return UserTile(
        text: userData["email"],
        onTap: (){
          //tap on user will go to chatting page
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChattingPage(
            receiverEmail: userData["email"],
            receiverID: userData["uid"],
          ),
          ),
          );
        },
      );
    }else{
      return Container();
    }
  }
}
