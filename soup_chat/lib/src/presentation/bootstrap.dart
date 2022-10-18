import 'package:flutter/material.dart';
import 'package:soup_chat/src/presentation/widgets/bottombar.dart';
import 'package:soup_chat/src/presentation/widgets/topbar.dart';
import './shared/variables.dart' as globals;


class Bootstrap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BootstrapState();
}

class BootstrapState extends State<Bootstrap> {

  @override
  void initState() {
    super.initState();
  }

  callback(newIndex) {
    setState(() {
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
        appBar: TopBar(),
        bottomNavigationBar: BottomBar(callback),
      ),
    );
  }
}
