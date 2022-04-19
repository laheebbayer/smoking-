import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class TwilightBook extends StatefulWidget {
  const TwilightBook({ Key? key }) : super(key: key);

  @override
  State<TwilightBook> createState() => _TwilightBookState();
}

class _TwilightBookState extends State<TwilightBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title:Text('Twilight'),
      backgroundColor: AppColor.darkColor,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios)),
    )
      ,
      body: Container(
          child: SfPdfViewer.network(
              '${baseUrl}pdf/Twilight_ The Complete Illustrated Movie Companion (Twilight Saga) ( PDFDrive ).pdf'),
          
        ),
    
    );
  }
}