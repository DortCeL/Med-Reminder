//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:medi_reminder/auth_page.dart';
import 'package:medi_reminder/components/chat_bubble.dart';
import 'package:medi_reminder/components/text_field.dart';
import 'package:medi_reminder/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medi_reminder/auth_page.dart';

class ChattingPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;



   ChattingPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,

  });
  //text controller
  final TextEditingController _messageController=TextEditingController();

  //chat and auth services
  final ChatService _chatService=ChatService();
  final AuthentPage _authService=AuthentPage();

  //send message
  void sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          //display all message
          Expanded(
            child: _buildMessageList(),
          ),
          //user input
          _buildUserInput(),

        ],
      ),
    );

  }

  //build message list
  Widget _buildMessageList(){
    String senderID=_authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID,senderID ),
        builder: (context,snapshot){
          //errors
        if(snapshot.hasError){
          return const Text("error");
        }
          //loading
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Text("loading");
        }
          //return view list
        return ListView(
          children:
          snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
        },
    );
  }
  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String,dynamic>data=doc.data() as Map<String,dynamic>;
    //is current user
    bool isCurrentUser=data['senderID']==_authService.getCurrentUser()!.uid;
    //current user chat to right
   var alignment= isCurrentUser?Alignment.centerRight:Alignment.centerLeft;

    return Container(
      alignment:alignment ,
        child: Column(
          crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
          ],
        ),
    );
  }

  //build Message input
  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          //text Field
          Expanded(child: MyTextField(
            controller: _messageController,
            hintText: "Type a message",
            obscureText: false,
           ),
          ),
          //send button
          Container(
            decoration:const BoxDecoration(
              color:Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right:25 ),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward,color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
