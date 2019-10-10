import 'package:flutter/material.dart';
import 'package:youtube/screen/home.dart';
import 'package:youtube/screen/inbox.dart';
import 'package:youtube/screen/library.dart';
import 'package:youtube/screen/myprofile.dart';
import 'package:youtube/screen/subscription.dart';
import 'package:youtube/screen/trending.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentindex = 0;
  var page = [Home(), Trending(), Subscrip(), Inbox(), Library()];
  void ontapped(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          "image/1.png",
          width: 100.0,
        ),
        actions: <Widget>[
          Icon(
            Icons.video_call,
            color: Colors.black54,
            
          ),
          Container(
            width: 20.0,
          ),
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black54,
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          Container(
            width: 20.0,
          ),
          Column(
            children: <Widget>[
              Container(
                height: 12.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyProfile()),
                  );
                },
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage("image/my.jpg"),
                ),
              ),
              Container(
                height: 10.0,
              ),
            ],
          ),
          Container(
            width: 12.0,
          ),
        ],
      ),
      body: page[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        onTap: ontapped,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.red,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), title: Text("Trending")),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions), title: Text("Subscription")),
          BottomNavigationBarItem(icon: Icon(Icons.mail), title: Text("Inbox")),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder), title: Text("Library")),
        ],
      ),
    );
  }

  ontab(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  // _myprofile() {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => MyProfile(

  //               )));
  // }
}


class DataSearch extends SearchDelegate<String> {
  // final String url = "http://userapi.tk/youtube/";
  // List data;
  // bool isloading = true;
  // @override
  // void initState() {
  //   super.initState();
  //   this.getjsondata();
  // }

  // Future getjsondata() async {
  //   var response = await http.get(Uri.encodeFull(url));
  //   setState(() {
  //     var converdatatojason = json.decode(response.body);
  //     data = converdatatojason;
  //     isloading = false;
  //   });
  // }
  final cities = [
    "Sameer",
    "Abdul Samad",
    "Foz",
    "Raushan",
    "Shivam",
    "Selven",
    "Jay",
    "Shobit",
    "Dharmendre",
    "Alan krit",
    'Shaksham'
  ];
  final recentcities = ["Sameer", "Abdul Samad", "Foz", "Raushan", "Shivam"];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.grey,
          shape: StadiumBorder(),
          child: Center(
              child: Text(
            query,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          )),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionlist = query.isEmpty
        ? recentcities
        : cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.person),
        title: RichText(
          text: TextSpan(
              text: suggestionlist[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionlist[index].substring(query.length),
                    style: TextStyle(color: Colors.blue))
              ]),
        ),
      ),
      itemCount: suggestionlist.length,
    );
  }
}

