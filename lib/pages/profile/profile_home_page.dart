import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/pages/profile/about_us_nav_page.dart';
import 'package:good_omens/pages/profile/forgot_password_page.dart';

import 'package:good_omens/pages/profile/preference_setting_page.dart';
import 'package:good_omens/pages/profile/auth_page.dart';
import 'package:good_omens/pages/profile/subscription.dart';
import 'package:good_omens/pages/profile/unsubscribe.dart';
import 'package:good_omens/services/user.dart';
import 'package:good_omens/models/user.dart' as user_model;
import 'package:good_omens/utils/authentication.dart';

import 'package:good_omens/widgets/gradient_border_button.dart';

class ProfileHomePage extends StatefulWidget {
  const ProfileHomePage({Key? key}) : super(key: key);

  @override
  _ProfileHomePageState createState() => _ProfileHomePageState();
}

class _ProfileHomePageState extends State<ProfileHomePage> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser!;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  // int daysSinceRegistration = 0;
  user_model.User? userData;

  int subscription = 0;
  int currTheme = 0;

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializeUserData();
  }

  Future<void> initializeUserData() async {
    UserService userService = UserService();
    try {
      user_model.User? value = await userService.getUserById(userId);

      if (value == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AuthPage()));
      }

      setState(() {
        userData = value;

        subscription = value?.toJson()['subscription'];
        currTheme = value?.toJson()['theme'];
      });
    } catch (error) {
      print('Error fetching user data: $error');

      // Handle the error appropriately here
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    const textGradient = LinearGradient(
      colors: [
        Color(0xFFE99FA8),
        Color(0xFFFFFFFF),
        Color(0xFFBDAFE3),
        Color(0xFFFFFFFF),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(currTheme);
        return false; // Prevent the default behavior after our custom one
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF171717),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(62),
          child: AppBar(
            backgroundColor: const Color(0xFF171717),
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop(currTheme);
              },
            ),
            title: SvgPicture.asset('assets/img/Good Omens.svg', height: 20),
            centerTitle: true,
          ),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 40),
              Transform.scale(
                scaleX: 1.4,
                scaleY: 1.3,
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return textGradient
                        .createShader(Rect.fromLTWH(0, 14, screenWidth, 30));
                  },
                  child: const Text(
                    "Welcome Back    ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 30,
                      height: 1.5,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      color: Colors
                          .white, // Important to ensure the gradient works
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Preference button
              GestureDetector(
                onTap: () async {
                  final theme = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PreferenceSettingPage(
                        theme: currTheme,
                        id: userId,
                      ),
                    ),
                  );
                  if (theme != null) {
                    setState(() {
                      currTheme = theme;
                    });
                    print(currTheme);
                  }
                },
                child: Container(
                  width: 0.9 * screenWidth,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFF333943),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Container(
                            width: 50,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: const Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Icon(
                                Icons.person,
                                color: Color(0xFFD8E4E5),
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Container(
                            width: screenWidth * 0.5,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Text(
                                'Preference Settings',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: const Align(
                            alignment: AlignmentDirectional(1, 0),
                            child: Icon(
                              Icons.chevron_right,
                              color: Color(0xFFFFFFFF),
                              size: 30,
                            ),
                            //on pressed to second page, on pop, refresh current page state
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Account button
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordPage(),
                    ),
                  );
                },
                child: Container(
                  width: 0.9 * screenWidth,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFF333943),
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 100,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: const Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Icon(
                              Icons.lock,
                              color: Color(0xFFD8E4E5),
                              size: 32,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Container(
                            width: screenWidth * 0.5,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Text(
                                'Reset Password',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            child: const Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: Icon(
                                Icons.chevron_right,
                                color: Color(0xFFFFFFFF),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Subscription button
              GestureDetector(
                onTap: () async {
                  print(subscription);
                  if (subscription == 0) {
                    // If subscription is 0, navigate to SubscriptionPage
                    await Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) => SubscriptionPage(id: userId),
                          ),
                        )
                        .then((value) => initializeUserData());
                  } else if (subscription == 1) {
                    // If subscription is 1, navigate to UnsubscribePage
                    await Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) => UnsubscribePage(id: userId),
                          ),
                        )
                        .then((value) => initializeUserData());
                  }
                },
                child: Container(
                  width: 0.9 * screenWidth,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFF333943),
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 100,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: const Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Icon(
                              Icons.star,
                              color: Color(0xFFD8E4E5),
                              size: 32,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Container(
                            width: screenWidth * 0.5,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Text(
                                'Membership',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            child: const Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: Icon(
                                Icons.chevron_right,
                                color: Color(0xFFFFFFFF),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // About button
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AboutUsNavPage(),
                    ),
                  );
                },
                child: Container(
                  width: 0.9 * screenWidth,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFF333943),
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 100,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: const Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Icon(
                              Icons.person,
                              color: Color(0xFFD8E4E5),
                              size: 32,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Container(
                            width: screenWidth * 0.5,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Text(
                                'About us',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            child: const Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: Icon(
                                Icons.chevron_right,
                                color: Color(0xFFFFFFFF),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),
              Column(
                children: [
                  Text(
                    "Version 1.0.0",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 46),
                  GradientBorderButton(
                    width: 0.9 * screenWidth,
                    height: 56,
                    onTap: () {
                      Authentication.signOut(context: context);
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AuthPage()),
                      );
                    },
                    textContent: "Log Out",
                  ),
                  const SizedBox(height: 53),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
