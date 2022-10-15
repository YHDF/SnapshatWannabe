import 'package:flutter/material.dart';
import '../shared/variables.dart' as globals;


class BottomBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      globals.Variables.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        backgroundColor: Colors.yellow,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconData(0xe3c8, fontFamily: 'MaterialIcons')),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconData(0xe154, fontFamily: 'MaterialIcons')),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconData(0xee67, fontFamily: 'MaterialIcons'), size: 50,),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconData(0xe61f, fontFamily: 'MaterialIcons')),
            label: 'Stories',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconData(0xe448, fontFamily: 'MaterialIcons')),
            label: 'Spotlight',
          ),
        ],
        currentIndex: globals.Variables.selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      );
  }
}
