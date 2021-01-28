import 'package:flashchat/components/round_button.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/components/round_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registaion_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'Logo',
            child: Container(
              child: Image.asset('images/logo.png'),
              width: 200,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RoundTextField(
            hintText: 'Enter Username',
            onChanged: (value) {
              email = value;
            },
          ),
          RoundTextField(
            hintText: 'Enter Password',
            onChanged: (value) {
              password = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          RoundButton(
            onPressed: () async {
              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                if (newUser != null) {
                  Navigator.pushNamed(context, ChatScreen.id);
                }
              } catch (e) {
                print(e);
              }
            },
            text: 'Register',
            minWidth: 200,
            colour: Colors.lightBlue,
          )
        ],
      ),
    );
  }
}
