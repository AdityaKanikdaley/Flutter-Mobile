import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  GoogleSignIn googleSignIn = GoogleSignIn(clientId: '378415371129-cjqi8vjjc0pa0uo0kd8jgq76m9j0vt3l.apps.googleusercontent.com');
  GoogleSignInAccount account;
  GoogleSignInAuthentication auth;
  bool gotProfile = false;

  @override
  void initState() {
    super.initState();
    getProfile();
  }
  @override
  Widget build(BuildContext context) {
    return gotProfile? Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app_outlined),
            onPressed: () async{
                await googleSignIn.signOut();
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }
            )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(account.photoUrl, height: 150),
            SizedBox(height: 5),
            Text(account.displayName),
            SizedBox(height: 5),
            Text(account.email),
            SizedBox(height: 5),
            Text(account.id),
          ],
        ),
      ),
    ): LinearProgressIndicator();
  }

  void getProfile() async{
    await googleSignIn.signInSilently();
    account = googleSignIn.currentUser;
    auth = await account.authentication;
    setState(() {
      gotProfile = true;
    });
  }
}
