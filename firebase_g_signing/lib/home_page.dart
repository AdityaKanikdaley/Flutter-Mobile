import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  String email = 'null', name = 'null';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signIn() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if(googleUser != null){
      final googleAuth = await googleUser.authentication;
      setState(() {
        email = googleUser.email;
        name = googleUser.displayName;
      });

      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return userCredential.user;
      }
    } else {
      throw FirebaseAuthException(
        message: "Sign in canceled by user",
        code: "ERROR_CANCELED_BY_USER",
      );
    }
  }

  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if(user == null){
      return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: signIn,
            child: Text("Login With Google"),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
            Text(email),
            ElevatedButton(
              onPressed: signOut,
              child: Text("Log out"),
            ),

          ],
        ),
      ),
    );
  }
}