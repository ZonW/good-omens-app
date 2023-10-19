import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_omens/pages/profile/verify_email_page.dart';
import 'package:good_omens/widgets/google_sign_in_button.dart';
import 'package:good_omens/utils/authentication.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_omens/widgets/gradient_circle.dart';
import 'package:good_omens/pages/profile/login_page.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool _isEmailChecked = false;
  final passwordController = TextEditingController();
  final FocusNode mainFocusNode = FocusNode();
  bool _isObscured = true;
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    emailController.addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    emailController.dispose();

    passwordController.dispose();
    confirmPasswordController.dispose();

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
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 130), // Spacing between buttons
                    Container(
                      width: screenWidth * 0.8,
                      child: Text(
                        'Create account',
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
                        labelText: 'Email',
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
                      validator: (value) => value != null && value.length < 8
                          ? 'Enter min. 8 characters'
                          : null,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        fillColor: const Color.fromARGB(255, 0, 0, 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Create a password',
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
                          color: const Color.fromARGB(255, 255, 255, 255),
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
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: _isObscured,
                      controller: confirmPasswordController,
                      validator: (value) => passwordController.text !=
                              confirmPasswordController.text
                          ? 'Passwords do not match'
                          : null,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        fillColor: const Color.fromARGB(255, 0, 0, 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Confirm password',
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
                          color: const Color.fromARGB(255, 255, 255, 255),
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
                    const SizedBox(height: 20),
                    Container(
                      width: screenWidth,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          signUp();
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0)), // Remove padding
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
                            gradient: const LinearGradient(
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
                          child: const Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 16),
                            ),
                          ),
                        ),
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
                        Text(' Or Register with ',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Divider(color: Colors.white, thickness: 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    FutureBuilder(
                      future:
                          Authentication.initializeFirebase(context: context),
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                        text: "Already have an account? ",
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginWidget()),
                                );
                              },
                            text: 'Log In',
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
            ),
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.of(context).pop();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => VerifyEmailPage()));
    } on FirebaseAuthException catch (e) {
      // Hide loading circle in case of error
      Navigator.of(context).pop();
      //pop up error message
      switch (e.code) {
        case 'email-already-in-use':
          // Fetch the sign-in methods for the provided email
          List<String> signInMethods = await FirebaseAuth.instance
              .fetchSignInMethodsForEmail(emailController.text.trim());
          // If the user has already signed up with email
          if (signInMethods.isEmpty) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => VerifyEmailPage()));
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The account already exists for that email.'),
            ),
          );
          break;
        case 'invalid-email':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This is not a valid email.'),
            ),
          );
          break;
        case 'operation-not-allowed':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Signing in with Email and Password is not enabled.'),
            ),
          );
          break;
        case 'weak-password':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The password provided is too weak.'),
            ),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong. Please try again later'),
            ),
          );
      }
    } catch (e) {
      // Hide loading circle in case of error
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again later'),
        ),
      );
    }

    // Hide loading circle
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
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
