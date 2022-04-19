import 'dart:convert';
import 'package:nocotine/screens/game_home_page.dart';
import 'package:nocotine/screens/other_profile_screen.dart';
import 'package:nocotine/screens/search_Myprofile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:nocotine/constants/screens.dart';
import 'package:nocotine/screens/account_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:badges/badges.dart';
class HomeScreen extends StatefulWidget {
  
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {
  var CountNotification="";
  int cigaritNumber=0;
  double saveDoller=0;
  String saveDoller2="0";
  double saveHealth=0;
  String saveHealth2="0";
  bool _visbleLike=false;
  var _userId;
  String numberOfLikes="";
  String PostId="";
  List veiwPostList=[];
  List veiwPostList2=[];
  List visableLikes=[];
  List SmokingCounterList=[{
        "user_id": "0",
        "number_of_cigarette": 0,
        "cost_of_cigarette": 0.0,
        "save_health": 0.0
    }];
    var priceOfOneCigaritte;
    String _feeling="";
    bool ShowCountNotification=true;
  TextEditingController _PostController=new TextEditingController();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  @override
  void initState() {
    setState(() {
      _loadSmokingCounter();
      loadPosts();
      chekAppNotifcation();
      getCountNotification();
    });
    super.initState();
    updateToken();
    //if app is open
    FirebaseMessaging.onMessage.listen((event) {
      print("=====================>onMessage<============");
      print(event.notification?.title);
      print(event.notification?.body);
      // AwesomeDialog(
      //   context: context,
      //   dialogType: DialogType.INFO,
      //   animType: AnimType.BOTTOMSLIDE,
      //   title: event.notification?.title,
      //   desc: event.notification?.body,
      //   btnCancelOnPress: () {},
      //   btnOkOnPress: () {},
      // )..show();
      Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      isDismissible:false,
      duration: Duration(seconds: 2),
      title: "${event.notification?.title}",
      message: "${event.notification?.body}",
      backgroundGradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.lightprimaryColor,]),
      boxShadows: [BoxShadow(color: AppColor.primaryColor, offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
      
    )..show(context);
        });
    //if app is in wait
    FirebaseMessaging.onMessageOpenedApp.listen((event) {

      Navigator.pushReplacementNamed(context, Screens.notification.value);
    });
  }
  //هاي فنكشن عشان اعمل بيرمشن للايفون بس عشان اقدر اطلع النتفكيشن
  Future chekAppNotifcation()async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.smoke_free),
          SizedBox(width: 8,),
          Text('NOcotine'),
        ],
      ),
      leading: IconButton(onPressed: (){
          Navigator.pushNamed(context, Screens.searchbar.value);
          
        }, icon: const Icon(Icons.search)),
      actions: [
        FutureBuilder(
              future: getCountNotification(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  if(CountNotification=="0"){
                    ShowCountNotification=false;
                  }else{
                    ShowCountNotification=true;
                  }
                  return  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: IconButton(onPressed: (){
                    resetCountNotification();
                    Navigator.pushNamed(context, Screens.notification.value);
                    
                  }, icon: Badge(
                      showBadge:ShowCountNotification,
                      toAnimate: true,
                      badgeContent: Text('$CountNotification'),
                      animationType: BadgeAnimationType.scale,
                      child: Icon(Icons.notifications),
                    )),
                  );
                }
                else{
                  return  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: IconButton(onPressed: (){
                    resetCountNotification();
                    Navigator.pushNamed(context, Screens.notification.value);
                    
                  }, icon: Badge(
                      showBadge:false,
                      toAnimate: true,
                      badgeContent: Text(''),
                      animationType: BadgeAnimationType.scale,
                      child: Icon(Icons.notifications),
                    )),
                  );;
                }
              },
            ),
      ],
      backgroundColor: AppColor.darkColor,
    ),
      body: SingleChildScrollView(
        child: Container(
        child: Column(
          children: [
            SmokingCounter(),
            buttonsCounter(),
            PostBar(),
            Container(
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            child: FutureBuilder(
              future: loadPosts(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    
                      itemCount: veiwPostList.length,
                      itemBuilder: (context, index) {
                        if(veiwPostList[index]['feeling'].toString().isNotEmpty){
                          
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
                                  InkWell(
                                    child: Row(
                                      children: [
                                      CircleAvatar(
                                        backgroundColor: AppColor.infoyColor,
                                        radius: 15,
                                        backgroundImage:NetworkImage("$ImageUrl${veiwPostList[index]['image']}"),
                                      ),
                                      SizedBox(width: 10,),
                                      Text("${veiwPostList[index]['first_name']} ${veiwPostList[index]['last_name']} ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                    ],),
                                    onTap: ()async{
                                      //TODO
                                      SharedPreferences preferences = await SharedPreferences.getInstance();
                                      if(veiwPostList[index]['id']==preferences.getString(id)){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchProfileScreen()));
                                      }else{
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtherProfileScreen(userId: veiwPostList[index]['id'])));
                                      }
                                    },
                                  ),
                                  Text("$_feeling"),
                            Text(" ${veiwPostList[index]['feeling']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                          
                            ],),
                            Flexible(child: IconButton(onPressed: (){
                              SavePostID(context, veiwPostList[index]['post_id'],veiwPostList[index]['id']);
                            }, icon: Icon(Icons.visibility,color: AppColor.infoyColor,size: 22,)))
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
                                          text: '${veiwPostList[index]['post_text']}'
                                          
                                        ),
                                    ),
                
                          ),
                          ),
                          
                            (veiwPostList[index]['image_post'] != "") ? 
                            StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) => Container(
                              margin: EdgeInsets.only(left: 5,right: 5),
                              height: 200,
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loadingImage.gif',
                                image: '$ImageUrl${veiwPostList[index]['image_post']}',
                              ) ,)
                              )
                            
                            : Text(""),
                          Container(
                            margin: EdgeInsets.only(left: 20,bottom: 10),
                            child: Row(children: [
                              Text("${veiwPostList[index]['Total_likes']} ",style: TextStyle(color: AppColor.infoyColor),),
                              Icon(Icons.favorite,size: 17,color: AppColor.infoyColor,),
                              Text("  ${veiwPostList[index]['total_comments']} ",style: TextStyle(color: AppColor.infoyColor),),
                              Icon(Icons.mode_comment,size: 17,color: AppColor.infoyColor,),
                              ],),
                          ),
                          Divider(thickness: 1.2,),
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
        )
      ),
      
      
      ),
      
      
    );
  }
  Widget SmokingCounter(){
    return Container(
      margin: EdgeInsets.only(top: 20,left: 10,right: 10),
      height: 150,
      decoration:  BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(22.0), 
        ),
            ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Flexible(
                child: Icon(
                          
                          Icons.smoking_rooms_outlined,
                          color: AppColor.whiteColor,
                          size: 35.0,
                        ),
              ),
              SizedBox(height: 10,),
              new Flexible(
                child: new TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "${SmokingCounterList[0]['number_of_cigarette']}",
                        
                        
                        filled: true,
                        fillColor: AppColor.whiteColor,
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          
                          borderSide: BorderSide(
                            color: Colors.transparent,width: 4)
                        ),
                        
                        focusedBorder: UnderlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(10),
                          
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.transparent,
                            
                            ),
                            
                      ),
                      
                      ),
                  
                ),
              ),
              
            ],
          ),),
          Container(
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Flexible(
                child: Icon(
                          
                          Icons.local_atm_sharp,
                          color: AppColor.whiteColor,
                          size: 35.0,
                        ),
              ),
              SizedBox(height: 10,),
              new Flexible(
                child: new TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "${SmokingCounterList[0]['cost_of_cigarette']} \$",
                        
                        
                        filled: true,
                        fillColor: AppColor.whiteColor,
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          
                          borderSide: BorderSide(
                            color: Colors.transparent,width: 4)
                        ),
                        
                        focusedBorder: UnderlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(10),
                          
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.transparent,
                            
                            ),
                            
                      ),
                      
                      ),
                  
                ),
              ),
              ],
            ),
          ),
          Container(
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Flexible(
                child: Icon(
                          
                          Icons.health_and_safety_outlined,
                          color: AppColor.whiteColor,
                          size: 35.0,
                        ),
              ),
              SizedBox(height: 10,),
              new Flexible(
                child: new TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "${SmokingCounterList[0]['save_health']} day",
                        
                        
                        filled: true,
                        fillColor: AppColor.whiteColor,
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          
                          borderSide: BorderSide(
                            color: Colors.transparent,width: 4)
                        ),
                        
                        focusedBorder: UnderlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(10),
                          
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.transparent,
                            
                            ),
                            
                      ),
                      
                      ),
                  
                ),
              ),
              
            ],
          ),),
        ],
      )
    );
  ;
      
  }
  roundDollerNumber(double value){ 
    setState(() {
      saveDoller2=value.toStringAsFixed(2);
    });
    return saveDoller2;
}
  roundHealthNumber(double value){ 
      setState(() {
        saveHealth2=value.toStringAsFixed(2);
      });
      return saveHealth2;
  }
  Widget buttonsCounter(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10,right: 10,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: (){
              
              Navigator.pushNamed(context, Screens.IneedAsmookOptions.value);
            },
            style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(22.0),
                ),
            primary: AppColor.darkColor,),  
            child: Text("I NEED A SMOKE")),
                          )
          ),
          SizedBox(width: 30,),
          Flexible(
          child: SizedBox(
          width: double.infinity, 
          child: ElevatedButton(onPressed: ()async{
            SharedPreferences preferences = await SharedPreferences.getInstance();
              setState(() {
                priceOfOneCigaritte=preferences.getDouble(price_one_cigratte);
                cigaritNumber=int.parse(SmokingCounterList[0]['number_of_cigarette']);
                saveDoller=double.parse(SmokingCounterList[0]['cost_of_cigarette']);
                saveHealth=double.parse(SmokingCounterList[0]['save_health']);
                cigaritNumber++;
                print("-----------------------------------${preferences.getDouble(price_one_cigratte)}");
                saveDoller=saveDoller+priceOfOneCigaritte;
                roundDollerNumber(saveDoller);
                saveHealth=saveHealth-0.10;
                roundHealthNumber(saveHealth);
                updateSmokingCounter(cigaritNumber, saveDoller2, saveHealth2);
                _loadSmokingCounter();
              });
            },
            
            style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(22.0),
                ),
            primary: AppColor.darkColor,), 
            child: Icon(
            Icons.add_circle_sharp,
          ),),
                          )
          ),
        
      ],
    ),
    );
  }
  Widget PostBar(){
      return Container(
        margin: EdgeInsets.only(top: 20,left: 10,right: 10),
        child: TextFormField(
          
          readOnly: true,
          decoration: InputDecoration(
            hintText: "Create Post..",
            
            filled: true,
            fillColor: AppColor.whiteColor,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              
              borderSide: BorderSide(
                color: AppColor.infoyColor,width: 2)
            ),
          
      
      
        
          focusedBorder: OutlineInputBorder(
            
            borderRadius: BorderRadius.circular(10),
            
            borderSide: BorderSide(color: AppColor.infoyColor,width: 2),
              
        ),
        
        ),
      onTap: (){
        Navigator.pushNamed(context,Screens.craetePost.value);
      },
    ));
  
  }
  loadPosts()async{
  var url = Uri.parse(veiwAllPostsUrl);
  var res = await http.get(url); 
  var responseBody = jsonDecode(res.body);
  setState(() {
    veiwPostList=responseBody;
    
  });
  return veiwPostList;
  }
  SavePostID(BuildContext context,String _postid,String _userIdPost) async{
    
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Save response
    
    preferences.setString(post_id, _postid);
    preferences.setString(user_id_post, _userIdPost);
    // push to home screen
    Navigator.pushNamed(context, Screens.comments.value);
    
  }
  updateSmokingCounter( numCigartte, costCigartte, saveHelth) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(updateSmokingCounterURL);
      print(costCigartte);
      var response = await http.post(url,body: {
        
        "number_of_cigarette":numCigartte.toString(),
        "cost_of_cigarette":costCigartte.toString(),
        "save_health":saveHelth.toString(),
        "user_id":_userId,
      });
      print("Status Code: ${response.statusCode}  Body: ${response.body}");
      if(response.statusCode==200){
        
      }
    
      
      }
  _loadSmokingCounter()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var _UserId=preferences.getString(id);
    var url=Uri.parse(viewSmokingCounterURL);
      var response = await http.post(url,body: {
        "user_id":_UserId,
      });
    var responseBody = jsonDecode(response.body);
      SmokingCounterList=responseBody;
  }
  updateToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(updateTokenURL);
      _fcm.getToken().then((token) async{
      var response = await http.post(url,body: {
        "token":token,
        "user_id":_userId
      });
      if(response.statusCode==200){
      print(response.body);
      }
    });
      }
  getCountNotification() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(getCountNotificationUrl);
      var response = await http.post(url,body: {
        "user_id":_userId
      });
      var res=jsonDecode(response.body);
      if(response.statusCode==200){
      //print(res[0]['count_notification']);
      CountNotification=res[0]['count_notification'];

      } 
      return CountNotification.toString();
      }
  resetCountNotification() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(resetCountNotificationUrl);
      var response = await http.post(url,body: {
        "user_id":_userId,
      });
    
      if(response.statusCode==200){
        setState(() {
          print(response.body);

          
        });
        
      }
    
      
      }
  

}

