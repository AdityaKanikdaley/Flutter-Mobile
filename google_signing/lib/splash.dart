import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  GoogleSignIn googleSignIn = GoogleSignIn(clientId: '378415371129-cjqi8vjjc0pa0uo0kd8jgq76m9j0vt3l.apps.googleusercontent.com');

  @override
  void initState() {
    super.initState();
    checkSignInStatus();
  }
  @override
  Widget build(BuildContext context) {
      return Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Welcome',
              style: TextStyle(fontSize: 30),
            ),
            CircularProgressIndicator()
          ],
        ),
      );
  }

  void checkSignInStatus() async {
    await Future.delayed(Duration(seconds: 2));
    bool isSignedIn = await googleSignIn.isSignedIn();
    if(isSignedIn){
      print('user signed in');
      Navigator.pushReplacementNamed(context, '/profile');
    } else{
        Navigator.pushReplacementNamed(context, '/login');
    }
  }
}

