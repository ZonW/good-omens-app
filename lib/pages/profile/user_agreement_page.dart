import 'package:flutter/material.dart';

class UserAgreementPage extends StatelessWidget {
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
            'User Agreement',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'User Agreement for Good Omens\n\n'
          'Last Updated: 11/29/2023\n\n'
          'Introduction\n\n'
          'Welcome to Good Omens. This User Agreement ("Agreement") sets forth the terms and conditions under which you may use the Good Omens app and any associated services.\n\n'
          'Definitions\n\n'
          '• "App" refers to the Good Omens application.\n'
          '• "User," "You," and "Your" refer to the individual who uses the App.\n'
          '• "Content" means all material, including texts, graphics, images, and other material.\n\n'
          'License to Use\n\n'
          'We grant you a non-exclusive, non-transferable, revocable license to use the App for your personal, non-commercial purposes, subject to this Agreement.\n\n'
          'Acceptable Uses\n\n'
          'You agree to use the App only for lawful purposes and in a way that does not infringe the rights of, restrict, or inhibit anyone else’s use and enjoyment of the App.\n\n'
          'Prohibited Behaviors\n\n'
          'You must not use the App in a manner that is illegal, harmful, or offensive. Prohibited behaviors include harassing other users, spreading malicious content, or engaging in fraudulent activities.\n\n'
          'Termination and Account Suspension\n\n'
          'We reserve the right to suspend or terminate your access to the App if you are found to be in breach of this Agreement.\n\n'
          'Intellectual Property Protection\n\n'
          'The App and its original content, features, and functionality are owned by Good Omens and are protected by intellectual property laws.\n\n'
          'User-Generated Content\n\n'
          'You may be able to submit content to the App. You retain all rights to your content but grant us a license to use, store, and display your content in connection with the App.\n\n'
          'Payment Clauses\n\n'
          'If you purchase any services or products through the App, you agree to pay the required fees. All transactions are subject to our refund policy.\n\n'
          'Privacy Policy Information\n\n'
          'Your use of the App is also governed by our Privacy Policy, which describes how we handle your personal data.\n\n'
          'Limitation of Liability\n\n'
          'To the maximum extent permitted by law, Good Omens shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues.\n\n'
          'Disclaimers and Warranties\n\n'
          'The App is provided "as is" and "as available" without any warranties of any kind, either express or implied, including, but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement.\n\n'
          'Governing Laws\n\n'
          'This Agreement and your use of the App are governed by the laws of United States, without regard to conflict of law principles.\n\n'
          'Changes to Your Terms\n\n'
          'We reserve the right to modify this Agreement at any time and will publish the revised version on the App, effective immediately upon posting.\n\n'
          'Contact Information\n\n'
          'If you have any questions about this Agreement, please contact us.\n\n',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
