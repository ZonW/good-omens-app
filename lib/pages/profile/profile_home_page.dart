import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/pages/profile/personal_data_page.dart';
import 'package:good_omens/services/user.dart';
import 'package:good_omens/models/user.dart' as user_model;
import 'package:good_omens/utils/authentication.dart';
import "forgot_password_page.dart";
import 'package:good_omens/pages/home/figma.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(62),
        child: AppBar(
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Color(0xFF000000),
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: SizedBox(
                width: 62,
                height: 35,
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
            ),
          ],
          centerTitle: true,
        ),
      ),
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/img/eclipse1.svg',
                      semanticsLabel: 'eclipse'),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/img/eclipse2.svg',
                      semanticsLabel: 'eclipse'),
                ),
              ],
            ),
          ),
          SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
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
                            const SizedBox(height: 16),
                            Text(
                              nickName,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              email,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          width: 0.9 * screenWidth,
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0x80FFF8FC),
                            border: Border.all(
                              color: const Color(0xFFF9F9F9),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
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
                                        color: Color(0xFFBDAFE3),
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
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Text(
                                        'Basic Information',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
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
                                        color: Color(0xFFBDAFE3),
                                        size: 30,
                                      ),
                                      //on pressed to second page, on pop, refresh current page state
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PersonalDataPage(
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
                                                  email =
                                                      value?.toJson()['email'];
                                                  nickName = value
                                                      ?.toJson()['nick_name'];
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
                        const SizedBox(height: 8),
                        Container(
                          width: 0.9 * screenWidth,
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0x80FFF8FC),
                            border: Border.all(
                              color: const Color(0xFFF9F9F9),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
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
                                      Icons.person,
                                      color: Color(0xFFBDAFE3),
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
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Text(
                                        'Account Setting',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
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
                                      alignment:
                                          const AlignmentDirectional(1, 0),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.chevron_right,
                                          color: Color(0xFFBDAFE3),
                                          size: 30,
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
                        const SizedBox(height: 8),
                        Container(
                          width: 0.9 * screenWidth,
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0x80FFF8FC),
                            border: Border.all(
                              color: const Color(0xFFF9F9F9),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
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
                                      Icons.person,
                                      color: Color(0xFFBDAFE3),
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
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Text(
                                        'Customization',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
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
                                      alignment:
                                          const AlignmentDirectional(1, 0),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.chevron_right,
                                          color: Color(0xFFBDAFE3),
                                          size: 30,
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
                        const SizedBox(height: 8),
                        Container(
                          width: 0.9 * screenWidth,
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0x80FFF8FC),
                            border: Border.all(
                              color: const Color(0xFFF9F9F9),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
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
                                      Icons.person,
                                      color: Color(0xFFBDAFE3),
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
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Text(
                                        'Activity Log',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
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
                                      alignment:
                                          const AlignmentDirectional(1, 0),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.chevron_right,
                                          color: Color(0xFFBDAFE3),
                                          size: 30,
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
                        const SizedBox(height: 8),
                        Container(
                          width: 0.9 * screenWidth,
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0x80FFF8FC),
                            border: Border.all(
                              color: const Color(0xFFF9F9F9),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
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
                                      Icons.person,
                                      color: Color(0xFFBDAFE3),
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
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Text(
                                        'Subscription',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
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
                                      alignment:
                                          const AlignmentDirectional(1, 0),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.chevron_right,
                                          color: Color(0xFFBDAFE3),
                                          size: 30,
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
        ],
      ),
    );
  }
}
