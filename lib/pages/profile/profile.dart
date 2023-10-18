import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_omens/pages/home/verse.dart';
import 'package:good_omens/pages/profile/profile_home_page.dart';
import 'package:good_omens/pages/profile/verify_email_page.dart';
import 'auth_page.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isEmailVerified = false;
  @override
  void initState() {
    super.initState();
    if (_auth.currentUser != null) {
      isEmailVerified = _auth.currentUser!.emailVerified;
    } else {
      isEmailVerified = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBodyWidget(),
    );
  }

  _getBodyWidget() {
    if (_auth.currentUser != null && !isEmailVerified) {
      return VerifyEmailPage();
    } else if (_auth.currentUser == null) {
      return AuthPage();
    } else if (_auth.currentUser != null && isEmailVerified) {
      return ProfileHomePage();
    }
  }
}
