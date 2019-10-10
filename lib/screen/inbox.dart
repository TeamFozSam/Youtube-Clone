import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:youtube/screen/videoplayer.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
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
      body: Center(
        child: Container(
          child: isloading
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext contex, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                      child: GestureDetector(
                      onTap: ()=> _playvideo(data[index]['VideoURL'],data[index]['Name'],
                                data[index]['ProfileiconURL'],
                                data[index]['ThumbmnilURL'],
                                data[index]['Views'],
                                data[index]['Day'],
                                data[index]['Title']),
                          child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      data[index]['ProfileiconURL'])),
                            ),
                            Container(
                              width: 150.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                      data[index]['Title'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 3.0),
                                    child: Text(
                                      data[index]['Day'],
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20.0,
                              ),
                              child: SizedBox(
                                width: 100.0,
                                height: 50.0,
                                child: Image.network(data[index]['ThumbmnilURL']),
                              ),
                            ),
                            Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                            
                          ],
                        ),
                      ),
                    );
                  }),
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
                )));
  }
}
