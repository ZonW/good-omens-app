import 'package:flutter/material.dart';
import 'package:good_omens/pages/home/verse.dart';

import 'package:good_omens/theme/main_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/profile/auth_page.dart';
import 'pages/profile/login_page.dart';
import 'pages/profile/signup_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/auth': (context) => AuthPage(),
        '/login': (context) => LoginWidget(
              onClickedSignUp: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/signup', ModalRoute.withName('/'));
              },
            ),
        '/signup': (context) => SignUpWidget(
              onClickedSignIn: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', ModalRoute.withName('/'));
              },
            ),
      },
      theme: CustomTheme.theme,
      home: VersePage(),
    );
  }
}
