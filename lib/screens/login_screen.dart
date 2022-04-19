import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:nocotine/constants/screens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  // const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _EmailControllerLogin = new TextEditingController();
  TextEditingController _passwordControllerLogin = new TextEditingController();
  double NumOfPackets=0.0;
  double PriceOfPackets=0.0;
  bool texterrorEmail = false;
  bool texterrorPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SingleChildScrollView(
        child: Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.only(left: 40,right: 40),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .15),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image(image: AssetImage("assets/images/login2.gif"),width: 200,),
            SizedBox(height: 40,),
            _EmailLogin(),
            SizedBox(height: 20,),
            _passwordLogin(),
            SizedBox(height: 20,),
            _loginButtun(),
            _DontAccount()
            
            ],
          ),
          ),
        ),
      ),
    
    
      )
    );
  }
  Widget _loginButtun(){
  return  ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: AppColor.primaryColor,),
                child: Text("Login"),
                
                onPressed: (){
                  if(_EmailControllerLogin.text.isEmpty){
                    setState(() {
                      texterrorEmail=true;
                    });
                  }
                  else {
                    setState(() {
                      texterrorEmail=false;
                    });
                  }
                  if(_passwordControllerLogin.text.isEmpty){
                    setState(() {
                      texterrorPassword=true;
                    });
                  }
                  else {
                    setState(() {
                      texterrorPassword=false;
                    });
                  }
                  if(texterrorEmail==false&&texterrorPassword==false){
                    setState(() {
                      loginUser(context, _EmailControllerLogin.text, _passwordControllerLogin.text);
                    });
                  }
                  
                },
              );
}
  Widget _EmailLogin(){
    return TextFormField(
      controller: _EmailControllerLogin,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email,color: AppColor.infoyColor,),
        labelText: "Eamil",
        errorText: texterrorEmail?"Required":null,
        labelStyle: TextStyle(color: AppColor.infoyColor),
        
        filled: true,
        fillColor: AppColor.whiteColor,

        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          
          borderSide: BorderSide(
            color: AppColor.darkColor,width: 4.4)
        ),
        focusedBorder: UnderlineInputBorder(
          
          borderRadius: BorderRadius.circular(10),
          
          borderSide: BorderSide(
            width: 4.4,
            color: AppColor.primaryColor,
            
            ),
            
      ),
      
      ),
    );
  }
  Widget _passwordLogin(){
    return TextFormField(
      controller: _passwordControllerLogin,
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock,color: AppColor.infoyColor,),
        labelText: "Password",
        errorText: texterrorPassword?"Required":null,
        labelStyle: TextStyle(color: AppColor.infoyColor),
        
        filled: true,
        fillColor: AppColor.whiteColor,

        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          
          borderSide: BorderSide(
            color: AppColor.darkColor,width: 4)
        ),
        focusedBorder: UnderlineInputBorder(
          
          borderRadius: BorderRadius.circular(10),
          
          borderSide: BorderSide(
            width: 4,
            color: AppColor.primaryColor,
            
            ),
            
      ),
      
      ),
    );
  }
  Widget _DontAccount(){
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",style: TextStyle(color: AppColor.infoyColor,fontWeight:FontWeight.w700,fontSize: 15 ),),
                TextButton(onPressed: (){
                  Navigator.of(context).pushNamed(Screens.signup.value);
                }, child: Text("Create Account",style: TextStyle(color: AppColor.darkColor,fontSize: 15),))
              ],
            );
}
    
  void loginUser(BuildContext context, String _email, String _password) async{
    var url= Uri.parse(loginUrl);
    Map<String,String> loginBody = {"Email":_email, "Password":_password};
    var response = await http.post(url,body: jsonEncode(loginBody));
    if(response.statusCode == 401){
      AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Email or Password Invalid',
            btnCancelOnPress: () {},
            )..show();
      return;
    }
    var res = jsonDecode(response.body);
    
    if(response.statusCode == 200){
      loginSuccessful(context, res);
    }
  }
  void loginSuccessful(BuildContext context,res) async{
    
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Save response
    preferences.setString("PROFILE", res.toString());
    
    preferences.setString(id, res["id"]);
    preferences.setString(firstName, res['first_name']);
    preferences.setString(lastName, res['last_name']);
    preferences.setString(email, res['email']);
    preferences.setString(gender, res['gender']);
    preferences.setString(age, res['Age']);
    preferences.setString(bio, res['bio']);
    preferences.setString(image, res['image']);
    preferences.setString(visable_sheet, res['visable_sheet']);
    preferences.setDouble(num_packets, double.parse(res['number_of_packets']));
    preferences.setDouble(price_packets, double.parse(res['price_of_packets']));
    preferences.setDouble(price_one_cigratte, double.parse(res['price_of_packets'])/20);
    // push to home screen
    getVisableSheet();
    
  }
  void showCustomBottomSheet(BuildContext context,Widget child){
  showModalBottomSheet(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(40) ),
    ),
    context: context,
    builder: (context){
    return SingleChildScrollView(
      child: Container(
      height: 600,
      child: child,
    ),
    );
  });
}
  Widget contentSheet(){
    return Container(
      child: Column(
        children: [
          SizedBox(height: 35,),
          Text("one last thing..",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,fontFamily: 'Baloo 2',color: AppColor.primaryColor),),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: Text("How many packs of cigarettes do you \nsmoke per day?",style: TextStyle(fontSize: 20),),
          ),
          Container(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: SpinBox(
            min: 0,
            max: 5,
            value: 0,
            decimals: 1,
            step: 0.5,
            iconColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey;
                      }
                      if (states.contains(MaterialState.error)) {
                        return Colors.red;
                      }
                      if (states.contains(MaterialState.focused)) {
                        return AppColor.primaryColor;

                      }
                      return AppColor.primaryColor;
                    }),
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.whiteColor,
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColor.darkColor,width: 4)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 4,
                    color: AppColor.darkColor,
                    ),
              ),
        ),
            onChanged: (value) {
              setState(() {
                NumOfPackets=value;
              });
            },
                          ),
                ),
          SizedBox(height: 30,),
          Align(
            alignment: Alignment.center,
            child: Text("How much does a pack of cigarettes \ncost?",style: TextStyle(fontSize: 20),),
          ),
          Container(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: SpinBox(
            min: 0,
            max: 5,
            value: 0,
            decimals: 1,
            step: 0.1,
            iconColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey;
                      }
                      if (states.contains(MaterialState.error)) {
                        return Colors.red;
                      }
                      if (states.contains(MaterialState.focused)) {
                        return AppColor.primaryColor;

                      }
                      return AppColor.primaryColor;
                    }),
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.whiteColor,
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColor.darkColor,width: 4)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 4,
                    color: AppColor.darkColor,
                    ),
              ),
        ),
            onChanged: (value) {
              PriceOfPackets=value;
            },
                          ),
                ),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.bottomRight,
            child:  ElevatedButton(onPressed: (){
            updateVisbleSheet();
          }, style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
                  primary: AppColor.primaryColor,
                  ),
                  child: Icon(
                    Icons.navigate_next,
                  ),),
          )
            
        ],
      ),
    );
  }
  void getVisableSheet() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var _VisableSheet;
    setState(() {
      
      
      _VisableSheet=preferences.getString(visable_sheet);
      if(_VisableSheet=="1"){
        showCustomBottomSheet(context, contentSheet());
        
        
      }
      else if(_VisableSheet=="2"){
      
        Navigator.pushReplacementNamed(context, Screens.mainScreen.value);
      }
    });
    
  }
  updateVisbleSheet() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(updateVisbleSheetURL);
      var response = await http.post(url,body: {
        "user_id":_userId,
        "num_packets":NumOfPackets.toString(),
        "price_packets":PriceOfPackets.toString(),
      });
      
      if(response.statusCode==200){
        setState(() {
          
          // Save response
          
          preferences.setDouble(num_packets, NumOfPackets);
          preferences.setDouble(price_packets, PriceOfPackets);
          preferences.setDouble(price_one_cigratte, preferences.getDouble(price_packets)!/20);
          CreateSmokingCounter();
          
        });
        
      }
    
      
      }
  CreateSmokingCounter() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(createSmokingCounterURL);
      var response = await http.post(url,body: {
        "user_id":_userId,
      });
      print("Status Code: ${response.statusCode} \n Body: ${response.body}");
      if(response.statusCode==200){
        setState(() {

          Navigator.pushReplacementNamed(context, Screens.mainScreen.value);
          
        });
        
      }
    
      
      }
}