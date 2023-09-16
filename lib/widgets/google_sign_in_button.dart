import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_omens/utils/authentication.dart';
import 'package:good_omens/main.dart';
import 'package:good_omens/services/user.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                try {
                  User? user =
                      await Authentication.signInWithGoogle(context: context);
                  print(user);
                  if (user != null) {
                    // Extract user information
                    String firebase_id = user.uid;
                    String name = user.displayName ?? '';
                    String email = user.email ?? '';

                    //check if user exists in database
                    UserService userService = UserService();
                    bool isFirstTimeLogin =
                        await userService.checkIfFirstTimeLogin(firebase_id);
                    //If first time log in through google account, create user in database
                    if (isFirstTimeLogin) {
                      print("create 'user' in database");
                      await userService.createUser(firebase_id, name, email);
                    }
                    navigatorKey.currentState!
                        .popUntil((route) => route.isFirst);
                  }
                } catch (error) {
                  print('Sign-In Error: $error');
                  // Optionally, show a message to the user
                } finally {
                  setState(() {
                    _isSigningIn = false;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/icon/google_logo.png"),
                      height: 24.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
