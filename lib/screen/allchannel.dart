import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:youtube/screen/profile.dart';

class All extends StatefulWidget {
  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
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
     return 
    WillPopScope(

	    onWillPop: () {
	    	
		    moveToLastScreen();
	    },

	    child: Scaffold(
        appBar: AppBar(
           leading: IconButton(icon: Icon(
				    Icons.arrow_back, color: Colors.black,),
				    onPressed: () {
		    	    
		    	    moveToLastScreen();
				    }
		    ),
          backgroundColor: Colors.white,
          title: Text('Channel list', style: TextStyle(color: Colors.black),),
          actions: <Widget>[
            Icon(Icons.search, color: Colors.black54,size: 30,),
            Container(
              width: 20.0,
            ),
            Icon(Icons.more_vert, color: Colors.black54,size: 30,),
            Container(
              width: 20.0,
            ),
            
          ],
        ),
       body: Center(
              child: isloading? CircularProgressIndicator():Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 16.0),
                          child: Text("Most relevant", style: TextStyle(fontSize: 18),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 4.0),
                          child: Icon(Icons.arrow_drop_down, color: Colors.grey,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 110.0),
                          child: Text("MANAGE", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.blue),),
                        ),
                      ],
                    ),
                    Container(
                      height: 10.0,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: data.length,
                      itemBuilder: (BuildContext contex, index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14.0),
                          child: ListTile(
                            leading:   GestureDetector(
                                onTap: () => _goonprofile(
                                data[index]['Name'],
                                data[index]['ProfileiconURL'],
                                data[index]['ThumbmnilURL'],
                                data[index]['Views'],
                                data[index]['Day'],
                                data[index]['Title']),
                               child: CircleAvatar(
                                radius: 30,
                                 backgroundImage: NetworkImage(
                                 data[index]['ProfileiconURL'])),
                                  ),
                                  title: Text(data[index]['Name']),
                               
                          ),
                        );
                      }
                    )
                  ],
                ),
              )
       ),
      )
      
     );
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
  void moveToLastScreen() {
		Navigator.pop(context,);
  }

  // _goonsubcription(){
  //   Navigator.pop(context);
  // }
}