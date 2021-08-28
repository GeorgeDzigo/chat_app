import 'package:firebase_auth/firebase_auth.dart';

import './message_bubble.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final chatData = snapshot.data.docs;
        final user = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemCount: chatData.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatData[index]['text'],
            chatData[index]['userId'] == user.uid,
            chatData[index]['username'],
            chatData[index]['userImage'],
            key: ValueKey(chatData[index]),
          ),
        );
      },
    );
  }
}
