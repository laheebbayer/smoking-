import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class HowToStopBook extends StatefulWidget {
  const HowToStopBook({ Key? key }) : super(key: key);

  @override
  State<HowToStopBook> createState() => _HowToStopBookState();
}

class _HowToStopBookState extends State<HowToStopBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title:Text('How To Stop Worrying And..'),
      backgroundColor: AppColor.darkColor,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios)),
    )
      ,
      body: Container(
          child: SfPdfViewer.network(
              '${baseUrl}pdf/Dale_Carnegie_How_To_Stop_Worrying_And_Start_Living.pdf',
              
              ),
          
        ),
    
    );
  }
}