


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thietkethoitrang/view/account/login_screen.dart';

import '../../model/feature_model.dart';
import '../details/featured_details_screen.dart';

class SearchScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _SearchScreen();
}
class _SearchScreen extends State<SearchScreen>{
  List<FeatureModel> listFeatures = [];
  List<FeatureModel> listFeaturesAll = [];
  TextEditingController txtSearch = TextEditingController();
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
          Container(
            width: double.infinity,
            height: 50,

            alignment: Alignment.center,
            child: Container(
              width: 320,
              height: 50,
              padding: const EdgeInsets.only(left: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: Colors.black,

                )
              ),
              child: TextFormField(
                controller: txtSearch,
                onChanged: (value){
                  listFeatures.clear();
                   setState(() {
                     if(value.isNotEmpty){
                       for(final i in listFeaturesAll){
                         if(i.name.toString().toLowerCase().contains(value.toString())
                          || i.category.toString().toLowerCase().contains(value.toLowerCase())){
                           listFeatures.add(i);
                         }
                       }
                     }else{
                       listFeatures.addAll(listFeaturesAll);
                     }
                   });
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search,color: Colors.black,),
                  hintText: "Enter name of fashion"
                ),
              ),
            )
          ),
          listFeatures.isNotEmpty? Expanded(child: ListView.builder(
              itemCount: listFeatures.length,
              itemBuilder: (context,index)=>itemSearch(listFeatures[index]))) : Column(
            children: [
               Container(
                 width: double.infinity,
                 height: double.infinity,
                 alignment: Alignment.center,
                 child:  const CircularProgressIndicator(),
               )
            ],
          )
        ],
      ),
    ), onWillPop: ()async{

      return true;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  init()async{
    FirebaseFirestore.instance.collection("Featured").get().then((value){
      for(final data in value.docs){
        String name  = data.get("name");
        String image  = data.get("image");
        String datecreate  = data.get("datecreate");
        String category  = data.get("category");
        listFeatures.add(FeatureModel(name: name,assetsIcon: image,dateCreate: datecreate,id: data.id.toString(),category: category ));
      }
      listFeaturesAll.addAll(listFeatures);
      setState(() {

      });

    });
  }
  itemSearch(FeatureModel listFeatur) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 150,
        margin: const EdgeInsets.only(top:5,bottom: 5,left: 15,right: 15),

        child: Row(
          children: [
            SizedBox(
                width: 120,
                height: 120,
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(listFeatur.assetsIcon.toString(),fit: BoxFit.fill,),
                )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  margin: const EdgeInsets.only(left: 5,top: 10),
                  child: Text(listFeatur.category.toString(),style: GoogleFonts.bodoniModa(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),),
                ),
                Container(
                  width: 120,
                  margin: const EdgeInsets.only(left: 5),

                  child: Text(listFeatur.name.toString(),maxLines: 1,style: GoogleFonts.bodoniModa(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w900
                  ),),
                ),
                Container(
                  width: 120,
                  margin: const EdgeInsets.only(left: 5),

                  child: Text(listFeatur.dateCreate.toString(),maxLines: 1,style: GoogleFonts.bodoniModa(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),),
                ),
              ],
            )
          ],
        ),
      ),
      onTap: (){
        if(FirebaseAuth.instance.currentUser!=null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> FeatureDetailScreen(listFeatur.id.toString())));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
        }

      },
    );
  }

}