import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_omens/pages/profile/verify_email_page.dart';
import 'auth_page.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isEmailVerificationSent = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          //check: if logged in, go to profile, if not, let user log in or sign up
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                !isEmailVerificationSent) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong!'));
            } else if (snapshot.hasData) {
              return VerifyEmailPage();
            } else {
              return AuthPage();
            }
          },
        ),
      );
}
