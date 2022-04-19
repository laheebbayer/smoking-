import 'package:nocotine/constants/colors.dart';
import 'package:nocotine/constants/screens.dart';
import 'package:nocotine/screens/competition_screen.dart';
import 'package:nocotine/screens/home_screen.dart';
import 'package:nocotine/screens/profile_screen.dart';
import 'package:nocotine/screens/support_screen.dart';
import 'package:flutter/material.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectIndex=0;
  List<Widget> pages=[
    HomeScreen(),
    CompetitionScreen(),
    ProfileScreen(),
    SupportScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        selectedItemColor: AppColor.primaryColor,
        currentIndex:_selectIndex,
        onTap: (index){
          setState((){
            _selectIndex=index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: "Home"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_sharp),
            label: "Competition"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"),
            BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: "Support"),
            

        ],
      ),
      body: Container(
        child: pages[_selectIndex],
      ),
    
    );
  }
}