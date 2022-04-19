import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/screens.dart';
import 'package:flutter/material.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'dart:typed_data';
import "package:image_picker/image_picker.dart";
import "dart:io";
import "package:path/path.dart" as path;
import "package:async/async.dart";
import 'dart:io';
class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({ Key? key }) : super(key: key);

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPassword = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyDateOfBirth = GlobalKey<FormState>();
  String SaveBio="Bio";
  String FirstName="";
  String LastName="";
  var NewdateOfBirth;
  late double _NumOfPackets;
  late double _PriceOfPackets;
  String? imageFile = null;
  String? imageName;
  String? imagePathDecode=null;
  var ImagePath;
  String dec="";
  int Age=0;
  String CheckPassword="";
  String DefultDateOfBirth="yyyy-mm-dd";
  
  bool? _expandedImage;
  final ImagePicker _picker=ImagePicker();
  TextEditingController _NewdateOfBirthController=new TextEditingController();
  TextEditingController _NewFirstNameController=new TextEditingController();
  TextEditingController _NewLastNameController=new TextEditingController();
  TextEditingController _NewPasswordController=new TextEditingController();
  TextEditingController _NewConfirmPasswordController=new TextEditingController();
  TextEditingController _BioController=new TextEditingController();
  @override
  void initState() {
    setState(() {
      getLastData();
    });
    checkPermession();
    super.initState();
  }
  Future checkPermession()async{
    var cameraPermession = await Permission.camera.status;
    print("Camera Status: $cameraPermession");
    if(cameraPermession.isDenied){
      cameraPermession =await Permission.camera.request();
    }
    var storagePermission = await Permission.storage.status;
    print("Storge Status: $storagePermission");
    if(storagePermission.isDenied){
      storagePermission =await Permission.storage.request();
    }
    var photoPermission = await Permission.photos.status;
    print("Photo Status: $photoPermission");
    if(photoPermission.isDenied){
      photoPermission =await Permission.photos.request();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.manage_accounts),
          SizedBox(width: 8,),
          Text("Account Settings"),
          
        ],
        
      ),
      ),
      
      body: SingleChildScrollView(
        child: SafeArea(
        child: Column(
          children: [
            ChangeName(),
            ChangeProfilePicture(),
            ChangeBio(),
            ChangePassword(),
            ChangeBirthDate(),
            ChangeCigaretteInfo(),
            ChangePriceCigarette(),
            ResetSmokingCounter(),
          
          ],
        ),
      ),
      )
      
    );
  }
  Widget ChangeName(){
    return Card(
              child: ListTile(
              title: Center(
                child: Text("Change Name"),
                
              ),
              onTap: (){
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.NO_HEADER,
                  animType: AnimType.BOTTOMSLIDE,
                  btnCancelColor: AppColor.primaryColor,
                  btnOkColor: AppColor.darkColor,
                  btnOkText: "Save",
                  body: Form(
                    key: _formKeyName,
                    child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _NewFirstNameController,
                          validator: (value) {
                          var pattern = r'^[A-Z][a-z]{2,}$';
                              RegExp regex = new RegExp(pattern);
                              
                              if (value!.isEmpty)
                                return 'Required';
                                
                              else if(!regex.hasMatch(value))
                                return 'Enter Valid First Name';
                              else
                                return null;
                            
                          
                        },
                        
                          decoration: InputDecoration(
                            labelText: "New First Name",
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
                                width: 3,
                                color: AppColor.primaryColor,
                              ),
                    ),
                          ),
                        ),
                        TextFormField(
                          controller: _NewLastNameController,
                          validator: (value) {
                          var pattern = r'^[A-Z][a-z]{2,}$';
                              RegExp regex = new RegExp(pattern);
                              
                              if (value!.isEmpty)
                                return 'Required';
                                
                              else if(!regex.hasMatch(value))
                                return 'Enter Valid Last Name';
                              else
                                return null;
                            
                          
                        },
                          decoration: InputDecoration(
                            labelText: "New Last Name",
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
                                width: 3,
                                color: AppColor.primaryColor,
                              ),
                    ),
                          ),
                        ),
                        SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: 120,
                          child: Center(child: Text("Cancel",style: TextStyle(color: AppColor.whiteColor,fontWeight: FontWeight.bold),)),
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                ),
                          
                          )),
                        onTap: (){
                            setState(() {
                          getLastData();
                          Navigator.of(context).pop();
                        });
                        }
                      ),
                        InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: 120,
                          child: Center(child: Text("Save",style: TextStyle(color: AppColor.whiteColor,fontWeight: FontWeight.bold),)),
                          decoration: BoxDecoration(
                              color: AppColor.darkColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                ),
                          
                          )),
                        onTap: (){
                            if (_formKeyName.currentState!.validate()) {
                              updateName();
                              Navigator.of(context).pop();
                        }}
                      ),
                    
                        ],
                      )
                      ],),
                  
                  ),
                  
                  
                  ),
                  )..show();
              },
            ),
            );
  }
  Widget ChangeProfilePicture(){
    return  ExpansionWidget(
    initiallyExpanded: false,
    onSaveState: (value) => _expandedImage = value,
    onRestoreState: () => _expandedImage,
    titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
      return InkWell(
        
          onTap: () {
            toogleFunction(animated: true); 
          } ,
          child: Container(
            child: Card(
              child: ListTile(
              title: Center(
                child: Text("Change Profile Picture"),
                
              ),
            ),)
          ));
    },
    content: Column(
        children: [
          SizedBox(height: 10,),
          (imageFile != null) ? CircleAvatar(
                    backgroundImage: FileImage(File(imageFile!)),
                    backgroundColor: AppColor.whiteColor,
                    radius: 60,
                  ): Text("No Image"),
          Container(
            margin: EdgeInsets.only(top: 15,bottom: 15),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
              getImageFromGallery();
            },
            style: ElevatedButton.styleFrom(
                primary: AppColor.darkColor,),
            child: Text("Get Image")),
            SizedBox(width: 30,),
            ElevatedButton(onPressed: (){
              //uploadImage();
              addImage(ImagePath);
            },
            style: ElevatedButton.styleFrom(
                primary: AppColor.primaryColor,),
            child: Text("Save")),
            ],
          )
,
          )
            
        ],
      ));
  }
  
  Widget ChangePassword(){
    return Card(
              child: ListTile(
              title: Center(
                child: Text("Change Password"),
                
              ),
              onTap: (){
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.NO_HEADER,
                  animType: AnimType.BOTTOMSLIDE,
                  btnCancelColor: AppColor.primaryColor,
                  btnOkColor: AppColor.darkColor,
                  showCloseIcon: false,
                  btnOkText: "Save",
                  body: Form(
                    key: _formKeyPassword,
                    child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                    
                      children: <Widget>[
                        TextFormField(
                          obscureText: true,
                          controller: _NewPasswordController,
                          validator: (value) {
                          var pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                              RegExp regex = new RegExp(pattern);
                              
                              if (value!.isEmpty)
                                return 'Required';
                                
                              else if(!regex.hasMatch(value))
                                return 'Password must contain at least 8 characters, one digit, \none upper case and one lower case letter';
                              else
                                  setState(() {
                                    CheckPassword=value;
                                  });
                                return null;
                            
                          
                        },
                          decoration: InputDecoration(
                            labelText: "New Password",
                            
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
                                width: 3,
                                color: AppColor.primaryColor,
                              ),
                    ),
                          ),
                        ),
                      
                        TextFormField(
                          controller: _NewConfirmPasswordController,
                          validator: (value) {
                              
                              if (value!.isEmpty)
                                return 'Required';
                                
                              else if(value!=CheckPassword)
                                return 'Password Not Match';
                              else
                                return null;
                            
                          
                        },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
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
                                width: 3,
                                color: AppColor.primaryColor,
                              ),
                    ),
                          ),
                        ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: 120,
                          child: Center(child: Text("Cancel",style: TextStyle(color: AppColor.whiteColor,fontWeight: FontWeight.bold),)),
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                ),
                          
                          )),
                        onTap: (){
                          _NewPasswordController.text="";
                          _NewConfirmPasswordController.text="";
                          Navigator.of(context).pop();
                        }
                      ),
                        InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: 120,
                          child: Center(child: Text("Save",style: TextStyle(color: AppColor.whiteColor,fontWeight: FontWeight.bold),)),
                          decoration: BoxDecoration(
                              color: AppColor.darkColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                ),
                          
                          )),
                        onTap: (){
                            if (_formKeyPassword.currentState!.validate()) {
                              updatePassword();
                              Navigator.of(context).pop();
                        }}
                      ),
                    
                        ],
                      )
                      ],
                    ),
                  
                  
                  ),
                  
                  
                  
                  ),
                  )..show();
              
              },
            ),
            );
  }
  Widget ChangeBirthDate(){
    return Card(
              child: Form(
                child:  ListTile(
              title: Center(
                child: Text("Change Birthdate"),
                
              ),
              onTap: (){
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.NO_HEADER,
                  animType: AnimType.BOTTOMSLIDE,
                  btnCancelColor: AppColor.primaryColor,
                  btnOkColor: AppColor.darkColor,
                  btnOkText: "Save",
                  body: Form(
                    key: _formKeyDateOfBirth,
                    child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          readOnly: true,
                          controller: _NewdateOfBirthController,
                          validator: (value) {
                              
                              if (DefultDateOfBirth=="yyyy-mm-dd")
                                return 'Required';
                                
                              else
                                return null;
                            
                          
                        },
                          decoration: InputDecoration(
                              hintText: "$DefultDateOfBirth",
                              prefixIcon: Icon(Icons.event,color: AppColor.infoyColor,),
                              
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
                                  width: 3,
                                  color: AppColor.primaryColor,
                                  
                                  ),
                                  
                            ),
                            
                            ),
                        onTap: () {
                            DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              minTime: DateTime(1990, 12, ),
                              maxTime: DateTime(2022, 12, 31), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print('confirm $date');
                            setState(() {
                              
                              
                              NewdateOfBirth="${date.year}-${date.month}-${date.day}";
                              DefultDateOfBirth="${date.year}-${date.month}-${date.day}";
                              Age=DateTime.now().year-date.year;
                              NewdateOfBirth=NewdateOfBirth.toString();
                              _NewdateOfBirthController.text=NewdateOfBirth;

                            });
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                        ),
                        SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: 120,
                          child: Center(child: Text("Cancel",style: TextStyle(color: AppColor.whiteColor,fontWeight: FontWeight.bold),)),
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                ),
                          
                          )),
                        onTap: (){
                            setState(() {
                          getLastData();
                          Navigator.of(context).pop();
                        });
                        }
                      ),
                        InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: 120,
                          child: Center(child: Text("Save",style: TextStyle(color: AppColor.whiteColor,fontWeight: FontWeight.bold),)),
                          decoration: BoxDecoration(
                              color: AppColor.darkColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                ),
                          
                          )),
                        onTap: (){
                            if (_formKeyDateOfBirth.currentState!.validate()) {
                              setState(() {
                                updateBirthDate();
                                Navigator.of(context).pop();
                              });
                        }}
                      ),
                    
                        ],
                      )
                      ],
                    ),
                    

                  ),
                  
                  ),
                  )..show();
              },
            ),
            
              ),
              );
  }
  Widget ChangeCigaretteInfo(){
    return  ExpansionWidget(
    initiallyExpanded: false,
    titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
      return InkWell(
          onTap: () => toogleFunction(animated: true),
          child: Container(
            child: Card(
              child: ListTile(
              title: Center(
                child: Text("Change Number Of Packs Of Cigarettes"),
                
              ),
            ),)
          ));
    },
    content: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 20),
            child: Text("How many packs of cigarettes do you \nsmoke per day?",style: TextStyle(fontSize: 17),),
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
                _NumOfPackets=value;
              });
            },
                          ),
                ),
          
          
          IconButton(onPressed: (){
            updateNumberOfPackets();
          }
          , icon:Icon( Icons.save,color: AppColor.primaryColor,))
        ],
      ));
  }
  Widget ChangePriceCigarette(){
    return  ExpansionWidget(
    initiallyExpanded: false,
    titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
      return InkWell(
          onTap: () => toogleFunction(animated: true),
          child: Container(
            child: Card(
              child: ListTile(
              title: Center(
                child: Text("Change Price Of Packs Of Cigarettes"),
                
              ),
            ),)
          ));
    },
    content: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 20),
            child: Text("How much does a pack of cigarettes \ncost?",style: TextStyle(fontSize: 17),),
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
              _PriceOfPackets=value;
            },
                          ),
                ),
          IconButton(onPressed: (){
            updatePriceOfPackets();
          }
          , icon:Icon( Icons.save,color: AppColor.primaryColor,))
        ],
      ));
  }
  Widget ChangeBio(){
    return  ExpansionWidget(
    initiallyExpanded: false,
    titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
      return InkWell(
          onTap: () => toogleFunction(animated: true),
          child: Container(
            child: Card(
              child: ListTile(
              title: Center(
                child: Text("Cahange Bio"),
                
              ),
            ),)
          ));
    },
    content: pobubBio());
  }
  Widget ResetSmokingCounter(){
    return Card(
              child: ListTile(
              title: Center(
                child: Text("Reset Smoking Counter"),
                
              ),
              onTap: (){
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.NO_HEADER,
                  animType: AnimType.BOTTOMSLIDE,
                  btnCancelColor: AppColor.primaryColor,
                  btnOkColor: AppColor.darkColor,
                  title: 'Smoking Counter',
                  desc: 'Are You Sure You Want to Reset Smoking Counter?',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    resetSmokingCounter();
                  },
                  )..show();
              },
            ),
            );
  }
  getLastData() async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
      var _fname;
      var _lname;
      var _lastBirthDate;
      var _numPackets;
      var _pricePackets;
      setState(() {
        _fname=preferences.getString(firstName);
        FirstName=_fname;
        _lname=preferences.getString(lastName);
        LastName=_lname;
        _NewFirstNameController..text = FirstName;
        _NewLastNameController..text = LastName;
        _numPackets=preferences.getDouble(num_packets);
        
        _NumOfPackets=_numPackets;
        _pricePackets=preferences.getDouble(price_packets);
        _PriceOfPackets=_pricePackets;
        
      });
  }
  updateName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(updateNameURL);
      if(_NewFirstNameController.text.isEmpty||_NewLastNameController.text.isEmpty){
        AwesomeDialog(
                      context: context,
                      dialogType: DialogType.WARNING,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Empty Feild', 
                      btnOkOnPress: () {},
                      showCloseIcon: false
                      
                      )..show();
        return;
      }
      var response = await http.post(url,body: {
        "first_name":_NewFirstNameController.text,
        "last_name":_NewLastNameController.text,
        "user_id":_userId
      });
      if(response.statusCode==200){
        SharedPreferences preferences = await SharedPreferences.getInstance();
      // Save response
      preferences.setString(firstName, _NewFirstNameController.text);
      preferences.setString(lastName, _NewLastNameController.text);
      AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Name Changed', 
                      btnOkOnPress: () {},
                      showCloseIcon: false
                      
                      )..show();
      }
      
      
      
      
      }
  updatePassword() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(updatePasswordURL);
      if(_NewPasswordController.text.isEmpty||_NewConfirmPasswordController.text.isEmpty){
        AwesomeDialog(
                      context: context,
                      dialogType: DialogType.WARNING,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Empty Feild', 
                      btnOkOnPress: () {},
                      showCloseIcon: false
                      
                      )..show();
        return;
      }
      var response = await http.post(url,body: {
        "password":_NewPasswordController.text,
        "conf_password":_NewConfirmPasswordController.text,
        "user_id":_userId
      });
      print(response.statusCode);
      if(response.statusCode==200){
      AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Password Changed', 
                      btnOkOnPress: () {},
                      showCloseIcon: false
                      
                      )..show();
      }
      
      
      
      
      }
  updateBirthDate() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(age, Age.toString());
      var _userId=preferences.getString(id);
      var url=Uri.parse(updateBirthDateURL);
      if(_NewdateOfBirthController.text.isEmpty){
        AwesomeDialog(
                      context: context,
                      dialogType: DialogType.WARNING,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Empty Feild', 
                      btnOkOnPress: () {},
                      showCloseIcon: false
                      
                      )..show();
        return;
      }
      var response = await http.post(url,body: {
        "Age":Age.toString(),
        "user_id":_userId
      });
      if(response.statusCode==200){
        SharedPreferences preferences = await SharedPreferences.getInstance();

      AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Birth Date Changed', 
                      btnOkOnPress: () {},
                      showCloseIcon: false
                      
                      )..show();
      }
      
      
      
      
      }
  updateNumberOfPackets() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(updateVisbleSheetURL);
      
      var response = await http.post(url,body: {
        "user_id":_userId,
        "num_packets":_NumOfPackets.toString(),
        "price_packets":_PriceOfPackets.toString(),
      });
    
      if(response.statusCode==200){
        setState(() {
          
          // Save response
          
          preferences.setDouble(num_packets, _NumOfPackets);
          preferences.setDouble(price_packets, _PriceOfPackets);

          AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Number Of Packs Changed', 
                      btnOkOnPress: () {},
                      showCloseIcon: false
                      
                      )..show();
          
        });
        
      }
    
      
      }
  updatePriceOfPackets() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(updateVisbleSheetURL);
      var response = await http.post(url,body: {
        "user_id":_userId,
        "num_packets":_NumOfPackets.toString(),
        "price_packets":_PriceOfPackets.toString(),
      });
    
      if(response.statusCode==200){
        setState(() {
          
          // Save response
          
          preferences.setDouble(num_packets, _NumOfPackets);
          preferences.setDouble(price_packets, _PriceOfPackets);
          preferences.setDouble(price_one_cigratte, _PriceOfPackets/20);

          AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Price Of Packs Changed', 
                      btnOkOnPress: () {},
                      showCloseIcon: false
                      
                      )..show();
          
        });
        
      }
    
      
      }
  resetSmokingCounter() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(resetSmokingCounterURL);
      var response = await http.post(url,body: {
        "user_id":_userId,
      });
    
      if(response.statusCode==200){
        setState(() {
          

          AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Reset Successful', 
                      btnOkOnPress: () {},
                      showCloseIcon: false
                      
                      )..show();
          
        });
        
      }
    
      
      }
  void getImageFromCamera()async{
    var image =await _picker.pickImage(source: ImageSource.camera);
    if(image != null){
      setState(() {
        imageFile = image.path;
      });
      //ConvertBase64();
    }
  }
  void getImageFromGallery()async{
    var image =await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      setState(() {
        imageFile = image.path;
        imageName=image.name;
        ImagePath=File(image.path);
        print(imageFile);
        
        print(imageName);
      });
      print("------------------------");
    }

  }
  updateProfilePicture() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(upadteProfilePictureURL);
      if(imageName==null||imageName==""){
        AwesomeDialog(
                      context: context,
                      dialogType: DialogType.WARNING,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Empty Feild', 
                      btnOkOnPress: () {},
                      showCloseIcon: false
                      
                      )..show();
        return;
      }
      var response = await http.post(url,body: {
        "image":imageName,
        "user_id":_userId
      });
      if(response.statusCode==200){
        SharedPreferences preferences = await SharedPreferences.getInstance();
      // Save response
      preferences.setString(image, imageName!);
      AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Profile Picture Changed', 
                      btnOkOnPress: () {
                        setState(() {
                          _expandedImage=false;
                          imageFile=null;
                        });
                      },
                      showCloseIcon: false
                      
                      )..show();
      }
      
      
      
      
      }
  Widget pobubBio(){
    return Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: ListTile(
                trailing: Icon(
                  Icons.edit,
                  color: AppColor.primaryColor,
                ),
                title: Center(child: new Text("$SaveBio", )),
                onTap: (){
                  Alert(
                    context: context,
                    content: Column(
                      children: <Widget>[
                        TextField(
                          controller: _BioController,
                          decoration: InputDecoration(
                            
                            labelText: 'Enter Your Bio..',
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
                                width: 3,
                                color: AppColor.primaryColor,
                              ),
                    ),
                          ),
                          maxLength: 40,
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        color: AppColor.primaryColor,
                        onPressed: () {
                          setState(() {
                            SaveBio=_BioController.text;
                            
                            updateBio();
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                        ]).show();
                            },
                          ), 
            );
  }
  updateBio() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
      var _userId=preferences.getString(id);
      var url=Uri.parse(updateBioURL);
      var response = await http.post(url,body: {
        "bio":SaveBio,
        "user_id":_userId
      });
      
      if(response.statusCode==200){
        print("--------------${response.statusCode}");
        SharedPreferences preferences = await SharedPreferences.getInstance();
      // Save response
      preferences.setString(bio, _BioController.text);
      AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Bio Changed', 
                      btnOkOnPress: () {},
                      showCloseIcon: false
                      
                      )..show();
      }
      
      
      
      
      }


Future addImage(File imageFile) async{
// ignore: deprecated_member_use
var stream= new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
var length= await imageFile.length();
var uri = Uri.parse("http://192.168.1.15/NOcotine_api/test_upload.php");

var request = new http.MultipartRequest("POST", uri);

var multipartFile = new http.MultipartFile("image", stream, length, filename: path.basename(imageFile.path));

request.files.add(multipartFile);
var respond = await request.send();
print("Status Code: ${respond.statusCode} \n Body: ${respond}");
if(respond.statusCode==200){
  print("Image Uploaded");
  updateProfilePicture();
}else{
  print("Upload Failed");
}
  }


}
