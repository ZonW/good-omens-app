import "package:flutter/material.dart";
import "package:good_omens/widgets/background_swiper.dart";
import 'package:good_omens/services/user.dart';

int _currentIndex = 0;

class ThemeBottomModal extends StatelessWidget {
  final String id;
  final int theme;

  const ThemeBottomModal({super.key, required this.id, required this.theme});

  @override
  Widget build(BuildContext context) {
    Future confirm() async {
      UserService userService = UserService();
      await userService.updateUserTheme(id, _currentIndex).then(
        (value) {
          if (value == "error") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error updating theme'),
              ),
            );
          } else {
            Navigator.of(context).pop(_currentIndex);
          }
        },
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
        color: Color(0xFF282C32),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 16), // Spacing between buttons
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 16), // Spacing between buttons
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  confirm();
                },
                child: Text(
                  'Confirm',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              SizedBox(width: 16), // Spacing between buttons
            ],
          ),
          SizedBox(height: 30), // Spacing between buttons
          ImageSelector(
            onIndexChanged: (index) {
              _currentIndex = index;
            },
            initialIndex: theme,
          )
        ],
      ),
    );
  }
}
