import 'dart:convert';
import 'dart:ffi';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
class CommentsScreen extends StatefulWidget {
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  String _commentText="";
  var _UserId;
  List CommentsContent = [];
  List PostContent = [{
        "id": "38",
        "first_name": "loading",
        "last_name": "..",
        "email": "",
        "post_text": "loading..",
        "post_id": "59",
        "feeling": "",
        "image_post": "loadingImage.gif",
    }];
  var commentImage="loadingImage.gif";
  var TotalLikes="0";
  var TotalComments="0";
  var _PostID;
  var _UserIdPost;
  bool _likeVisable=false;
  String _feeling="";
  double sideLength = 50;
  @override
  void initState() {
    setState(() {
      getUserImage();
      getPostId();
      _loadPost();
      _loadCommentsOfOnePost();
      
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Comments"),
        backgroundColor: AppColor.darkColor,
      ),
      body: Container(
        child: CommentBox(
          userImage:
              "$ImageUrl$commentImage",
          child: commentChild(CommentsContent),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              setState(() {
                addNewComment(_PostID);
                print(_PostID);
                updateTotalComments(_PostID);
                _commentText=_commentController.text;
              });
              _commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: _commentController,
          backgroundColor: AppColor.whiteColor,
          textColor: AppColor.infoyColor,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: AppColor.infoyColor),
        ),
      ),
    );
  }
  Widget commentChild(data) {
    return  SingleChildScrollView(
      child: Column(
      children: [
        Column(
          children: [
            Container(
                            margin: EdgeInsets.only(left: 15,bottom: 10,top: 10,right: 10),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Row(children: [
                                InkWell(
                                  child: Text("${PostContent[0]['first_name']} ${PostContent[0]['last_name']} ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  onTap: (){
                                    //TODO
                                    print("object");
                                  },
                                ),
                                Text("$_feeling"),
                            Text(" ${PostContent[0]['feeling']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                            ],),
                            
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                          
                                FutureBuilder(
      
                                  future: _testLikes(),
                                  builder: (context,snapshot){
                                    if(snapshot.hasData){
                                      return AnimatedIconButton(
                                            
                                            size: 25,
                                            duration:  Duration(milliseconds: 700),
                                            splashColor: AppColor.primarySplashColor,
                                            icons:  <AnimatedIconItem>[
                                              
                                              if (_likeVisable)AnimatedIconItem(
                                                icon: Icon(Icons.favorite, color: AppColor.primaryColor),
                                                onPressed: (){
                                                  setState(() {
                                                    deleteLike();
                                                  });
                                                }
                                              )else
                                              AnimatedIconItem(
                                                icon: Icon(Icons.favorite_outline, color: AppColor.infoyColor),
                                                onPressed: (){
                                                  setState(() {
                                                    addLike();
                                                    
                                                  
                                                    
                                                  });
                                                }
                                              ),
                                            ],
                                          );
                                    }
                                    else{
                                      return Container(
                                            margin: EdgeInsets.only(top: 14,right: 14),
                                            width: 20,
                                            height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                              color: AppColor.infoyColor,
                                            ),
                                            
                                          );
                                    }
                                  },
                                ),
                                
                            ],
                          ),
                            ],)
                          ),
            Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  margin: EdgeInsets.only(bottom: 15),
                  child: RichText(
                      
                        strutStyle: StrutStyle(fontSize: 17.0),
                        text: TextSpan(
                                style: TextStyle(color: Colors.black,height:1.2),
                                text: '${PostContent[0]['post_text']}'
                                
                              ),
                          ),
      
                ),
                ),
            
              (PostContent[0]['image_post'] != "") ? 
                            Container(
                            
                              height: 200,
                              child:  FullScreenWidget(
                              child: Center(
                                child: Hero(
                                  tag: "customBackground",
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                                        "${baseUrl}images/${PostContent[0]['image_post']}",
                                                        fit: BoxFit.cover,
                                                      ),
                                  ),
                                ),
                              ),
                            ),
                            )
                            : Text(""),
            Container(
          margin: EdgeInsets.only(left: 20,bottom: 10),
          child: Row(children: [
            FutureBuilder(
      
              future: _loadTotalComments(),
              builder: (context,snapshot){
                
                if(snapshot.hasData){
                  return Text("$TotalLikes ",style: TextStyle(color: AppColor.infoyColor),);
                }
                else{
                  return Container(
                    child: Text("$TotalLikes ",style: TextStyle(color: AppColor.infoyColor),),
                  );
                }
              },
            ),
            
            Icon(Icons.favorite,size: 17,color: AppColor.infoyColor,),
            
            FutureBuilder(
      
              future: _loadTotalLikes(),
              builder: (context,snapshot){
                
                if(snapshot.hasData){
                  return Text("  $TotalComments ",style: TextStyle(color: AppColor.infoyColor),);
                }
                else{
                  return Container(
                    child: Text(" $TotalComments ",style: TextStyle(color: AppColor.infoyColor),),
                  );
                }
              },
            ),
            
            Icon(Icons.mode_comment,size: 17,color: AppColor.infoyColor,),
            ],),
        ),

            Divider(thickness: 1.2,),
            SizedBox(height: 10,),
            Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
            ],
          ))

          ],
        ),
        FutureBuilder(
      
              future: _loadCommentsOfOnePost(),
              builder: (context,snapshot){
                
                if(snapshot.hasData){
                  return ListView.builder(
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: CommentsContent.length,
                      itemBuilder: (context, index) {
                      return  Container(
                        margin: EdgeInsets.only(left: 10,bottom: 15),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                ChatBubble(
                                clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                                backGroundColor: AppColor.commentsColor,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                                  ),
                                  child:Column(
                                    children: [
                                    InkWell(
                                      child: Row(children: [
                                    CircleAvatar(
                                      backgroundColor: AppColor.whiteColor,
                                      backgroundImage: NetworkImage("$ImageUrl${CommentsContent[index]['image']}"),
                                      radius: 13,
                                    ),
                                    Text(" ${CommentsContent[index]['first_name']} ${CommentsContent[index]['last_name']}",style: TextStyle(fontWeight: FontWeight.bold),),
                                    ],),
                                      onTap: (){
                                        //TODO
                                        print("object");
                                      },
                                    ),

                                    SizedBox(height: 10,),
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("${CommentsContent[index]['comment_text']}",style: TextStyle(height: 1.2,fontSize: 13),),
                                    ),
                                    )
                                    ],
                                  )
                                ),
                              )
                              ],
                            
                          
                          
                        
                      ),
                      ),
                      )
                          ;}
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
            ) 
  ,
      ],
    )
  
  ,
    );
  
  }
  addNewComment(String _postId) async{
      SharedPreferences preferences = await SharedPreferences.getInstance();

      _UserId=preferences.getString(id);
      print("****************************************************************");
      print("User id +++++++++++$_UserId");
      print("Comment Text +++++++++++$_commentText");
      print("Post Id $_postId");
      String UserId= _UserId;
      String CommentText= _commentText;
      String PostID= _postId;
      if(CommentText.isEmpty || UserId.isEmpty || PostID.isEmpty){
        
        print("NO DATA"); 
        return;
      }
      var url=Uri.parse(createCommentURL);
      var response = await http.post(url,body: {
        "post_id":PostID,
        "user_id":UserId,
        "comment_text":CommentText,
      });
      print("Status Code: ${response.statusCode} \n Body: ${response.body}");
      if(response.statusCode==200){
        print("Comment created");
        
          String dateDay = DateTime.now().day.toString();
          String dateMonth = DateTime.now().month.toString();
          String dateYear = DateTime.now().year.toString();
          addNewCommentNotificatin(_postId, "Commented on Your Post", "mode_comment", "$dateDay/$dateMonth/$dateYear");
      }
      
      
      }
  void getPostId() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      var _postId;
      _postId=preferences.getString(post_id);
      _PostID=_postId;
      var _user_Id_Post;
      _user_Id_Post=preferences.getString(user_id_post);
      _UserIdPost=_user_Id_Post;
    });
  }
  Future _loadCommentsOfOnePost()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _PostID=preferences.getString(post_id);
    var url = Uri.parse(viewCommentsURL+"?post_id=$_PostID");
    var res = await http.get(url);
    var responseBody = jsonDecode(res.body);
    setState(() {
      CommentsContent=responseBody;
    });
    return CommentsContent;
  }
  updateTotalComments(String postID) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      String _postId= postID;
      var url=Uri.parse(updateTotaleCommentsURL);
      var response = await http.post(url,body: {
        "post_id":_postId,
      });
      print("Status Code: ${response.statusCode} \n Body: ${response.body}");
      if(response.statusCode==200){
        setState(() {
          print("Comments updated");
        });
        
      }
    
      
      }
  _loadPost()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _PostID=preferences.getString(post_id);
    var url = Uri.parse(veiwOnePostUrl);
    var response = await http.post(url,body: {
        "post_id":_PostID,
      });
    var responseBody = jsonDecode(response.body);
    setState(() {
      PostContent=responseBody;
    });
    if(PostContent[0]['feeling'].toString().isNotEmpty){
        _feeling="is feeling";
      }else{
        _feeling="";
      }
  }
  _loadTotalLikes()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _PostID=preferences.getString(post_id);
    var url = Uri.parse(totalLikesURL);
    var response = await http.post(url,body: {
        "post_id":_PostID,
      });
    var responseBody = jsonDecode(response.body);
    setState(() {
      TotalLikes=responseBody;
    });
  }
  _loadTotalComments()async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      _PostID=preferences.getString(post_id);
      var url = Uri.parse(totalCommentsURL);
      var response = await http.post(url,body: {
          "post_id":_PostID,
        });
      var responseBody = jsonDecode(response.body);
      setState(() {
        TotalComments=responseBody;
      });
    }
  _testLikes()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _PostID=preferences.getString(post_id);
    var _UserID=preferences.getString(id);
    var url = Uri.parse(likeTestURL);
    var response = await http.post(url,body: {
        "user_id":_UserID,
        "post_id":_PostID,
      });
    var responseBody = jsonDecode(response.body);
    setState(() {
      bool res = responseBody.toLowerCase() == 'true';
      _likeVisable=res;
    });
    return _likeVisable;
  }
  addLike() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      _PostID=preferences.getString(post_id);
      var _userId=preferences.getString(id);
      var url=Uri.parse(createLikesUrl);
      var response = await http.post(url,body: {
        "post_id":_PostID,
        "user_id":_userId,
      });
      print("Status Code: ${response.statusCode} \n Body: ${response.body}");
      if(response.statusCode==200){
        setState(() {
          _likeVisable=true;
          String dateDay = DateTime.now().day.toString();
          String dateMonth = DateTime.now().month.toString();
          String dateYear = DateTime.now().year.toString();
          //print("$dateDay/$dateMonth/$dateYear");
          addNewLikedNotificatin(_PostID, "Liked Your Post", "favorite", "$dateDay/$dateMonth/$dateYear");
        });
        
      }
    
      
      }
  deleteLike() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      _PostID=preferences.getString(post_id);
      var _userId=preferences.getString(id);
      var url=Uri.parse(deleteLikeURL);
      var response = await http.post(url,body: {
        "post_id":_PostID,
        "user_id":_userId,
      });
      print("Status Code: ${response.statusCode} \n Body: ${response.body}");
      if(response.statusCode==200){
        setState(() {
          _likeVisable=false;
        });
        
      }
    
      
      }
  getUserImage()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    commentImage=preferences.getString(image)!;
  }
  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAA9t2Jk4o:APA91bHWvY9bdK4gv0lMz1wsahIhOBmlyZ1-3PHlEBKvMSsqZ_Zb9dx38AYFZ9YH9mUiofTy5Puq2QTAw-36jDchC6L-V4L7uGBDKkeCAnFepGcbA1_D0_vfFLTR_h3L-PnAyuTBV7_d',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }
  addNewLikedNotificatin(String _postId,String _body,String _Icon,String _Date) async{
      SharedPreferences preferences = await SharedPreferences.getInstance();

      _UserId=preferences.getString(id);
      if(_UserId==_UserIdPost){
        return;
      }else{
        var url=Uri.parse(createNotificationUrl);
      var response = await http.post(url,body: {
        "post_id":_postId,
        "user_id_sender":_UserId,
        "user_id_reciever":_UserIdPost,
        "body":_body,
        "icon":_Icon,
        "date":_Date,
      });
      print("Status Code: ${response.statusCode} \n Body: ${response.body}");
      if(response.statusCode==200){
        print("${response.body}");
        var _firstName=preferences.getString(firstName);
        var _lastName=preferences.getString(lastName);
        updateCountNotification();
        sendPushMessage(PostContent[0]['Token'], "Liked Your Post", "$_firstName $_lastName");
        
      }
  
      }
      
}
updateCountNotification() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(updateCountNotificationUrl);
      
      var response = await http.post(url,body: {
        "user_id":_UserIdPost
      });
      if(response.statusCode==200){
        print(response.body);
      }
      
      
      
      
      }
  
  addNewCommentNotificatin(String _postId,String _body,String _Icon,String _Date) async{
      SharedPreferences preferences = await SharedPreferences.getInstance();

      _UserId=preferences.getString(id);
      if(_UserId==_UserIdPost){
        return;
      }else{
        var url=Uri.parse(createNotificationUrl);
      var response = await http.post(url,body: {
        "post_id":_postId,
        "user_id_sender":_UserId,
        "user_id_reciever":_UserIdPost,
        "body":_body,
        "icon":_Icon,
        "date":_Date,
      });
      print("Status Code: ${response.statusCode} \n Body: ${response.body}");
      if(response.statusCode==200){
        print("${response.body}");
        var _firstName=preferences.getString(firstName);
        var _lastName=preferences.getString(lastName);
        updateCountNotification();
        sendPushMessage(PostContent[0]['Token'], "Commented on Your Post", "$_firstName $_lastName");
      }
  
      }
      
}
}