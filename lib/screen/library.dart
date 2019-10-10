import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:youtube/screen/videoplayer.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
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
      body:Center(
        child: isloading? CircularProgressIndicator(): Container(
          child: SingleChildScrollView(
                      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Recent",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 160.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (BuildContext ctx, index) =>GestureDetector(
                      onTap: ()=> _playvideo(data[index]['VideoURL'],data[index]['Name'],
                                data[index]['ProfileiconURL'],
                                data[index]['ThumbmnilURL'],
                                data[index]['Views'],
                                data[index]['Day'],
                                data[index]['Title']),
                          
                                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10.0,
                            ),
                            child: SizedBox(
                              width: 140.0,
                              height: 80.0,
                              child: Image.network(data[index]['ThumbmnilURL']),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 130,
                                padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          data[index]['Title'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          ),
                                        ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(
                                    Icons.more_vert,
                                    color: Colors.grey,
                                  ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: 130,
                          child: Text(data[index]['Name'], style: TextStyle(fontSize: 11),)),
                        
                        ],
                      ),
                    ),
                  ),
                ),
               Container(
                 height: 1.0,
                 color: Colors.black12,
               ),
               Container(
                 height: 10.0,
               ),
               Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                     child: Icon(Icons.history, size: 30,color: Colors.grey,),
                   ),
                   Text("History", style: TextStyle(fontSize: 18,),),
                   
                 ],
               ),
               Container(
                 height: 20.0,
               ),
                Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                     child: Icon(Icons.file_download, size: 30,color: Colors.grey,),
                   ),
                   Text("Downloads", style: TextStyle(fontSize: 18,),),
                  
                 ],
               ),
               Container(
                 height: 20.0,
               ),
                Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                     child: Icon(Icons.video_library, size: 30,color: Colors.grey,),
                   ),
                   Text("My Videos", style: TextStyle(fontSize: 18,),),
                  
                 ],
               ),
               Container(
                 height: 20.0,
               ),
                Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                     child: Icon(Icons.label, size: 30,color: Colors.grey,),
                   ),
                   Text("Purchase", style: TextStyle(fontSize: 18,),),
                   
                 ],
               ),
               Container(
                 height: 20.0,
               ),
                Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                     child: Icon(Icons.watch_later, size: 30,color: Colors.grey,),
                   ),
                   Text("Watch later", style: TextStyle(fontSize: 18,),),
                  
                 ],
               ),
               Container(
                 height: 20.0,
               ),
              Container(
                 height: 1.0,
                 color: Colors.black12,
               ),
               Container(
                 height: 20.0,
               ),
               Row(
                 children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text("Playlist (Recent added)"),
                  ),
                  Icon(Icons.arrow_drop_down),
                  Icon(Icons.playlist_add,color: Colors.lightBlue,),
                  Container(
                    width: 10,
                  ),
                  Container(
                    width: 80,
                    child: Text("NEW PLAYLIST", style: TextStyle(color: Colors.lightBlue),),
                  )
                 ],
               ),
               Container(
                 height: 20.0,
               ),
               Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                     child: Icon(Icons.thumb_up, size: 30,color: Colors.grey,),
                   ),
                   Text("Liked Videos", style: TextStyle(fontSize: 18,),),
                   
                 ],
               ),
               Container(
                 height: 20.0,
               ),
               


              ],
            ),
          ),
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
