import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:good_omens/main.dart';
import 'package:good_omens/services/user.dart';

import 'package:good_omens/widgets/gradient_border_button.dart';
import 'package:good_omens/widgets/gradient_button.dart';
import 'package:provider/provider.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({
    super.key,
    required this.id,
  });
  final String id;

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future subscribeMonth() async {
    UserService userService = UserService();
    await userService.subscribe(widget.id).then(
      (value) {
        if (value == "error") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error subscribing to Good Omens PRO'),
            ),
          );
        } else {
          Provider.of<UserSubscription>(context, listen: false)
              .setSubscription(true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Subscribed to Good Omens PRO'),
            ),
          );
          Navigator.of(context).pop();
        }
      },
    );
  }

  Future subscribeYear() async {
    UserService userService = UserService();
    await userService.subscribe(widget.id).then(
      (value) {
        if (value == "error") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error subscribing to Good Omens PRO'),
            ),
          );
        } else {
          Provider.of<UserSubscription>(context, listen: false)
              .setSubscription(true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Subscribed to Good Omens PRO'),
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
                        'Try free for 1 month and cancel anytime',
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
                            Icons.lock_open,
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
                            Icons.lock_open,
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
                            Icons.lock_open,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Access to all themes',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.lock_open,
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
                        width: 167,
                        height: 56,
                        onTap: () {
                          subscribeMonth();
                        },
                        textContent: "  \$2.99/Month  ",
                      ),
                      const Spacer(),
                      GradientButton(
                        width: 167,
                        height: 56,
                        onPressed: () {
                          subscribeYear();
                        },
                        text: "  \$19.9/Year  ",
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
