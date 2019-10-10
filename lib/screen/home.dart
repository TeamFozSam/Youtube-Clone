// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube/screen/profile.dart';
import 'dart:async';
import 'dart:convert';

import 'package:youtube/screen/videoplayer.dart';
// import 'package:connectivity/connectivity.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // var _connectionStatus = 'Unknown';
  // Connectivity connectivity;
  // StreamSubscription<ConnectivityResult> subscription;

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
                            onTap: () => _goonprofile(
                                data[index]['Name'],
                                data[index]['ProfileiconURL'],
                                data[index]['ThumbmnilURL'],
                                data[index]['Views'],
                                data[index]['Day'],
                                data[index]['Title']),
                            child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    data[index]['ProfileiconURL'])),
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
