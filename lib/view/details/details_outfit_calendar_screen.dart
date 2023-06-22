


import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:thietkethoitrang/model/outfit_model.dart';

import '../../model/featured_child_model.dart';

class DetailsOutFitCalendarScreen extends StatefulWidget{
  OutfitModel featuredChildModel;
  DetailsOutFitCalendarScreen(this.featuredChildModel);
  @override
  State<StatefulWidget> createState()  => _DetailsOutFitCalendarScreen();
}
class _DetailsOutFitCalendarScreen extends State<DetailsOutFitCalendarScreen>{
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
        actions: [
          IconButton(onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text("Are you sure you want to delete this outfit?"),
                actions: [
                  IconButton(onPressed: (){
                    deleteOutfit();
                  }, icon: Icon(Icons.check,color: Colors.black,)),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.cancel,color: Colors.black,)),
                ],
              );
            });

          }, icon:  Icon(Icons.delete,color: Colors.black,)),
        ],
      ),
      body:  Column(
        children: [
         Expanded(child:  Image.network(widget.featuredChildModel.outfitImage.toString()),),


        ],
      ),
    ), onWillPop: ()async{

      Navigator.pop(context);
      return true;
    });
  }

  void deleteOutfit() async{
    FirebaseFirestore.instance.collection("Calendar")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection("MyCalendar")
        .doc(widget.featuredChildModel.id.toString())
        .delete().then((value){
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sucess")));
             Navigator.pop(context);
             Navigator.pop(context);

    });

  }

}