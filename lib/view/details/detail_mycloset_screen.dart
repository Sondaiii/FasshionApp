


import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:thietkethoitrang/model/my_closet_model.dart';
import 'package:thietkethoitrang/model/outfit_child_model.dart';

import '../../model/featured_child_model.dart';

class DetailMyClosetScreen extends StatefulWidget{
  MyClosetModel featuredChildModel;
  DetailMyClosetScreen(this.featuredChildModel);
  @override
  State<StatefulWidget> createState()  => _DetailMyClosetScreen();
}
class _DetailMyClosetScreen extends State<DetailMyClosetScreen>{
  List<OutfitChildModel> listOutFitChild = [];
  String images ="";
  @override
  Widget build(BuildContext context) {

    return WillPopScope(child: Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
        title: const Text("FASHION APP",style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: 'Abri'
        ),),

      ),
      body:  Column(
        children: [
          images.length>1? Container(
            width: double.infinity,
            height: 250,
            child:Image.network(images)
          ):Container(),
          Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.grey.shade300
            ),
            child: Text("Used items",style: GoogleFonts.bodoniModa(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.w900
            ),),
          ),
         listOutFitChild.isNotEmpty? Container(
            width: double.infinity,
            height: 250,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Expanded(child: Container(
                   width: 110,
                   height: 150,
                   child:  Column(
                     children: [
                       Image.network(listOutFitChild[0].images.toString().split(";")[0].toString(),width: 120,height: 120,),
                       Padding(padding: EdgeInsets.only(top: 5),child: Text(listOutFitChild[0].description.toString().split(";")[0],style: GoogleFonts.robotoMono(
                         fontSize: 15,
                         color: Colors.black
                       ),),)
                     ],
                   ),
                 ),),
                 Expanded(child: Container(
                   width: 110,
                   height: 150,
                   child:  Column(
                     children: [
                       Image.network(listOutFitChild[0].images.toString().split(";")[1].toString(),width: 120,height: 120,),
                       Padding(padding: EdgeInsets.only(top: 5),child: Text(listOutFitChild[0].description.toString().split(";")[1],style: GoogleFonts.robotoMono(
                         fontSize: 15,
                         color: Colors.black
                       ),),)
                     ],
                   ),
                 ),),
                listOutFitChild[0].images.toString().split(";").length>2?       Expanded(child: Container(
                   width: 110,
                   height: 150,
                   child:  Column(
                     children: [
                       Image.network(listOutFitChild[0].images.toString().split(";")[2].toString(),width: 120,height: 120,),
                       Padding(padding: EdgeInsets.only(top: 5),child: Text(listOutFitChild[0].description.toString().split(";")[2],style: GoogleFonts.robotoMono(
                           fontSize: 15,
                           color: Colors.black
                       ),),)
                     ],
                   ),
                 ),):Container()

              ],
            )
          ) : Container()
          



        ],
      ),
    ), onWillPop: ()async{

      Navigator.pop(context);
      return true;
    });
  }

  void showAddCalenDar() async{
    DateTime selectDate = DateTime.now();

 final datePicked = await   showDatePicker(context: context,
        builder: (context,child){

          return Theme(data: Theme.of(context).copyWith(

            colorScheme:  ColorScheme.light(
               primary:  Colors.black,
               onSurface:  Colors.black,

            ),
             textButtonTheme: TextButtonThemeData(
               style: TextButton.styleFrom(
                foregroundColor:  Colors.black,
               )
             )
          ), child: child!);

        },

        initialDate: DateTime.now(), firstDate: selectDate, lastDate: DateTime(2030));


  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUsedItem();
  }

  void initUsedItem() {
    FirebaseFirestore.instance.collection("OutfitChild")
        .where("id",isEqualTo: widget.featuredChildModel.idOutfit.toString())
        .get().then((value){
         if(value.docs.isNotEmpty){
           for(final i in value.docs){
              String description = i.get("description");
              String image = i.get("image");
              listOutFitChild.add(OutfitChildModel(description: description,images: image));
           }
           setState(() {

           });
         }
    });
    FirebaseFirestore.instance.collection("FeaturedChild")
        .doc(widget.featuredChildModel.idOutfit.toString())
        .get().then((value){
          if(value.exists){
            images = value.get("outfit");
          }
          setState(() {

          });






    });
  }
  
}