import 'package:nocotine/constants/colors.dart';
import 'package:nocotine/constants/screens.dart';
import 'package:nocotine/screens/game_home_page.dart';
import 'package:flutter/material.dart';
class IneedAsmookOptions extends StatefulWidget {
  const IneedAsmookOptions({ Key? key }) : super(key: key);

  @override
  State<IneedAsmookOptions> createState() => _IneedAsmookOptionsState();
}

class _IneedAsmookOptionsState extends State<IneedAsmookOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title:Text('I Need A Smoke'),
      backgroundColor: AppColor.darkColor,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios)),
    ),
    body: Column(
      children: [
        Card(
          child: ListTile(
            leading: Icon(Icons.sports_esports,size: 25,),
            title: Center(child: Text("Play a game ?")),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => GameHomePage()));
            },
        ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.menu_book),
            title: Center(child: Text("Read a book ?")),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.pushNamed(context, Screens.BooksLists.value);
            },
        ),
        )
      ],
    ),
    );
  }
}