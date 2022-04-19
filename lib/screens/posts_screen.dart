import 'dart:convert';

import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:nocotine/constants/screens.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class PostsScreen extends StatefulWidget {
  const PostsScreen({ Key? key }) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  TextEditingController _BioController=new TextEditingController();
  var SaveBio="Bio";
  var _Name="";
  var _UserId;
  bool _visbleLike=false;
  var _userId;
  String dec="";
  final String assetName = 'assets/images/pack.svg';
  List _veiwPostListForOneUser=[{"TextPost":"hello1","feeling":"Happy 😄"},
  {"TextPost":"hello2","feeling":"Sad"},
  {"TextPost":"hello3","feeling":"sd3"},
  {"TextPost":"hello4","feeling":"sd3"}];
  String _feeling="";
  void initState() {
    
      getUserData();
    setState(() {
      _loadPostsOfOneUser();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Posts"),
        backgroundColor: AppColor.darkColor,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            child: FutureBuilder(
              future: _loadPostsOfOneUser(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    
                      itemCount: _veiwPostListForOneUser.length,
                      itemBuilder: (context, index) {
                        if(_veiwPostListForOneUser[index]['feeling'].toString().isNotEmpty){
                          
                            _feeling="is feeling";
                        }else{
                          _feeling="";
                        }
                      return  Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  
                                    Text("${_veiwPostListForOneUser[index]['first_name']} ${_veiwPostListForOneUser[index]['last_name']} ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                    
                                  
                                  Text("$_feeling"),
                            Text(" ${_veiwPostListForOneUser[index]['feeling']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                          
                            ],),
                            IconButton(onPressed: (){
                              _SavePostID(context, _veiwPostListForOneUser[index]['post_id']);
                            }, icon: Icon(Icons.visibility,color: AppColor.infoyColor,size: 22,))
                              ],
                            )
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                            height: 40,
                            padding: EdgeInsets.only(left: 20,right: 30),
                            margin: EdgeInsets.only(bottom: 15),
                            child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  strutStyle: StrutStyle(fontSize: 17.0),
                                  text: TextSpan(
                                          style: TextStyle(color: Colors.black,height:1.2),
                                          text: '${_veiwPostListForOneUser[index]['post_text']}'
                                          
                                        ),
                                    ),
                
                          ),
                          ),
                          (_veiwPostListForOneUser[index]['image_post'] != "") ? 
                            Container(
                              margin: EdgeInsets.only(left: 5,right: 5),
                              height: 200,
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loadingImage.gif',
                                image: '${baseUrl}images/${_veiwPostListForOneUser[index]['image_post']}',
                      ) ,)
                            : Text(""),
                          Container(
                            margin: EdgeInsets.only(left: 20,bottom: 10),
                            child: Row(children: [
                              Text("${_veiwPostListForOneUser[index]['Total_likes']} ",style: TextStyle(color: AppColor.infoyColor),),
                              Icon(Icons.thumb_up,size: 17,color: AppColor.infoyColor,),
                              Text("  ${_veiwPostListForOneUser[index]['total_comments']} ",style: TextStyle(color: AppColor.infoyColor),),
                              Icon(Icons.mode_comment,size: 17,color: AppColor.infoyColor,),
                              ],),
                          ),
                          
                          Divider()
                        ],
                      );}
                    );
                
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
      )
                
            
        ],
      )    ,
    );
  }
  void getUserData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      var _firstName;
      var _lastName;
      var _image;
      _Name="$_firstName $_lastName";
      _UserId=preferences.getString(id);
      
    });
  }
  _loadPostsOfOneUser()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _UserId=preferences.getString(id);
    var url = Uri.parse(veiwOneUserPostsUrl+"?User_id=$_UserId");
    var res = await http.get(url);
    var responseBody = jsonDecode(res.body);
    setState(() {
      _veiwPostListForOneUser=responseBody;
    });
    return _veiwPostListForOneUser;
  }
  _addLike(String postID) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      String _postId= postID;
      _userId=preferences.getString(id);
      var url=Uri.parse(createLikesUrl);
      var response = await http.post(url,body: {
        "post_id":_postId,
        "user_id":_userId,
      });
      print("Status Code: ${response.statusCode} \n Body: ${response.body}");
      if(response.statusCode==200){
        setState(() {
          _visbleLike=true;
        });
        
      }}
  _SavePostID(BuildContext context,String _postid) async{
    
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Save response
    
    preferences.setString(post_id, _postid);
    // push to home screen
    Navigator.pushNamed(context, Screens.comments.value);
    
  }
}