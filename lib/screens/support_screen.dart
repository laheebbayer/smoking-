import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:nocotine/constants/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'dart:math' as math;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
class SupportScreen extends StatefulWidget {
  const SupportScreen({ Key? key }) : super(key: key);

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  TextEditingController _FeedbackTextController = new TextEditingController();
    var StarRate;
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.asset('assets/videos/help.mp4'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColor.darkColor,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.help),
          SizedBox(width: 8,),
          Text("Support"),
          
        ],
      ),),
      body: SingleChildScrollView(
        child:Container(
          margin: EdgeInsets.only(bottom: 20),
          child:  SafeArea(
          child: Column(
            children: [
              TermsandPolicies(),
              HelpVedio(),
              ContactUs(),
              FeedbackButton(),
              
            ],
          ),

        ),
        )
      ),
      
    );
  }
  Widget TermsandPolicies(){
    return ExpansionWidget(
    initiallyExpanded: false,
    titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
      return InkWell(
          onTap: () => toogleFunction(animated: true),
          child: Container(
            child: Card(
              child: ListTile(
              leading: Icon(Icons.policy,color: AppColor.primaryColor,),
              title: Center(
                child: Row(
                  children: [
                    Text("Terms & Policies"),
                  ],
                )
                
              ),
            ),)
          ));
    },
    content: Container(
      padding: EdgeInsets.only(left: 15,right: 15),
      child: Column(
      children: [
        AcceptableUsePolicy(),
        SizedBox(height: 15,),
        DataPolicy()
        
      ],
    ),
    )
    );
  
  
  }
  
  Widget AcceptableUsePolicy(){
    return ExpansionWidget(
    initiallyExpanded: false,
    titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
      return InkWell(
          onTap: () => toogleFunction(animated: true),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text('Acceptable Use Policy',style: TextStyle(fontSize: 16),)),
                Transform.rotate(
                  angle: math.pi * animationValue / 2,
                  child: Icon(Icons.chevron_right_outlined,color: AppColor.blackColor,),
                  alignment: Alignment.center,
                )
              ],
            ),
          ));
    },
    content: Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 15,right: 15),
      child: Container(
        
        child: Column(
          children: [
        SizedBox(height: 5,),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Individuals must not:",style: TextStyle(fontWeight: FontWeight.w700),),
          ],
        ),
        SizedBox(height: 5,),
        Text("• Allow anyone else to use their user ID and password.",style: TextStyle(height: 1.3),),

        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("• Use the App for harassment or abuse."),
          ],
        ),
        SizedBox(height: 5,),
        Text("• Access, upload or send data (including images) that consider offensive in any way.",style: TextStyle(height: 1.3),),
          ],
        ),
      ),
    ));
  
  
  }
  Widget DataPolicy(){
    return ExpansionWidget(
    initiallyExpanded: false,
    titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
      return InkWell(
          onTap: () => toogleFunction(animated: true),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text('Privacy Statement',style: TextStyle(fontSize: 16),)),
                Transform.rotate(
                  angle: math.pi * animationValue / 2,
                  child: Icon(Icons.chevron_right_outlined,color: AppColor.blackColor,),
                  alignment: Alignment.center,
                )
              ],
            ),
          ));
    },
    content: Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 15,right: 15),
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 15,),
        Text("We are committed to protecting your privacy. NOcotine's privacy policies explain how we treat your personal data and protect your privacy when you use our Services.\nBy using our Services, you agree that we can use such data in accordance with our privacy policies",style: TextStyle(height: 1.3),),
          ],
        ),
      ),
    ));
  
  
  }
  
  Widget ContactUs(){
    return ExpansionWidget(
    initiallyExpanded: false,
    titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
      return InkWell(
          onTap: () => toogleFunction(animated: true),
          child: Container(
            child: Card(
              child: ListTile(
              leading: Icon(Icons.contact_support,color: AppColor.primaryColor,),
              title: Center(
                child: Row(
                  children: [
                    Text("Contact US"),
                  ],
                )
                
              ),
            ),)
          ));
    },
    content: Container(
      padding: EdgeInsets.only(left: 15,right: 15),
      child: Column(
      children: [
        InkWell(
          child: Card(
          child: ListTile(
            title: Text("Email"),
            subtitle: Text("NOcotine@info.com"),
            leading: Icon(Icons.email,color: AppColor.infoyColor,),
          ),
        ),
        onTap: (){
        
          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: 'NOcotine@info.com',
            
);

      launch(emailLaunchUri.toString());
        },
        ),
        
        SizedBox(height: 2,),
        InkWell(
          child:  Card(
          child: ListTile(
            title: Text("Phone Number"),
            subtitle: Text("+962799999999"),
            leading: Icon(Icons.call,color: AppColor.infoyColor,),
          ),
        ),
        onTap: (){
          launch("tel://+962799999999");
        },
        )
      ],
    ),
    )
    );
  
  
  }
  Widget HelpVedio(){
    return ExpansionWidget(
    initiallyExpanded: false,
    titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
      return InkWell(
          onTap: () => toogleFunction(animated: true),
          child: Container(
            child: Card(
              child: ListTile(
              leading: Icon(Icons.info,color: AppColor.primaryColor,),
              title: Center(
                child: Row(
                  children: [
                    Text("Help"),
                  ],
                )
                
              ),
            ),)
          ));
    },
    content: Container(
      padding: EdgeInsets.only(left: 15,right: 15),
      child: Column(
      children: [
        Container(
      child: FlickVideoPlayer(
        flickManager: flickManager
      ),
    )
      
      ],
    ),
    )
    );
  
  ;
  
  
  }
  Widget FeedbackButton(){
    return Container(
      margin: EdgeInsets.only(top: 350,left: 300),
      child: GestureDetector(
            onTap: () {
              AwesomeDialog(
                      context: context,
                      dialogType: DialogType.NO_HEADER,
                      animType: AnimType.BOTTOMSLIDE,
                      btnOkColor: AppColor.darkColor, 
                      body:Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("Rate Us",style: TextStyle(fontSize: 18),),
                          SizedBox(height: 10,),
                          RatingBar.builder(
                            initialRating: 1,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: AppColor.FeedBackStarsColor,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                StarRate=rating;
                              });
                            },
                          ),
                          SizedBox(height: 15,),
                          
                          ExpansionWidget(
                              initiallyExpanded: false,
                              titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
                                return InkWell(
                                    onTap: () => toogleFunction(animated: true),
                                    child: Container(
                                      child: Text("Give Us Your Feedback",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                    ),
                                    ),);
                                        },
                              content:Container(
                                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                                child: TextFormField(
                                controller: _FeedbackTextController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Type Here..",
                                  filled: true,
                                  fillColor: AppColor.whiteColor,

                                  enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    
                                    borderSide: BorderSide(
                                      color: AppColor.darkColor,width: 3)
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    
                                    borderRadius: BorderRadius.circular(10),
                                    
                                    borderSide: BorderSide(
                                      width: 3,
                                      color: AppColor.darkColor,
                                      
                                      ),
                                      
                                ),
                                
                                ),
                              ), )),
                          SizedBox(height: 15,),
                          ],
                      ),
                      btnOkOnPress: () {
                        setState(() {
                          addNewFeedback();
                        });
                      },
                      showCloseIcon: false
                      
                      )..show();
            },
            child:  CircleAvatar(
              radius: 25,
              backgroundColor: AppColor.darkColor,
              child: Icon(Icons.star,color: AppColor.whiteColor,size: 25,),
)),
    );
  }
  addNewFeedback() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(createFeedbackURL);
      var response = await http.post(url,body: {
        "user_id":_userId,
        "rate":StarRate.toString(),
        "feedback_comment":_FeedbackTextController.text,
      });
      print("Status Code: ${response.statusCode} \n Body: ${response.body}");
      if(response.statusCode==200){
        print("feedback created");
        
      }
      
      
      }

}