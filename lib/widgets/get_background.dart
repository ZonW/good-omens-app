import 'package:flutter/material.dart';
import 'package:good_omens/widgets/all_background.dart';

class TypeUtils {
  static dynamic typeOf(String name) {
    return ({
      'Background999': () => BackgroundX(),
      'Background0': () => Background0(),
      'Background1': () => Background3(),
      'Background2': () => Background4(),
      'Background3': () => Background5(),
      'Background4': () => Background6(),
      'Background5': () => Background7(),
      'Background6': () => Background8(),
      'Background7': () => Background11(),
      'Background8': () => Background12(),
      'Background9': () => Background13(),
      'Background10': () => Background14(),
      'Background11': () => Background15(),
      'Background12': () => Background16(),
      'Background13': () => Background17(),
      'Background14': () => Background18(),
      'Background15': () => Background19(),
      'Background16': () => Background20(),
      'Background17': () => Background21(),
      'Background18': () => Background22(),
      'Background19': () => Background23(),
      'Background20': () => Background24(),
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
