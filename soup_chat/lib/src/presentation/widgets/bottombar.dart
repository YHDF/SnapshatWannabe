import 'package:flutter/material.dart';
import '../shared/variables.dart' as globals;


class BottomBar extends StatefulWidget {

  final Function(int index)? callback;

  const BottomBar(this.callback);

  @override
  State<StatefulWidget> createState() => BottomBarState(callback);
}

class BottomBarState extends State<BottomBar> {
  BottomBarState(Function(int index)? callback);


  @override
  void initState() {
    super.initState();
  }


  void _onItemTapped(int index) {
    globals.Variables.selectedIndex = index;
    widget.callback!(index);

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
