import 'package:flashchat/components/round_button.dart';
import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'Logo',
                child: Container(
                  child: Image.asset('images/logo.png'),
                  width: 60,
                ),
              ),
              Text(
                'FLASHCHAT',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          RoundButton(
            colour: Colors.lightBlueAccent,
            minWidth: 200,
            text: 'Log in',
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
          RoundButton(
            onPressed: () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
            colour: Colors.lightBlue,
            text: 'Register',
            minWidth: 200,
          )
        ],
      ),
    );
  }
}

//minWidth = 200
