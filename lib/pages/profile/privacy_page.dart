import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            'Privacy Policy',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Privacy Policy for Good Omens\n\n'
          'Last Updated: 11/29/2023\n\n'
          '1. Introduction\n\n'
          'Welcome to the Good Omens app. We are committed to protecting your privacy and ensuring that your personal information is handled in a safe and responsible manner. This Privacy Policy outlines how we collect, use, disclose, and safeguard your information when you use our app.\n\n'
          '2. Information Collection and Use\n\n'
          'For a better experience while using our app, we may require you to provide us with certain personally identifiable information, including but not limited to [list specific information e.g., name, email address]. The information that we collect will be used to contact or identify you and for other purposes as outlined in this Privacy Policy.\n\n'
          '3. Data Collection Technology\n\n'
          'We may use technologies like cookies, beacons, tags, and scripts to collect and track information and to improve and analyze our app. These technologies are used to remember your preferences, understand how you interact with the app, and provide certain features.\n\n'
          '4. Data Sharing and Disclosure\n\n'
          'We do not sell, trade, or rent your personal identification information to others. We may share generic aggregated demographic information not linked to any personal identification information regarding visitors and users with our business partners, trusted affiliates, and advertisers.\n\n'
          '5. Third-Party Services\n\n'
          'Our app may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites.\n\n'
          '6. Security\n\n'
          'We value your trust in providing us your personal information and strive to use commercially acceptable means of protecting it. However, no method of transmission over the internet, or method of electronic storage, is 100% secure and reliable, and we cannot guarantee its absolute security.\n\n'
          '7. Children\'s Privacy\n\n'
          'Our Services do not address anyone under the age of 13. We do not knowingly collect personal identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers.\n\n'
          '8. Changes to This Privacy Policy\n\n'
          'We may update our Privacy Policy from time to time. Thus, we advise you to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.\n\n'
          '9. Contact Us\n\n'
          'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us.\n\n',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
