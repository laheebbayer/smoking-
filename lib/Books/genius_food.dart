import 'package:nocotine/constants/cofig_api.dart';
import 'package:nocotine/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class GeniusFoodBook extends StatefulWidget {
  const GeniusFoodBook({ Key? key }) : super(key: key);

  @override
  State<GeniusFoodBook> createState() => _GeniusFoodBookState();
}

class _GeniusFoodBookState extends State<GeniusFoodBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title:Text('Genius Food'),
      backgroundColor: AppColor.darkColor,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios)),
    )
      ,
      body: Container(
          child: SfPdfViewer.network(
              '${baseUrl}pdf/Genius Foods_ Become Smarter, Happier, and More Productive While Protecting Your Brain for Life ( PDFDrive ).pdf'),
          
        ),
    
    );
  }
}