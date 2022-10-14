import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data/entities/ricknmortycharacters.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  RicknMortyCharacters? characters;

  @override
  void initState(){
  }

  Future<String> _getCharacters() async{
    print("in");
    var url = Uri.parse('https://rickandmortyapi.com/api/character');
    var request = await http.get(url);
    if(request.statusCode == 200){
      characters = RicknMortyCharacters.fromJson(jsonDecode(request.body));
      return request.body;
    } else{
      return "Could not get Characters";
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
        future: _getCharacters(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              if(snapshot.data != null){
                return Text(snapshot.data!, style: TextStyle(color: Colors.black),);
              }else{
                return Text("No characters for you", style: TextStyle(color: Colors.black));
              }
            }else{
              return Text('Empty', style: TextStyle(color: Colors.black));
            }
          }else{
            print("Not yet");
            return CircularProgressIndicator();
          }
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
