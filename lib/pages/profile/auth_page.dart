import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:good_omens/pages/profile/login_page.dart';
import 'package:good_omens/pages/profile/signup_page.dart';
import 'package:good_omens/widgets/gradient_circle.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: SvgPicture.asset('assets/img/Good Omens.svg', height: 20),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF1E1E1E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientCircle(),
            SizedBox(height: screenHeight * 0.1), // Spacing between buttons
            Container(
              width: screenWidth * 0.6,
              child: Text(
                'Explore the app',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            SizedBox(height: 11), // Spacing between buttons
            Container(
              width: screenWidth * 0.75,
              child: Text(
                'LOREM IPUSM LOREM IPUSMLOREM IPUSMLOREM IPUSMLOREM IPUSM',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            SizedBox(height: screenHeight * 0.1), // Spacing between buttons
            Container(
              width: screenWidth * 0.8,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginWidget()),
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(0)), // Remove padding
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  foregroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFE99FA8), // Top Left color
                        Color(0xFFD7CEE7), // Center color
                        Color(0xFF91A0CD), // Bottom Right color
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16), // Change text color to white
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10), // Spacing between buttons
            Container(
              width: screenWidth * 0.8,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE99FA8), // Top Left color
                    Color(0xFFD7CEE7), // Center color
                    Color(0xFF91A0CD), // Bottom Right color
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpWidget()),
                    );
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          margin: EdgeInsets.all(
                              1), // Adjust the value of the margin to control the thickness of the border
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Create Account',
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
