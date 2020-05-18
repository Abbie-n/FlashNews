import 'package:FlashNews/screens/newspage.dart';
import 'package:flutter/material.dart';

//this class receives name input from textfield
class NameInput extends StatefulWidget {
  @override
  _NameInputState createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff49223d),
      body: SizedBox(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 30, top: 40),
                child: Image.asset(
                  'images/logo.png',
                  height: 150,
                  width: 100,
                ),
              ),
              TextField(
                controller: name,
                autofocus: false,
                cursorWidth: 2.0,
                cursorColor: Colors.white,
                style: TextStyle(height: 2.0, color: Colors.white, fontSize: 20),
                // the field's border and placeholder
                decoration: InputDecoration(
                  labelText: 'May I know your name?',
                  labelStyle: TextStyle(fontSize: 30, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: RaisedButton(
                  hoverColor: Colors.white24,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15, right: 30, left: 30),
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  elevation: 7,
                  onPressed: () {
                    nameData(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//function to send name input value to next screen
  void nameData(BuildContext context) {
    String nameValue = name.text;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewsPage()));//nameValue)));
  
}
}