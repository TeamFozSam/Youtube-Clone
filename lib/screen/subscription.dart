import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:youtube/screen/allchannel.dart';
import 'package:youtube/screen/profile.dart';
import 'package:youtube/screen/videoplayer.dart';

class Subscrip extends StatefulWidget {
  @override
  _SubscripState createState() => _SubscripState();
}

class _SubscripState extends State<Subscrip> {
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
            child: isloading
                ? CircularProgressIndicator()
                : Container(
                    child:SingleChildScrollView(
        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 2.0, left: 10.0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 110.0,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: data.length,
                                  itemBuilder: (BuildContext ctx, index) =>
                                      Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(2, 10, 12, 4),
                                        child: GestureDetector(
                                onTap: () => _goonprofile(
                                data[index]['Name'],
                                data[index]['ProfileiconURL'],
                                data[index]['ThumbmnilURL'],
                                data[index]['Views'],
                                data[index]['Day'],
                                data[index]['Title']),
                                                                                  child: CircleAvatar(
                                              radius: 30.0,
                                              backgroundImage: NetworkImage(
                                                  data[index]['ProfileiconURL'])),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Container(
                                            width: 70.0,
                                            height: 14.0,
                                            child: Text(data[index]['Name'], style: TextStyle(color: Colors.black54),),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 290),
                                child: Container(
                                  //  color: Colors.red,
                                  height: 110.0,
                                  width: 60.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: _goall,
                                            child: Text(
                                          "ALL",
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 4.0,
                        ),
                        Container(
                          height: 1.0,
                          color: Colors.black12,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0, left: 14.0),
                          child: Row(
                            children: <Widget>[
                              Text("Videos and posts"),
                              Icon(Icons.arrow_drop_down, color: Colors.grey,),
                              
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                          child: Container(
                            height: 1.0,
                            color: Colors.black12,
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
                  )),
      ),
    );
  }
  _goall(){
    Navigator.push(context, MaterialPageRoute(
      builder: (context)=>All(
        
      )
    ));
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
                )));
  }
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
