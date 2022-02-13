import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GoogleSignIn googleSignIn = GoogleSignIn(clientId: '378415371129-cjqi8vjjc0pa0uo0kd8jgq76m9j0vt3l.apps.googleusercontent.com');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Sign-In with Google',
            style: TextStyle(fontSize: 30),
          ),
          RaisedButton(
              onPressed: (){
                  startSignIn();
              },
          child: Text('Tap to Sign-In'),
          )
        ],
      ),
    );
  }

  void startSignIn() async{
    await googleSignIn.signOut(); //optional
    GoogleSignInAccount user = await googleSignIn.signIn();
    if(user==null){
      print('Sign-In failed');
    }else{
      Navigator.pushReplacementNamed(context, '/');
    }
  }
}
