import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class ThePowerBook extends StatefulWidget {
  const ThePowerBook({ Key? key }) : super(key: key);

  @override
  State<ThePowerBook> createState() => _ThePowerBookState();
}

class _ThePowerBookState extends State<ThePowerBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title:Text('The power Of Now'),
      backgroundColor: AppColor.darkColor,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios)),
    )
      ,
      body: Container(
          child: SfPdfViewer.network(
              '${baseUrl}pdf/The Power of Now_ A Guide to Spiritual Enlightenment ( PDFDrive ).pdf'),
          
        ),
    
    );
  }
}