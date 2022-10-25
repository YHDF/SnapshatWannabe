import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soup_chat/src/presentation/bootstrap.dart';
import 'package:soup_chat/src/presentation/pages/initial_page.dart';

import 'data/repositories/auth_repository.dart';

void main() async {
  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/

  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soup Chat',
      theme: ThemeData(
        fontFamily: 'Fredoka',
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Soup Chat Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final AuthRepository? authRepository = AuthRepository.getInstance();

  @override
  void initState(){
    super.initState();
  }


  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(authRepository!.isSignedIn()) {
      return Bootstrap();
    } else {
      return InitialPage();
    }
  }
}
