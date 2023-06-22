

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thietkethoitrang/model/news_model.dart';
import 'package:thietkethoitrang/view/details/news_details_screen.dart';

class NewsWidgetScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _NewsWidgetScreen();

}
class _NewsWidgetScreen extends State<NewsWidgetScreen>{
  List<NewsModel> listNews =[];
  int current = 0;
  @override
  Widget build(BuildContext context) {

     return Column(
       children: [
         Container(
           width: double.infinity,
           height: 540,
           child: ListView.builder(
               itemCount: listNews.length,
               itemBuilder: (context,index)=> itemDanhMuc(listNews[index])),
         )

       ],
     );
  }
  init(){
    FirebaseFirestore.instance.collection("News")
        .get().then((value) {

          for(final data in value.docs){
             String name  = data.get("name");
             String image  = data.get("image");
             String datecreate  = data.get("datecreate");
             String description  = data.get("description");
             listNews.add(NewsModel(name: name,image: image,datecreate: datecreate,description: description));
          }
          setState(() {

          });


    });
  }



  itemDanhMuc(NewsModel newsModel) {
    return InkWell(
      splashColor: Colors.transparent,
       highlightColor: Colors.transparent,
       child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 5),
          height: 200,
         child:  Stack(
           children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(newsModel.image.toString(),fit: BoxFit.fill,),
              ),
             Container(
                 width: double.infinity,
                 margin: EdgeInsets.only(left: 25,right: 15,top: 130),
                 child: Row(
                   children: [
                     Container(
                       width: 42,
                       height: 42,
                       margin: EdgeInsets.only(right: 15),
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                           color: Colors.black,
                           border: Border.all(color: Colors.red)
                       ),
                       child: Text("84",style: GoogleFonts.oswald(
                           fontSize: 14,
                           color: Colors.white,
                           fontWeight: FontWeight.w700
                       ),),
                     ),
                     Expanded(child: Text(newsModel.name.toString(),style: GoogleFonts.oswald(
                         fontSize: 18,
                         color: Colors.white
                     ),textAlign: TextAlign.start,),)
                   ],
                 )
             )
           ],
         ),
       ),
        onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsDetailScreen(newsModel)));
        },

    );
  }
  @override
  void initState() {
    super.initState();
    init();
  }


}