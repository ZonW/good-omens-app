import 'package:flutter/material.dart';
import 'package:good_omens/pages/profile/about_us_page.dart';
import 'package:good_omens/pages/profile/contact_us_page.dart';
import 'package:good_omens/pages/profile/privacy_page.dart';
import 'package:good_omens/pages/profile/user_agreement_page.dart';

class AboutUsNavPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'About Us',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          centerTitle: true,
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 33),
            //about page
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
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
                              'About',
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
            //user agreement page
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserAgreementPage(),
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
                              'User Agreement',
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
            //privacy policy page
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyPage(),
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
                              'Privacy Policy',
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
            //contact us page
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ContactUsPage(),
                  ),
                );
              },
              child: Container(
                width: 0.9 * screenWidth,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFF333943),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
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
                              'Contact Us',
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
            SizedBox(height: 33),
            Text(
              "Since 2023.09",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
