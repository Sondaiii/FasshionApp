

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thietkethoitrang/model/news_model.dart';

class NewsDetailScreen extends StatefulWidget{
  NewsModel newsModel;
  NewsDetailScreen(this.newsModel);
  @override
  State<StatefulWidget> createState()  => _NewsDetailScreen();
}
class _NewsDetailScreen extends State<NewsDetailScreen>{
  @override
  Widget build(BuildContext context) {
     return WillPopScope(child: Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.white,
         elevation: 0,
         centerTitle: true,
         title: const Text("FASHION APP",style: TextStyle(
           fontSize: 20,
           color: Colors.black,
           fontFamily: 'Abri'
         ),),
         iconTheme: const IconThemeData(
           color: Colors.black
         ),
       ),
       body:  SingleChildScrollView(
         child:  Column(
           children: [
             Container(
               width: double.infinity,
               alignment: Alignment.center,
               child: Text(widget.newsModel.name.toString(),

                 textAlign: TextAlign.center,
                 style: const TextStyle(
                 fontFamily: 'Bodoni',
                 fontSize: 20
               ),),
             ),
             Container(
               width: double.infinity,
               alignment: Alignment.center,
               child: Text(widget.newsModel.datecreate.toString(),

                 textAlign: TextAlign.center,
                 style: const TextStyle(
                 fontFamily: 'Bodoni',
                 fontSize: 12
               ),),
             ),
             SizedBox(
               width: double.infinity,
               height: 250,
               child: Image.network(widget.newsModel.image.toString(),),
             ),
             Container(
               width: double.infinity,
               padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
               child: Text(widget.newsModel.description.toString(),
               style: TextStyle(
                 fontSize: 14,
                 color: Colors.grey.shade700,
                 fontFamily: 'Bodoni'
               ),textAlign: TextAlign.justify,),
             )

           ],
         ),
       ),
     ), onWillPop: ()async{
       return true;
     });
  }

}