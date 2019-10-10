import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube/screen/profile.dart';
import 'dart:async';
import 'dart:convert';

import 'package:youtube/screen/videoplayer.dart';

class Trending extends StatefulWidget {
  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  var images = [
    AssetImage("image/music.jpg"),
    AssetImage("image/gaming.jpg"),
    AssetImage("image/news.jpg"),
    AssetImage("image/movie.jpg"),
    AssetImage("image/fashion.jpg"),
  ];
  var textlist = [
    "Music",
    "Gaming",
    "News",
    "Movie",
    "Fashion",
  ];

  final String url = "http://userapi.tk/youtube/";
  List data;
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    this.getjsondata();
  }

  Future getjsondata() async {
    var response = await http.get(Uri.encodeFull(url));
    setState(() {
      var converdatatojason = json.decode(response.body);
      data = converdatatojason;
      isloading = false;
    });
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
            child: Container(
              child: isloading? CircularProgressIndicator():Container(
                child: SingleChildScrollView(
               child:Column(
                children: <Widget>[
                   Padding(
                    padding:  EdgeInsets.only(top: 2.0,left: 10.0),
                    child: Container(
                      height: 110.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: images.length,
                        itemBuilder: (BuildContext ctx, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                            padding: EdgeInsets.fromLTRB(2, 10, 12, 4),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: images[index],
                            ),
                          ),
                           Padding(
                             padding:  EdgeInsets.only(left: 10.0),
                             child: Text(textlist[index]),
                           ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListView.builder( 
                    
                  shrinkWrap: true,
                  primary: false,
                    itemCount: data.length,
                  itemBuilder: (BuildContext contex, index) {
                    return Column(
                      children: <Widget>[
                       GestureDetector(
                            onTap: () => _playvideo(data[index]['VideoURL'],data[index]['Name'],
                                  data[index]['ProfileiconURL'],
                                  data[index]['ThumbmnilURL'],
                                  data[index]['Views'],
                                  data[index]['Day'],
                                  data[index]['Title']),
                            child: Container(
                              color: Colors.black12,
                              height: 200.0,
                              width: double.infinity,
                              child: Image.network(data[index]['ThumbmnilURL'],),
                            ),
                          ),
                        ListTile(
                          leading: GestureDetector(
                            onTap: (){},
                               child: GestureDetector(
                              onTap: () => _goonprofile(
                                  data[index]['Name'],
                                  data[index]['ProfileiconURL'],
                                  data[index]['ThumbmnilURL'],
                                  data[index]['Views'],
                                  data[index]['Day'],
                                  data[index]['Title']),
                                                              child: CircleAvatar(
                                  backgroundImage:
                                  NetworkImage(data[index]['ProfileiconURL'])),
                               ),
                          ),
                          title: Text(data[index]['Title']),
                          subtitle: Text(data[index]['Name'] +
                              ' · ' +
                              data[index]['Views'] +
                              ' · ' +
                              data[index]['Day']),
                          trailing: Icon(Icons.more_vert),
                        )
                      ],
                    );
                  }),
                ],
              ),
              ),
            )
          
        ),
      ),
    );
  }
  _playvideo(String url,String name, String image, String thumbnail, String view,
      String time, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoApp(
                  url: url,
                  name: name,
                  image: image,
                  thumbnail: thumbnail,
                  view: view,
                  time: time,
                  title: title,
                )));}
  _goonprofile(String name, String image, String thumbnail, String view,
      String time, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(
                  name: name,
                  image: image,
                  thumbnail: thumbnail,
                  view: view,
                  time: time,
                  title: title,
                )));
  }
}