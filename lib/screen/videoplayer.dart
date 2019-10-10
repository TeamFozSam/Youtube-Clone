import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:youtube/screen/profile.dart';

class VideoApp extends StatefulWidget {
  String url;
  String name;
  String image;
  String thumbnail;
  String view;
  String time;
  String title;
  VideoApp(
      {Key key,
      @required this.url,
      this.name,
      this.image,
      this.thumbnail,
      this.view,
      this.time,
      this.title})
      : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState(
      url: url,
      name: name,
      image: image,
      thumbnail: thumbnail,
      view: view,
      time: time,
      title: title);
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  String url;
  String name;
  String image;
  String thumbnail;
  String view;
  String time;
  String title;
  _VideoAppState(
      {Key key,
      @required this.url,
      this.name,
      this.image,
      this.thumbnail,
      this.view,
      this.time,
      this.title});

  final String url1 = "http://userapi.tk/youtube/";
  List data;
  bool isloading = true;

  Future getjsondata() async {
    var response = await http.get(Uri.encodeFull(url1));
    setState(() {
      var converdatatojason = json.decode(response.body);
      data = converdatatojason;
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    super.initState();
    this.getjsondata();
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:  Center(
            child: Container(
                child: isloading
                    ? CircularProgressIndicator()
                    : Container(
                      
                    child:SingleChildScrollView(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                        children: <Widget>[
                          Container(
                            height: 24,
                          ),
                          
                            
                             GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                                 child: Container(
                                  height: 200.0,
                                  width: double.infinity,
                                  color: Colors.black,
                                  child: _controller.value.initialized
                                      ? AspectRatio(
                                          aspectRatio:
                                              _controller.value.aspectRatio,
                                          child: Container(
                                              child: VideoPlayer(_controller)),
                                        )
                                      : Container(),
                                ),
                              ),
                              
                            
                          Container(
                            height: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      child: Container(
                                          width: 310,
                                          child: Text(
                                            title,
                                            style: TextStyle(
                                              fontSize: 22,
                                            ),
                                          )),
                                    ),
                                    Icon(Icons.arrow_drop_down,
                                        size: 30, color: Colors.grey),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10.0),
                                  child: Text(view + ' views',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black54)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 26.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.thumb_up,
                                                size: 28,
                                                color: Colors.lightBlue),
                                            Text("15M",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black54))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 26.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.thumb_down,
                                                size: 28, color: Colors.grey),
                                            Text("0",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black54))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 26.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.screen_share,
                                                size: 28, color: Colors.grey),
                                            Text("Share",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black54))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 26.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.file_download,
                                                size: 28, color: Colors.grey),
                                            Text("Download",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black54))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 26.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.playlist_add,
                                                size: 28, color: Colors.grey),
                                            Text("Save",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black54))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 10.0,
                          ),
                          Container(
                            height: 1.0,
                            color: Colors.black12,
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 70.0,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () => _goonprofile(image, name),
                                        child: CircleAvatar(
                                          radius: 24,
                                          backgroundImage: NetworkImage(image),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
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
                                                style: TextStyle(fontSize: 16),
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
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18.0, left: 210),
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset(
                                        "image/subscribe.png",
                                        height: 14.0,
                                        width: 14.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text("SUBSCRIBED",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Icon(
                                          Icons.notifications_active,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          Container(
                            height: 1.0,
                            color: Colors.black12,
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 14, top: 12.0),
                                child: Text("Up next",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 180, top: 12.0),
                                child: Text("Autoplay",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3, top: 12.0),
                                child: Image.asset(
                                  "image/off.png",
                                  height: 30,
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 2.0,
                          ),
                          Column(
                            children: <Widget>[
                              ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: data.length,
                                  itemBuilder: (BuildContext contex, index) {
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
                                            padding: EdgeInsets.only(
                                                left: 8.0,
                                                top: 8.0,
                                                right: 8.0),
                                            child: Container(
                                                height: 80.0,
                                                width: 140.0,
                                                color: Colors.black,
                                                child: Image.network(data[index]
                                                    ['ThumbmnilURL'])),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    width: 130,
                                                    child: Text(
                                                      data[index]['Title'],
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    )),
                                                Container(
                                                    width: 160,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          data[index]['Name'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          data[index]['Views'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Icon(
                                              Icons.more_vert,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              Container(
                                height: 20.0,
                              ),
                              Container(
                                height: 60.0,
                                width: double.infinity,
                                color: Colors.black12,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                        "    Remember to keep comments respsctful and to \n    follow our Community Guildlines "),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 14, top: 12.0),
                                    child: Text("Comments",
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 14, top: 12.0),
                                    child: Text("10M",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16)),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 180, top: 12.0),
                                    child: Icon(
                                      Icons.format_list_numbered_rtl,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 400.0,
                              ),
                            ],
                          ),
                        ],
                      ))),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _playvideo(String url, String name, String image, String thumbnail,
      String view, String time, String title) {
    Navigator.pushReplacement(
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

  _goonprofile(String image, String name) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(
                  image: image,
                  name: name,
                )));
  }
}
