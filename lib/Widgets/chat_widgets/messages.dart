import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Widgets/chat_widgets/message_bubble.dart';

class Messages extends StatelessWidget{
  final String userId;
  Messages(this.userId);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').where(
        'userId' , isEqualTo: userId
      ).snapshots(),
      builder: (ctx,snapShot){
        if(snapShot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        final docs = snapShot.data.docs;
        final user =  FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (ctx,index) => MessageBubble(
            docs[index]['text'],
            docs[index]['username'],
            docs[index]['myId'] == user.uid,
          )
        );
      },
    );
  }

}