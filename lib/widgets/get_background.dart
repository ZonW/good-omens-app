import 'package:flutter/material.dart';
import 'package:good_omens/widgets/all_background.dart';

class TypeUtils {
  static dynamic typeOf(String name) {
    return ({
      'Background0': () => Background0(),
      'Background1': () => Background1(),
      'Background2': () => Background2(),
      'Background3': () => Background3(),
      'Background4': () => Background4(),
      'Background5': () => Background5(),
      'Background6': () => Background6(),
      'Background7': () => Background7(),
      'Background8': () => Background8(),
    })[name];
  }
}

Widget getBackground(int theme) {
  // Convert the theme number to the class name format
  final className = 'Background$theme';

  // Use the class name to retrieve the Type dynamically
  final backgroundType = TypeUtils.typeOf(className);

  // Create an instance of the widget and return
  return backgroundType();
}
