import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:good_omens/pages/profile/personal_data_page.dart';
import 'package:good_omens/services/user.dart';
import 'package:good_omens/models/user.dart' as user_model;
import 'package:good_omens/utils/authentication.dart';
import "forgot_password_page.dart";

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
  user_model.User? userData;
  String email = "";
  String nickName = "";
  int subscription = 0;

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
      print(value);
      setState(() {
        userData = value;
        email = value?.toJson()['email'];
        nickName = value?.toJson()['nick_name'];
        subscription = value?.toJson()['subscription'];
      });
    } catch (error) {
      print('Error fetching user data: $error');
      // Handle the error appropriately here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFE5E5E5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.8, 0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      Authentication.signOut(context: context);
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 176,
                    decoration: const BoxDecoration(
                      color: Color(0x00FFFFFF),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0, -1),
                          child: Container(
                            width: 96,
                            height: 96,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          nickName,
                          style: TextStyle(
                            color: subscription == 1
                                ? Color.fromARGB(255, 187, 168, 0)
                                : Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          email,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            color: Color(0x69000000),
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Align(
                      alignment: AlignmentDirectional(-0.9, 0),
                      child: Text(
                        'Account Security',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF9799A1),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFE5E5E5),
                          width: 1,
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
                                    Icons.person_outlined,
                                    color: Colors.black,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: const Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Text(
                                    'Personal Data',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
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
                              child: Align(
                                alignment: const AlignmentDirectional(1, 0),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  //on pressed to second page, on pop, refresh current page state
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) => PersonalDataPage(
                                          userData: userData,
                                        ),
                                      ),
                                    )
                                        .then(
                                      (value) {
                                        //if done pressed, value is true
                                        if (value) {
                                          UserService userService =
                                              UserService();
                                          userService
                                              .getUserById(userId)
                                              .then((value) {
                                            setState(() {
                                              userData = value;
                                              email = value?.toJson()['email'];
                                              nickName =
                                                  value?.toJson()['nick_name'];
                                            });
                                          });
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFE5E5E5),
                          width: 1,
                        ),
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
                              decoration: const BoxDecoration(
                                  color: Colors.transparent),
                              child: const Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Icon(
                                  Icons.format_list_bulleted,
                                  color: Colors.black,
                                  size: 32,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: const Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Text(
                                    'Account Information',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                    color: Colors.transparent),
                                child: Align(
                                  alignment: const AlignmentDirectional(1, 0),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.chevron_right,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Align(
                      alignment: AlignmentDirectional(-0.9, 0),
                      child: Text(
                        'Security Setting',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF9799A1),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFE5E5E5),
                          width: 1,
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
                                    Icons.beenhere_outlined,
                                    color: Colors.black,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: const Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Text(
                                    'Password Reset',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
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
                              child: Align(
                                alignment: const AlignmentDirectional(1, 0),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordPage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFE5E5E5),
                          width: 1,
                        ),
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
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: const Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Icon(
                                  Icons.fingerprint_outlined,
                                  color: Colors.black,
                                  size: 32,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: const Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Text(
                                    'Face ID & Fingerprint',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Align(
                                  alignment: const AlignmentDirectional(1, 0),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.chevron_right,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
