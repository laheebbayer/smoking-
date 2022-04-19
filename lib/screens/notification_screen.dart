import 'dart:convert';

import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:nocotine/constants/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({ Key? key }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List _veiwNotificationListForOneUser=[{"TextPost":"hello1","feeling":"Happy 😄"},
            {"TextPost":"hello2","feeling":"Sad"},
            {"TextPost":"hello3","feeling":"sd3"},
            {"TextPost":"hello4","feeling":"sd3"}];
  var _UserId;
  String _feeling="";
  var favoriteIcon=Icons.favorite;
  var CommentIcon=Icons.mode_comment;
  var IconNotification=Icons.autorenew;
  @override
  void initState() {
    setState(() {
      _loadNotificationOfOneUser();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications),
          SizedBox(width: 8,),
          Text('Notification'),
        ],
      ),
      backgroundColor: AppColor.darkColor,
    ),
    body:FutureBuilder(
              future: _loadNotificationOfOneUser(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    
                      itemCount: _veiwNotificationListForOneUser.length,
                      itemBuilder: (context, index) {
                        if(_veiwNotificationListForOneUser[index]['icon']=="favorite"){
                          IconNotification=favoriteIcon;
                        }else if(_veiwNotificationListForOneUser[index]['icon']=="mode_comment"){
                          IconNotification=CommentIcon;
                        }
                      return   Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading:  CircleAvatar(
                                      backgroundImage: NetworkImage("${ImageUrl}${_veiwNotificationListForOneUser[index]['image']}"),
                                      backgroundColor: AppColor.whiteColor,
                                      radius: 20,
                                    ),
                              title: RichText(
                                text:  TextSpan(children: [
                                  TextSpan(
                                      text: "${_veiwNotificationListForOneUser[index]['first_name']} ${_veiwNotificationListForOneUser[index]['last_name']} ",
                                      style: TextStyle(
                                          fontSize: 15,fontWeight: FontWeight.bold, color: Colors.black)),
                                  TextSpan(
                                      text: "${_veiwNotificationListForOneUser[index]['body']}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black)),
                                  
                                ]),
                              ),
                                  
                                  
                              
                              subtitle: Text("${_veiwNotificationListForOneUser[index]['date']}"),
                              trailing: Icon(IconNotification,color: AppColor.lightyColor,),
                              onTap: (){
                                SavePostID(context, _veiwNotificationListForOneUser[index]['post_id']);
                              },
                            ),
                            
                          )
                        ],
                      ); });
                
                }
                else{
                  return Container(
                    padding: EdgeInsets.only(top: 35),
                    child: Center(
                      child: CircularProgressIndicator(
                      color: AppColor.infoyColor,
                    ),
                    )
                  );
                }
              },
            ),
      
    );
  }
    _loadNotificationOfOneUser()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _UserId=preferences.getString(id);
    var url = Uri.parse(viewNotificationUrl+"?User_id=$_UserId");
    var res = await http.get(url);
    var responseBody = jsonDecode(res.body);
    setState(() {
      _veiwNotificationListForOneUser=responseBody;
    });
    return _veiwNotificationListForOneUser;
  }
  SavePostID(BuildContext context,String _postid) async{
    
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Save response
    
    preferences.setString(post_id, _postid);
    // push to home screen
    Navigator.pushNamed(context, Screens.comments.value);
    
  }
}