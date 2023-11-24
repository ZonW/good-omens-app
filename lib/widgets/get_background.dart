import 'package:flutter/material.dart';
import 'package:good_omens/widgets/all_background.dart';

class TypeUtils {
  static dynamic typeOf(String name) {
    return ({
      'Background999': () => BackgroundX(),
      'Background0': () => Background0(),
      'Background1': () => Background1(),
      'Background2': () => Background2(),
      'Background3': () => Background3(),
      'Background4': () => Background4(),
      'Background5': () => Background5(),
      'Background6': () => Background6(),
      'Background7': () => Background7(),
      'Background8': () => Background8(),
      'Background9': () => Background11(),
      'Background10': () => Background12(),
      'Background11': () => Background13(),
      'Background12': () => Background14(),
      'Background13': () => Background15(),
      'Background14': () => Background16(),
      'Background15': () => Background17(),
      'Background16': () => Background18(),
      'Background17': () => Background19(),
      'Background18': () => Background20(),
      'Background19': () => Background21(),
      'Background20': () => Background22(),
      'Background21': () => Background23(),
      'Background22': () => Background24(),
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
