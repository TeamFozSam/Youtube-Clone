import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:youtube/screen/videoplayer.dart';

class Profile extends StatefulWidget {
  String name;
  String image;
  String thumbnail;
  String view;
  String time;
  String title;
  Profile(
      {Key key,
      @required this.name,
      this.image,
      this.thumbnail,
      this.view,
      this.time,
      this.title})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState(
      name: name,
      image: image,
      thumbnail: thumbnail,
      view: view,
      time: time,
      title: title);
}

class _ProfileState extends State<Profile> {
  String name;
  String image;
  String thumbnail;
  String view;
  String time;
  String title;
  _ProfileState(
      {Key key,
      @required this.name,
      this.image,
      this.thumbnail,
      this.view,
      this.time,
      this.title});

  List data;
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    this.getjsondata();
  }

  Future getjsondata() async {
    final String url = "http://userapi.tk/youtube/videowithid?Name=$name";
    var response = await http.get(Uri.encodeFull(url));
    setState(() {
      var converdatatojason = json.decode(response.body);
      data = converdatatojason;
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
          backgroundColor: Colors.purple,
          actions: <Widget>[
            Icon(
              Icons.search,
              size: 30,
            ),
            Container(
              width: 20.0,
            ),
            Icon(
              Icons.more_vert,
              size: 30,
            ),
            Container(
              width: 20.0,
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("HOME"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("VIDEOS"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("PLAYLISTS"),
              )
            ],
          ),
        ),
        body: Center(
          child: isloading
              ? CircularProgressIndicator()
              : TabBarView(
                  children: <Widget>[
                    Container(
                      color: Colors.white70,
                      child: Container(
                        child: Container(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //  crossAxisAlignment: CrossAxisAlignment.start,
                              //  mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Image.asset("image/banner.jpg"),
                                ),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 100.0,
                                      color: Color(0xfff4f4f4),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              radius: 35,
                                              backgroundImage:
                                                  NetworkImage(image),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    width: 120,
                                                    child: Text(
                                                      name,
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    )),
                                                Container(
                                                  height: 5.0,
                                                ),
                                                Text("10M Subscribes",
                                                    style: TextStyle(
                                                        color: Colors.grey)),
                                                Container(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "image/subscribe.png",
                                                      height: 14.0,
                                                      width: 14.0,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8),
                                                      child: Text("SUBSCRIBED",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey)),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 60.0, left: 320),
                                      child: Icon(
                                        Icons.notifications_active,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 10,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: data.length,
                                    itemBuilder: (BuildContext contex, index) {
                                      return Column(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () => _playvideo(
                                                data[index]['VideoURL'],
                                                data[index]['Name'],
                                                data[index]['ProfileiconURL'],
                                                data[index]['ThumbmnilURL'],
                                                data[index]['Views'],
                                                data[index]['Day'],
                                                data[index]['Title']),
                                            child: SizedBox(
                                              width: 325,
                                              child: Image.network(
                                                  data[index]['ThumbmnilURL']),
                                            ),
                                          ),
                                          ListTile(
                                            leading: GestureDetector(
                                              onTap: () {},
                                              child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      data[index]
                                                          ['ProfileiconURL'])),
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
                        ),
                      ),
                    ),
                    Container(
                        color: Colors.white70,
                        child: SingleChildScrollView(
                          child: Center(
                            child: isloading
                                ? CircularProgressIndicator()
                                : Column(
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: data.length,
                                          itemBuilder:
                                              (BuildContext contex, index) {
                                            return GestureDetector(
                                              onTap: () => _playvideo(
                                                  data[index]['VideoURL'],
                                                  data[index]['Name'],
                                                  data[index]['ProfileiconURL'],
                                                  data[index]['ThumbmnilURL'],
                                                  data[index]['Views'],
                                                  data[index]['Day'],
                                                  data[index]['Title']),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Container(
                                                        height: 80.0,
                                                        child: Image.network(data[
                                                                index]
                                                            ['ThumbmnilURL'])),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                            width: 130,
                                                            child: Text(
                                                              data[index]
                                                                  ['Title'],
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            )),
                                                        Container(
                                                            width: 160,
                                                            child: Text(
                                                              data[index]
                                                                      ['Day'] +
                                                                  ' · ' +
                                                                  data[index]
                                                                      ['Views'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Icon(
                                                      Icons.more_vert,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  // GestureDetector(
                                                  //   onTap: () {},
                                                  //   child: SizedBox(
                                                  //     width: 325,
                                                  //     child: Image.network(data[index]['ThumbmnilURL']),
                                                  //   ),
                                                  // ),
                                                  // ListTile(
                                                  //   leading: Image.network(data[index]['ThumbmnilURL'],),
                                                  //   title: Text(data[index]['Title']),
                                                  //   subtitle: Text(
                                                  //       data[index]['Views'] +
                                                  //       ' · ' +
                                                  //       data[index]['Day']),
                                                  //   trailing: Icon(Icons.more_vert),
                                                  // )
                                                ],
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                          ),
                        )),
                    Container(
                      child: Column(
                        children: <Widget>[Text("No playlist on this channel")],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  _playvideo(String url, String name, String image, String thumbnail,
      String view, String time, String title) {
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
}
