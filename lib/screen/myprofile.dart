import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body:Center(
        child:  Container(
          child: SingleChildScrollView(
                      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                Container(
                  height: 160.0,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.only(left: 10.0, top:10.0),
                        child: CircleAvatar(
                  radius: 26,
                  backgroundImage: AssetImage("image/my.jpg"),
                ),
                      ),
                Row(
                  children: <Widget>[
                    
                    Padding(
                      padding:  EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text("Abdul Samad(FozSam)", style: TextStyle(fontSize: 18),),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 10.0, top: 4.0),
                  child: Text("sameerahmad.asa.2016@gmail.com",style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 10.0,top: 4),
                  child: Text("Manage your Google Account", style: TextStyle(color: Colors.blue,fontSize: 16),
                ),
                )
                    ],
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
                     child: Icon(Icons.person, size: 30,color: Colors.grey,),
                   ),
                   Text("Your channel", style: TextStyle(fontSize: 18,),),
                   
                 ],
               ),
               Container(
                 height: 20.0,
               ),
                Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                     child: Icon(Icons.indeterminate_check_box, size: 30,color: Colors.grey,),
                   ),
                   Text("Time watched", style: TextStyle(fontSize: 18,),),
                  
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
                   Text("Get Youtube Premium", style: TextStyle(fontSize: 18,),),
                  
                 ],
               ),
               Container(
                 height: 20.0,
               ),
                Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                     child: Icon(Icons.stay_primary_landscape, size: 30,color: Colors.grey,),
                   ),
                   Text("Paid memberships", style: TextStyle(fontSize: 18,),),
                   
                 ],
               ),
               Container(
                 height: 20.0,
               ),
                Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                     child: Icon(Icons.person_pin, size: 30,color: Colors.grey,),
                   ),
                   Text("Switch Account", style: TextStyle(fontSize: 18,),),
                  
                 ],
               ),
                Container(
                 height: 20.0,
               ),
               Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                     child: Icon(Icons.person_pin, size: 30,color: Colors.grey,),
                   ),
                   Text("Turn on Incognito", style: TextStyle(fontSize: 18,),),
                  
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
               Column(
                 children: <Widget>[
                   Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                     child: Icon(Icons.settings, size: 30,color: Colors.grey,),
                   ),
                   Text("Settings", style: TextStyle(fontSize: 18,),),
                  
                 ],
               ),
               Container(
                 height: 20.0,
               ),
               Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                     child: Icon(Icons.help, size: 30,color: Colors.grey,),
                   ),
                   Text("Help & feedback", style: TextStyle(fontSize: 18,),),
                  
                 ],
               ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text("Privacy Policy"),
                  ),
                  
                  
                  
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
 
}
