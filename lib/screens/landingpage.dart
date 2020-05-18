import 'dart:async';
import 'package:FlashNews/screens/infopage.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/infopage': (BuildContext context) => NameInput(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff49223d),
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    final duration = Duration(seconds: 5);
    Future.delayed(duration, () {
      Navigator.pushNamed(
        context,
        '/infopage',
      );
    });
  }

  void timedState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              'FlashNews',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          Container(
              child: Image.asset(
            'images/logo.png',
            height: 150,
            width: 100,
          ),),
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 2,
          )
        ],
      ),
    );
  }
}
