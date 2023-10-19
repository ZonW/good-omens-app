import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:good_omens/pages/home/verse.dart';
import 'package:good_omens/theme/main_theme.dart';
import 'pages/profile/auth_page.dart';
import 'pages/profile/login_page.dart';
import 'pages/profile/signup_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GoodOmens());
}

class GoodOmens extends StatefulWidget {
  @override
  _GoodOmensPageState createState() => _GoodOmensPageState();
}

class _GoodOmensPageState extends State<GoodOmens> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/auth': (context) => AuthPage(),
        '/login': (context) => LoginWidget(),
        '/signup': (context) => AuthPage(),
      },
      home: VersePage(),
      theme: CustomTheme.theme,
    );
  }
}
