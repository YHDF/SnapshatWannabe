import 'package:flutter/material.dart';
import 'package:soup_chat/src/presentation/widgets/bottombar.dart';
import 'package:soup_chat/src/presentation/widgets/topbar.dart';
import './shared/variables.dart' as globals;


class Bootstrap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BootstrapState();
}

class BootstrapState extends State<Bootstrap> {

  TopBar? _topBar;
  BottomBar? _bottomBar;

  @override
  void initState() {
    super.initState();
    _topBar = const TopBar();
    _bottomBar = BottomBar(callback);
  }
  callback(newIndex) {
    setState(() {
      if(newIndex == 0 || newIndex == 2){
        _topBar = null;
        _bottomBar = null;
      }else{
        _topBar = const TopBar();
        _bottomBar = BottomBar(callback);
      }
      globals.Variables.selectedIndex = newIndex;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Scaffold(
        body:  Center(
          child: globals.Variables.widgetOptions.elementAt(globals.Variables.selectedIndex)
    ),
        appBar: _topBar,
        bottomNavigationBar: _bottomBar,
      ),
    );
  }
}
