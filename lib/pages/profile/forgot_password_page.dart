import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/main.dart';
import 'package:good_omens/pages/profile/email_sent_confirm.dart';
import 'package:good_omens/widgets/gradient_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool _isEmailChecked = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    emailController.dispose();

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
        title: Text(
          'Password and Security',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF1E1E1E),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 28,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Reset Password',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                          'Enter the email associated with your \naccount and we’ll send an email with \ninstructions to reset your password .',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 28),
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
                      const SizedBox(height: 28),
                      Container(
                        width: screenWidth,
                        height: 56,
                        child: GradientButton(
                            text: 'Send Instructions',
                            onPressed: resetPassword),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => EmailSentPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }

  void _onEmailChanged() {
    String email = emailController.text;
    final RegExp regex =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    if (regex.hasMatch(email)) {
      print('Email is valid');
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
