import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_omens/pages/home/cover.dart';
import 'package:good_omens/pages/home/verse.dart';
import 'package:good_omens/pages/profile/signup_page.dart';
import 'package:good_omens/widgets/google_sign_in_button.dart';
import 'package:good_omens/utils/authentication.dart';
import 'package:good_omens/widgets/gradient_circle.dart';
import 'forgot_password_page.dart';
import 'package:good_omens/widgets/gradient_button.dart';
import 'package:good_omens/pages/profile/signup_page.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  bool _isEmailChecked = false;
  final passwordController = TextEditingController();

  bool _isObscured = true;

  @override
  void initState() {
    super.initState();

    emailController.addListener(_onEmailChanged);
  }

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
        backgroundColor: Colors.transparent,
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
      backgroundColor: const Color(0xFF1E1E1E),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
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
                  const SizedBox(height: 130), // Spacing between buttons
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
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      fillColor: const Color.fromARGB(255, 0, 0, 0),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Email address',
                      labelStyle: const TextStyle(
                        fontFamily: 'inter',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFF1F4F8),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: _isEmailChecked
                          ? const Icon(
                              Icons.check_circle,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )
                          : null,
                      errorStyle: const TextStyle(
                        fontFamily: 'inter',
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'inter',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null,
                  ),

                  const SizedBox(height: 24),
                  TextFormField(
                    obscureText: _isObscured,
                    controller: passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      fillColor: const Color.fromARGB(255, 0, 0, 0),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        fontFamily: 'inter',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
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
                        color: Colors.white,
                      ),
                      errorStyle: const TextStyle(
                        fontFamily: 'inter',
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'inter',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
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
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: screenWidth,
                    height: 56,
                    child: GradientButton(
                      text: 'Log In',
                      onPressed: signIn,
                    ),
                  ),
                  const SizedBox(height: 42),
                  const Row(
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
                  const SizedBox(height: 24),
                  FutureBuilder(
                    future: Authentication.initializeFirebase(context: context),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Error initializing Firebase');
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return GoogleSignInButton();
                      }
                      return const CircularProgressIndicator();
                    },
                  ),

                  const SizedBox(height: 56),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      text: "Don't have an account? ",
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpWidget()),
                              );
                            },
                          text: 'Sign Up',
                          style: const TextStyle(
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
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CoverPage()));
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
              content: Text('Invalid email or password.'),
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
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  void _onEmailChanged() {
    String email = emailController.text;
    final RegExp regex =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    if (regex.hasMatch(email)) {
      setState(() {
        _isEmailChecked = true;
      });
    } else {
      setState(() {
        _isEmailChecked = false;
      });
    }
  }
}
