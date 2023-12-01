import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
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
            'About Us',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Overview\n\n'
          'Good Omens is a unique app that blends advanced artificial intelligence with mystical concepts. It focuses on deeply interpreting daily Bible verses or classic book quotes, exploring the profound meanings behind these texts and their potential connections to users\' daily behavior and fortunes. With precise AI analysis, Good Omens not only offers daily guidance but also reveals how to draw wisdom from these quotes to aid in making more informed future decisions.\n\n'
          'Key Features\n\n'
          '- Daily Quote Analysis: Delivers hand-picked Bible verses or classic book quotes each day, with in-depth AI interpretation to uncover their relevance to the user\'s daily life and fortunes.\n'
          '- Personalized Advice: Offers customized suggestions based on the user\'s personal behavior and life situation, guiding how to apply these insights to everyday decision-making.\n'
          '- Interactive Exploration: Users can pose questions in a chat format, receiving further explanations to deepen their understanding of the quotes and their impact on personal life.\n'
          '- Mysticism and Higher Existence Exploration: Goes beyond the surface meaning of texts, delving into deeper mystical concepts and the possibilities of higher existence, opening doors to a broader realm of understanding for users.\n\n'
          'Highlights\n\n'
          '- Combines modern AI technology with ancient wisdom for unique life guidance.\n'
          '- Personalized analysis ensures advice is closely related to the user\'s actual situation.\n'
          '- Strong interactivity, allowing users to ask direct questions and receive in-depth answers.\n'
          '- Opens new perspectives for exploring mysticism and higher levels of existence.\n\n'
          'With Good Omens, users can find deeper guidance and inspiration in their daily lives, making wiser choices and planning for the future more effectively.\n\n',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
