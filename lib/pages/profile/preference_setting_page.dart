import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:good_omens/widgets/background_swiper.dart';
import 'package:good_omens/widgets/theme_bottom_modal.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:good_omens/services/user.dart';

import 'package:good_omens/models/user.dart' as user_model;

class PreferenceSettingPage extends StatefulWidget {
  PreferenceSettingPage({
    super.key,
    required this.theme,
    required this.id,
  });
  final int theme;
  final String id;

  @override
  _PreferenceSettingPageState createState() => _PreferenceSettingPageState();
}

class _PreferenceSettingPageState extends State<PreferenceSettingPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser!;

  final _unfocusNode = FocusNode();
  String id = "";

  int currTheme = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setState(() {
      currTheme = widget.theme;
      id = widget.id;
    });
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void showThemeBottomModal(BuildContext context) async {
      final index = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors
            .transparent, // to have no background color for the modal itself
        isScrollControlled: true, // to control the height
        builder: (context) => ThemeBottomModal(id: id, theme: currTheme),
      );
      if (index != null) {
        setState(() {
          currTheme = index;
        });
      }
    }

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
          title: Text(
            'Preference Settings',
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
            GestureDetector(
              onTap: () {
                showThemeBottomModal(context);
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
                          width: screenWidth * 0.4,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Text(
                              'Theme',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Style" + currTheme.toString(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Container(
                        width: 50,
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
          ],
        ),
      ),
    );
  }
}
