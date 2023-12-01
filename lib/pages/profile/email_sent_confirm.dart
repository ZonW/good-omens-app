import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/main.dart';
import 'package:good_omens/widgets/gradient_button.dart';

class EmailSentPage extends StatefulWidget {
  @override
  _EmailSentPageState createState() => _EmailSentPageState();
}

class _EmailSentPageState extends State<EmailSentPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Color(0xFFFFFFFF),
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Password and Security',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF1E1E1E),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 32,
                ),
                Container(
                  height: screenWidth * 0.6,
                  width: screenWidth * 0.6,
                  child: SvgPicture.asset(
                      'assets/img/undraw_mail_sent_re_0ofv 1.svg'),
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  'Check your email',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  'We have sent a password recovery instruction to your email.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            )),
      ),
    );
  }
}
