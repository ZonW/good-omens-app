import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:good_omens/models/user.dart';
import 'package:good_omens/services/user.dart';
import 'package:good_omens/models/user.dart' as user_model;
import 'package:good_omens/widgets/gradient_border_button.dart';
import 'package:good_omens/widgets/gradient_button.dart';

class UnsubscribePage extends StatefulWidget {
  const UnsubscribePage({
    super.key,
    required this.id,
  });
  final String id;

  @override
  _UnsubscribePageState createState() => _UnsubscribePageState();
}

class _UnsubscribePageState extends State<UnsubscribePage> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  user_model.User? userData;

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
      user_model.User? value = await userService.getUserById(widget.id);

      if (value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error fetching user data'),
          ),
        );
      } else {
        setState(() {
          userData = value;
        });
      }
    } catch (error) {
      print('Error fetching user data: $error');
      // Handle the error appropriately here
    }
  }

  Future unsubscribe() async {
    UserService userService = UserService();
    await userService.unsubscribe(widget.id).then(
      (value) {
        if (value == "error") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error unsubscribing from Good Omens PRO'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Unsubscribed from Good Omens PRO'),
            ),
          );
          Navigator.of(context).pop();
        }
      },
    );
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
        Navigator.of(context).pop();
        return false;
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
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Membership',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            centerTitle: true,
          ),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 0.9 * screenWidth,
                height: 105,
                decoration: BoxDecoration(
                  color: Color(0xFF333943),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return textGradient.createShader(
                              Rect.fromLTWH(0, 12, screenWidth, 24));
                        },
                        child: const Text(
                          "Good Omens PRO",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 24,
                            height: 1.5,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        userData?.subscription_time ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 0.9 * screenWidth,
                height: 256,
                decoration: BoxDecoration(
                  color: Color(0xFF333943),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRO Features',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Access to Good Omens chat',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Access to book library',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Access to the all themes',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Loriem ipsum dolor sit amet',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: screenWidth,
                height: 109,
                decoration: BoxDecoration(
                  color: Color(0xFF333943),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      GradientBorderButton(
                        width: 0.9 * screenWidth,
                        height: 56,
                        onTap: () {
                          unsubscribe();
                        },
                        textContent: "  Unsubscribe  ",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
