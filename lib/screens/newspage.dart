import 'package:FlashNews/components/model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: NewsPage(),
        ));
  }
}

class NewsPage extends StatefulWidget {
  // final nameValue;
  // NewsPage(this.nameValue);
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future<List<Model>> fetchData() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=6c006257f8c44e6290b19b7955f94f22';
    var result = await http.get(url);
    

    List<Model> articles;

    if (result.statusCode == 200) {
      var news = json.decode(result.body);
      var data = news["articles"] as List;
      //print(data);
      articles = data.map<Model>((json) => Model.json(json)).toList();
      print('article is: ${articles[0]}');
    } else {
      throw Exception('Ooops! No News found!');
    }
    
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff49223d),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 20, top: 20),
                child: Text(
                  dailyDate,
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xff785a70),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 20),
                child: Text(
                  'FlashNews',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: RichText(
                  text: TextSpan(
                    text: 'Hello, ',
                    style: TextStyle(color: Color(0xffffffff), fontSize: 20),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'John! ', //widget.nameValue + '! ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(text: 'What would you like to read about?'),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Stack(
                  children: <Widget>[
                    searchField(),
                    Padding(
                      padding: const EdgeInsets.only(left: 300, top: 8),
                      child: CircleAvatar(
                        backgroundColor: Color(0xffdfa580),
                        radius: 28,
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.arrowRight,
                              color: Color(0xff785a70)),
                          onPressed: () {
                            print('clicked');
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 10),
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    categories(
                      Icon(FontAwesomeIcons.briefcase,
                          color: Color(0xff785a70)),
                      'Business',
                    ),
                    SizedBox(width: 20),
                    categories(
                        Icon(FontAwesomeIcons.music, color: Color(0xff785a70)),
                        'Music'),
                    SizedBox(width: 20),
                    categories(
                        Icon(FontAwesomeIcons.circleNotch,
                            color: Color(0xff785a70)),
                        'General'),
                    SizedBox(width: 20),
                    categories(
                        Icon(FontAwesomeIcons.pills, color: Color(0xff785a70)),
                        'Health'),
                    SizedBox(width: 20),
                    categories(
                        Icon(FontAwesomeIcons.atom, color: Color(0xff785a70)),
                        'Science'),
                    SizedBox(width: 20),
                    categories(
                        Icon(FontAwesomeIcons.basketballBall,
                            color: Color(0xff785a70)),
                        'Sports'),
                    SizedBox(width: 20),
                    categories(
                        Icon(FontAwesomeIcons.laptop, color: Color(0xff785a70)),
                        'Technology')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, bottom: 20),
                child: Text(
                  'Latest News',
                  style: TextStyle(color: Color(0xffffffff), fontSize: 30),
                ),
              ),
              Container(
                height: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0xff40152f)),
                child: Container(
                  height: 300,
                  child: FutureBuilder<List<dynamic>>(
                      future: fetchData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            padding: EdgeInsets.all(10),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    snapshot.data[index].content,
                                    style: TextStyle(
                                        color: Color(0xffffffff), fontSize: 30),
                                  ));
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget searchField() {
    return TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(15),
      ],
      cursorColor: Color(0xffffffff),
      style: TextStyle(height: 1.5, color: Color(0xffffffff), fontSize: 25),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff49223d)),
            borderRadius: BorderRadius.circular(50)),
        hintText: 'Search Here',
        hintStyle: TextStyle(color: Color(0xff785a70), fontSize: 20),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff785a70)),
            borderRadius: BorderRadius.circular(50)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff785a70)),
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }

  Widget categories(Icon value, String text) {
    return GestureDetector(
      onTap: () {
        print('clicked');
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 200,
        child: Stack(children: <Widget>[
          CircleAvatar(
            radius: 45,
            backgroundColor: Color(0xffffffff),
            child: Stack(
              children: <Widget>[
                Center(child: value),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 55),
                    child: Text(
                      text,
                      style: TextStyle(color: Color(0xff785a70), fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  // Widget data() {
  //   return FutureBuilder<List<dynamic>>(
  //       future: fetchData(),
  //       builder: (BuildContext context, AsyncSnapshot snapshot) {
  //         if (snapshot.hasData) {
  //           return ListView.builder(
  //             padding: EdgeInsets.all(10),
  //             itemCount: snapshot.data.length,
  //             itemBuilder: (BuildContext context, index) {
  //               return GestureDetector(
  //                 onTap: () {},
  //                 child: Text(snapshot.data[index].content)

  //               );
  //             },
  //           );
  //         } else {
  //                 return Center(child: CircularProgressIndicator());
  //               }
  //       });
  // }

  final dailyDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
}
