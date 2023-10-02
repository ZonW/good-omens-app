import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_omens/widgets/google_sign_in_button.dart';
import 'package:good_omens/utils/authentication.dart';
import 'package:good_omens/widgets/gradient_circle.dart';
import 'forgot_password_page.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode mainFocusNode = FocusNode();
  bool _isObscured = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Color(0xFFFFFFFF),
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: SvgPicture.asset('assets/img/Good Omens.svg', height: 20),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF1E1E1E),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(mainFocusNode);
        },
        child: Stack(
          children: [
            Focus(
              focusNode: mainFocusNode,
              child: Container(),
            ),
            Positioned(
              top: -28, // Adjust as needed
              right: -40, // Adjust as needed
              child: Container(
                width: screenWidth * 0.6,
                height: screenWidth * 0.6,
                child: GradientCircle(),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 130), // Spacing between buttons
                  Container(
                    width: screenWidth * 0.8,
                    child: Text(
                      'Log In',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  const SizedBox(height: 32), // Spacing between buttons
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      fillColor: Color.fromARGB(255, 0, 0, 0),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Email address',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFF1F4F8),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: Icon(Icons.check,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 24),
                  TextField(
                    obscureText: _isObscured,
                    controller: passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      fillColor: Color.fromARGB(255, 0, 0, 0),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFF1F4F8),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          icon: Icon(_isObscured
                              ? Icons.visibility_off
                              : Icons.visibility),
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ),
                      ),
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: screenWidth,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        signIn();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(0)), // Remove padding
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFE99FA8), // Top Left color
                              Color(0xFFD7CEE7), // Center color
                              Color(0xFF91A0CD), // Bottom Right color
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Log In',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 42),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(color: Colors.white, thickness: 1),
                      ),
                      SizedBox(width: 8),
                      Text(' Or Log In with ',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Divider(color: Colors.white, thickness: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  FutureBuilder(
                    future: Authentication.initializeFirebase(context: context),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error initializing Firebase');
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return GoogleSignInButton();
                      }
                      return CircularProgressIndicator();
                    },
                  ),

                  SizedBox(height: 56),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      text: "Don't have an account? ",
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignUp,
                          text: 'Sign Up',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    //display loading circle
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      //add pop up error message here
      print('error: ' + e.code);
      switch (e.code) {
        case 'channel-error':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid email or password.'),
            ),
          );
          break;
        case 'network-request-failed':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No internet connection.'),
            ),
          );
          break;
        case 'INVALID_LOGIN_CREDENTIALS':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No user found with that email.'),
            ),
          );
          break;
        case 'wrong-password':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong password provided for that user.'),
            ),
          );
          break;
        case 'invalid-email':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid email.'),
            ),
          );
          break;
        case 'unknown':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong. Please try again later.'),
            ),
          );
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again later.'),
        ),
      );
    }

    // Hide loading circle
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
