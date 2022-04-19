import 'package:nocotine/constants/screens.dart';
import 'package:flutter/material.dart';
import 'package:nocotine/constants/colors.dart';
class RootScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .15),
        child: Column(
          children: [
            
            Image(image: AssetImage("assets/images/logo.png"),width: 300,),
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.only(left: 30,right: 30),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: AppColor.primaryColor,),
                child: Text("Sign up",),
                
                
                onPressed: (){
                  Navigator.pushNamed(context,Screens.signup.value);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30,right: 30),
              width: double.infinity,
              child: OutlinedButton(
                
                child: Text("Already have an account? Log In",style: TextStyle(color: AppColor.darkColor),),
                onPressed: (){
                  
                  Navigator.pushNamed(context,Screens.login.value);
                },
              ),
            )
          ],
        ),
      ),
      ),
      )
    );
  }

}