import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/pages/profile/profile_home_page.dart';
import 'package:flutter/material.dart';
import 'package:good_omens/pages/home/verse.dart';
import 'package:good_omens/services/user.dart';
import 'dart:math';
import 'package:good_omens/widgets/gradient_button.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer; //one second timer
  Timer? checkTimer; //three second timer
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserService userService = UserService();
  DateTime? lastEmailSentTime;
  int countdownTime = 0;

  void startCountdownTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (countdownTime <= 0) {
        t.cancel();
        setState(() {
          canResendEmail = true;
          countdownTime = 0;
        });
      } else {
        setState(() {
          countdownTime--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    if (lastEmailSentTime != null) {
      countdownTime =
          60 - DateTime.now().difference(lastEmailSentTime!).inSeconds;
      if (countdownTime <= 0) {
        canResendEmail = true;
        countdownTime = 0;
      } else {
        canResendEmail = false;
        startCountdownTimer();
      }
    }

    /// user needs to be created before!
    isEmailVerified = _auth.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      checkTimer = Timer.periodic(
        //check if the user verified email every 3 seconds
        Duration(seconds: 3),
        //add api call to backend
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    checkTimer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    // call after email verification!
    await _auth.currentUser!.reload();

    setState(() {
      isEmailVerified = _auth.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      // update user data
      var random = Random();

      //print(_auth.currentUser!.uid);
      //print(_auth.currentUser!.email);
      await userService.createUser(
        _auth.currentUser!.uid,
        "Good Omens ${random.nextInt(10000)}",
        _auth.currentUser!.email!,
      );
      // print(res);
      // stop timer
      checkTimer?.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => VersePage()));
    }
  }

  Future sendVerificationEmail() async {
    try {
      if (lastEmailSentTime == null ||
          DateTime.now().difference(lastEmailSentTime!).inSeconds >= 60) {
        final user = FirebaseAuth.instance.currentUser!;
        await user.sendEmailVerification();
        lastEmailSentTime = DateTime.now();
        countdownTime = 60;
        canResendEmail = false;
        startCountdownTimer();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   icon: const Icon(
          //     Icons.chevron_left,
          //     color: Color(0xFFFFFFFF),
          //     size: 30,
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          // ),
          title: SvgPicture.asset('assets/img/Good Omens.svg', height: 20),
          centerTitle: true,
        ),
        backgroundColor: Color(0xFF1E1E1E),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'A verification email has been sent.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Container(
                  width: screenWidth,
                  height: 56,
                  child: canResendEmail
                      ? ElevatedButton(
                          onPressed:
                              canResendEmail ? sendVerificationEmail : null,
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(0)), // Remove padding
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                            child: Center(
                              child: Text(
                                'Resend Email',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed:
                              canResendEmail ? sendVerificationEmail : null,
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(0)), // Remove padding
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                                  Color.fromARGB(
                                      127, 233, 159, 168), // Top Left color
                                  Color.fromARGB(
                                      127, 215, 206, 231), // Center color
                                  Color.fromARGB(
                                      130, 145, 160, 205), // Bottom Right color
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Please wait $countdownTime seconds before resend',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
