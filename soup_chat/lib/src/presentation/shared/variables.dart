
library globals;

import 'package:flutter/cupertino.dart';
import 'package:soup_chat/src/presentation/pages/chatcontact.dart';
import 'package:soup_chat/src/presentation/pages/camera/camera.dart';

import '../pages/map/map.dart';



class Variables{
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> widgetOptions =  <Widget>[
    Carte(),
    const ChatContact(),
    const CameraApp(),
    const Text(
      'Comming soon...',
      style: optionStyle,
    ),
    const Text(
      'Index 4: School',
      style: optionStyle,
    ),
  ];
  static int selectedIndex = 1;
}



