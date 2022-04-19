import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:nocotine/constants/screens.dart';
import 'package:flutter/material.dart';
class BooksListsScreen extends StatefulWidget {
  const BooksListsScreen({ Key? key }) : super(key: key);

  @override
  State<BooksListsScreen> createState() => _BooksListsScreenState();
}

class _BooksListsScreenState extends State<BooksListsScreen> {
  List Books=[
    {
      "id":1,
      "Name":"Harry Potter",
      "Image":"harry-potter.jfif"
    },
    {
      "id":2,
      "Name":"Twilight",
      "Image":"Twilight.jpg"
    },
    { 
      "id":3,
      "Name":"How to Stop..",
      "Image":"HowToStop.jpg"
    },
    {
      "id":4,
      "Name":"The Power Of Now",
      "Image":"ThePower.jpg"
    },
    {
      "id":5,
      "Name":"Genius Food",
      "Image":"GeniusFood.jpg"
    }
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      //title:Text('Books Lists'),
      backgroundColor: AppColor.darkColor,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios)),
    ),
    body: GridView.builder(
                itemCount: Books.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context,index){
                  return InkWell(
      onTap: (){
        if(Books[index]['id']==1){
          Navigator.pushNamed(context, Screens.HarryPotterBook.value);
        }else if(Books[index]['id']==2){
          Navigator.pushNamed(context, Screens.TwilightBook.value);
        }else if(Books[index]['id']==3){
          Navigator.pushNamed(context, Screens.HowToStopBook.value);
        }else if(Books[index]['id']==4){
          Navigator.pushNamed(context, Screens.ThePowerBook.value);
        }else if(Books[index]['id']==5){
          Navigator.pushNamed(context, Screens.GeniusFoodBook.value);
        }
      },
      child: GridTile(
        child: FadeInImage.assetNetwork(
          placeholder: "assets/images/loadingImage.gif",
          image: "$ImageUrl${Books[index]['Image']}",
          fit: BoxFit.fill,
        ),
        footer: Container(
          width: double.infinity,
          height: 40,
          color: AppColor.blackTransparentColor,
          child: Align(
            alignment: Alignment.center,
            child: Text("${Books[index]['Name']}", style: TextStyle(
              color: Colors.white,
              fontFamily: 'Baloo 2',
              fontSize: 25,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(color: AppColor.blackColor,blurRadius: 20)
              ]
            ),),
          ),
        )

      ),
    );
                }),
    );
  }
}