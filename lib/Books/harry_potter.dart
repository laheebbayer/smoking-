import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class HarryPotterBook extends StatefulWidget {
  const HarryPotterBook({ Key? key }) : super(key: key);

  @override
  State<HarryPotterBook> createState() => _HarryPotterBookState();
}

class _HarryPotterBookState extends State<HarryPotterBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title:Text('Harry Potter'),
      backgroundColor: AppColor.darkColor,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios)),
    )
      ,
      body: Container(
          child: SfPdfViewer.network(
              '${baseUrl}pdf/harryPotter.pdf'),
          
        ),
    
    );
  }
}