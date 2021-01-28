import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
User loggedinUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  String messageText;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
        print(loggedinUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Log out
              _auth.signOut();
              Navigator.pop(context);
            },
          )
        ],
        backgroundColor: Colors.lightBlueAccent,
        title: Text('⚡️Chat'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BubbleBuilder(),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.lightBlueAccent,
                  width: 2.0,
                ),
              ),
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    onChanged: (value) {
                      // Add function
                      messageText = value;
                    },
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(
                      hintText: 'Type your message here...',
                      hintStyle: TextStyle(
                        color: Colors.black54,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    messageTextController.clear();
                    _firestore.collection('messages').add({
                      'text': messageText,
                      'sender': loggedinUser.email,
                    });
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BubbleBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data.docs;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            var messageText = message.data()['text'];
            var messageSender = message.data()['sender'];
            final currentUser = loggedinUser.email;
            messageBubbles.add(MessageBubble(
              text: messageText,
              sender: messageSender,
              isme: currentUser == messageSender,
            ));
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              children: messageBubbles,
            ),
          );
        } else {
          return Text('Error');
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isme});

  final bool isme;
  final text;
  final sender;
  @override
  Widget build(BuildContext context) {
    print(isme);
    print(text);
    return Column(
      crossAxisAlignment:
          isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          sender,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 12,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Material(
            shadowColor: Colors.black,
            elevation: 5,
            borderRadius: isme
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.zero,
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isme ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                '$text',
                style: TextStyle(
                  color: isme ? Colors.white : Colors.black54,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
