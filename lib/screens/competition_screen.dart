import 'dart:ui';
import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dio/dio.dart';
import 'package:nocotine/screens/test.dart';
class CompetitionScreen extends StatefulWidget {
  const CompetitionScreen({ Key? key }) : super(key: key);

  @override
  _CompetitionScreenState createState() => _CompetitionScreenState();
}

class _CompetitionScreenState extends State<CompetitionScreen> {
  final CountDownController controller = new CountDownController();
  final _userEditTextController = TextEditingController();
  final _multiKey = GlobalKey<DropdownSearchState<String>>();
  bool visableCompetition=false;
  var increaseCegaritte=0;
  var increaseCegaritteCompetitor=0;
  var TimerTime=86400;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.military_tech),
          SizedBox(width: 8,),
          Text('Competition'),
        ],
      ),
      backgroundColor: AppColor.darkColor,
    ),
    body:SingleChildScrollView(
      child:  ListView(
        shrinkWrap: true,
      children: [
        
        if (visableCompetition) Container( height: 180,padding: EdgeInsets.only(top: 30),child: setcompetitionContent(competitionContent()),)
        else Container(height: 180,padding: EdgeInsets.only(top: 50),child: Column(children: [Center(child: Text("Tips💡",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),
              SizedBox(height:10,),
              Container(
                padding: EdgeInsets.only(left:25,right: 15),
                child: Center(
                  child: Text("• When the timer starts, make sure you adjust the cigarette counter each time you smoke a cigarette.\n• The competitor who has the fewest cigarettes wins.",style: TextStyle(height: 1.2,color: AppColor.infoyColor),),
                )),],)),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
            
          title: Center(child: Text("Competitor Username")),
          leading:  Column(
                      
                      children: [
                        
                Icon(Icons.smoking_rooms,size: 35,color: AppColor.blackColor,),
                Text('$increaseCegaritteCompetitor',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      ],
                    ),
          trailing:  GestureDetector(
                  child:  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColor.infoyColor,
                    child: Icon(Icons.person,color: AppColor.whiteColor,),
                          ),
                      )
                    
        ),
              SizedBox(height: 20,),
              ListTile(
          title: Center(child: Text("test")),
          leading:  Column(
                      
                      children: [
                        
                Icon(Icons.smoking_rooms,size: 35,color: AppColor.blackColor,),
                Text('$increaseCegaritte',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      ],
                    ),
          trailing:  GestureDetector(
                  onTap: () {
                    if(visableCompetition==false){

                    }
                    else{
                      setState(() {
                      
                      increaseCegaritte++;
                    });
                    }
                    

                  },
                  child:  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColor.lightyColor,
                    child: Icon(Icons.add,color: AppColor.whiteColor,),
                          ),
                      )
                    
        ),
              
              SizedBox(height: 200,),
              Align(
                alignment: Alignment.bottomCenter,
                  child:createNewCompetition(),
                )
            // createNewCompetition()
            ],
          )
            
        ),
      
      
      ],
    ),
    
    
    )
    
    );
  }
  Widget createNewCompetition(){
    return NiceButtons(
  stretch: false,
  startColor: AppColor.primaryColor,
  endColor: AppColor.primaryColor,
  borderColor: AppColor.darkPrimaryColor,
  width:190 ,
  onTap: (finish) {
    AwesomeDialog(
                  context: context,
                  dialogType: DialogType.NO_HEADER,
                  animType: AnimType.BOTTOMSLIDE,
                  btnCancelColor: AppColor.primaryColor,
                  btnOkColor: AppColor.darkColor,
                  showCloseIcon: false,
                  btnOkText: "Create",
                  onDissmissCallback: (type) {
                        _userEditTextController.text="";
                      },
                  body: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                    
                      children: <Widget>[
                      DropdownSearch<UserModel>(
                        
                searchFieldProps: TextFieldProps(
                  cursorColor: AppColor.infoyColor,
                  controller: _userEditTextController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10,top: 15),
                    hintText: "Search",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear,color: AppColor.infoyColor,),
                      onPressed: () {
                        _userEditTextController.clear();
                      },
                    ),
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
                ),
                mode: Mode.DIALOG,
                maxHeight:410,
                showAsSuffixIcons: false,
                showSearchBox: true,
                dropdownSearchDecoration: InputDecoration(
                  hintText: "Competitor's Username",
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
              
                onFind: (String? filter) => getData(filter),
                onChanged: (data) {
                  print(data!.id.toString());
                  _userEditTextController.text="";
                },
                popupItemBuilder: _customPopupItemBuilderExample,
                scrollbarProps: ScrollbarProps(
                  isAlwaysShown: true,
                  thickness: 7,
                ),
              ),
                      SizedBox(height: 15,),
                      Text("Duration per Days",style: TextStyle(color: AppColor.infoyColor,fontSize: 16),),
                      
                        Container(
                          child: SpinBox(
                          min: 1,
                          max: 14,
                          value: 1,
                          step: 01,
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
                            if(value==1)
                              TimerTime=86400;
                            else if(value==2)
                              TimerTime=2*86400;
                            else if(value==3)
                              TimerTime=3*86400;
                            else if(value==4)
                              TimerTime=4*86400;
                            else if(value==5)
                              TimerTime=5*86400;
                            else if(value==6)
                              TimerTime=6*86400;
                            else if(value==7)
                              TimerTime=7*86400;
                            else if(value==8)
                              TimerTime=8*86400;
                            else if(value==9)
                              TimerTime=9*86400;
                            else if(value==10)
                              TimerTime=10*86400;
                            else if(value==11)
                              TimerTime=11*86400;
                            else if(value==12)
                              TimerTime=12*86400;
                            else if(value==13)
                              TimerTime=13*86400;
                            else if(value==14)
                              TimerTime=14*86400;
                            print(TimerTime);
                          }
                                        ),
                              ),
          
          
                      SizedBox(height: 15,)
                      ],
                    ),
                  
                  
                  ),
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    AwesomeDialog(
                      padding: EdgeInsets.all(10),
                      context: context,
                      dialogType: DialogType.NO_HEADER,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Invitation Sent!', 
                      btnOkOnPress: () {
                        setState(() {
                          visableCompetition=true;
                        });

                      },
                      showCloseIcon: false,
                      btnOkColor: AppColor.primaryColor
                      
                      )..show();
                  },
                  )..show();
              
  },
  child: Text(
    'Create New Competition',
    style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w700),
  ),
);
  }
  Widget competitionContent(){
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          
          NeonCircularTimer(
                width: 150,
                    duration: TimerTime,
                    isReverse: false,
                    controller : controller,
                    isTimerTextShown: true,
                    neumorphicEffect: true,
                    innerFillGradient: LinearGradient(colors: [
                      AppColor.darkColor,
                      AppColor.darkColor,
                    ]),
                    neonGradient: LinearGradient(colors: [
                      AppColor.darkColor,
                      AppColor.darkColor,
                    ]),
                  ),
        
                    
                    
          
        
        ],
      )
    );
  }
  Widget setcompetitionContent(Widget x){
    return Container(
      child:x
    );
  }
  Future<List<UserModel>> getData(filter) async {
    var response = await Dio().get(
      "$allUsersURl",
      queryParameters: {"filter": filter},
    );

    final data = response.data;
    if (data != null) {
      return UserModel.fromJsonList(data);
    }

    return [];
  }
  Widget _customPopupItemBuilderExample(
      BuildContext context, UserModel? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
            
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.name ?? ''),
        leading: Icon(Icons.search),
        onTap: (){
          print(id);
        }
            ),
     // ),
      
    );
  }
  
}