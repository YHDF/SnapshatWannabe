
library globals;

import 'package:flutter/cupertino.dart';
import 'package:soup_chat/src/presentation/pages/chatcontact.dart';



class Variables{
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> widgetOptions = const <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    ChatContact(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: School',
      style: optionStyle,
    ),
    Text(
      'Index 4: School',
      style: optionStyle,
    ),
  ];
  static int selectedIndex = 0;
}



