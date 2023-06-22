

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thietkethoitrang/config/navigator_config.dart';
import 'package:thietkethoitrang/model/feature_model.dart';
import 'package:thietkethoitrang/view/details/featured_details_screen.dart';

import '../account/login_screen.dart';

class FeatureWidgetScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _FeatureWidgetScreen();

}
class _FeatureWidgetScreen extends State<FeatureWidgetScreen>{
  List<String> listDanhMuc = ["ALL","MEN","WOMEN","LIFESTYLE","SEASON"];
  int current = 0;
  List<FeatureModel> listFeatures = [];
  @override
  Widget build(BuildContext context) {

     return FirebaseAuth.instance.currentUser!=null? Column(
       children: [
         Container(
           width: double.infinity,
           height: 50,
           padding: EdgeInsets.only(top: 15),
           decoration: BoxDecoration(
             color: Colors.grey.shade200
           ),

           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               itemDanhMuc("ALL", 0),
               itemDanhMuc("MEN", 1),
               itemDanhMuc("WOMEN", 2),
               itemDanhMuc("LIFESTYLE", 3),
               itemDanhMuc("SEASON", 4),

             ],
           )),
         listFeatures.isNotEmpty ? Container(
           width: double.infinity,
           height: 490,
           margin: const EdgeInsets.only(left: 9,right: 9),
           child: GridView.builder(gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2,
               childAspectRatio: 0.7,
               crossAxisSpacing: 10,
               mainAxisSpacing: 9
           ),
               itemCount: listFeatures.length,
               itemBuilder: (context,index)=> itemFeatured(listFeatures[index])),
         ) : Container(
           width: double.infinity,
           margin: const EdgeInsets.only(top: 90),
           alignment: Alignment.center,
           child:  const CircularProgressIndicator(color: Colors.red,)
         )


       ],
     ) :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         const SizedBox(height: 150,),

         Container(
             width: double.infinity,
             height: 50,
             alignment: Alignment.center,
             child: const Icon(Icons.bookmark_border)),
         Container(
           alignment: Alignment.center,
           margin: const EdgeInsets.only(left: 25, right: 25),
           child: Text(
             "Save your favorite outfits on your calendar. ",
             style:
             GoogleFonts.bodoniModa(fontSize: 17, color: Colors.black),
             textAlign: TextAlign.justify,
           ),
         ),
         Container(
           width: double.infinity,
           height: 60,
           margin: EdgeInsets.only(top: 30),
           alignment: Alignment.center,
           child: InkWell(
             child: Container(
               width: 320,
               height: 50,
               alignment: Alignment.center,
               decoration:
               BoxDecoration(border: Border.all(color: Colors.black)),
               child: Text(
                 "Sign in to continue",
                 style: GoogleFonts.bodoniModa(
                     fontSize: 16,
                     color: Colors.black,
                     fontWeight: FontWeight.w400),
               ),
             ),
             onTap: () {
               if (FirebaseAuth.instance.currentUser==null
                   ) {
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => LoginScreen()));
               } else {}
             },
           ),
         )
       ],
     );
  }

  itemDanhMuc(String listDanhMuc,int currentIndex) {
    return InkWell(
      splashColor: Colors.transparent,
       highlightColor: Colors.transparent,
       child: Container(
         margin: const EdgeInsets.only(left: 15,right: 15),
         height: 50,
         child: Text(listDanhMuc,style: GoogleFonts.bodoniModa(
           fontSize: 12,
           color:  current== currentIndex ? Colors.red : Colors.grey.shade700,
           fontWeight: FontWeight.w700
         ),)
       ),
        onTap: (){
            switch(currentIndex){
              case 0 : initFeatured("ALL");break;
              case 1 : initFeatured("Men");break;
              case 2 : initFeatured("Women");break;
              case 3 : initFeatured("LifeStyle");break;
              case 4 : initFeatured("Season");break;
            }
          setState(() {
             current = currentIndex;
          });
        },

    );
  }
  initFeatured(String key){
    listFeatures.clear();
     if(key=="ALL"){
       FirebaseFirestore.instance.collection("Featured").get().then((value){
         for(final data in value.docs){
           String name  = data.get("name");
           String image  = data.get("image");
           String datecreate  = data.get("datecreate");
           String category  = data.get("category");
           listFeatures.add(FeatureModel(name: name,assetsIcon: image,dateCreate: datecreate,id: data.id.toString(),category: category ));
         }
         setState(() {

         });

       });
     }else{
       FirebaseFirestore.instance.collection("Featured").where("category",isEqualTo: key).get().then((value){
         for(final data in value.docs){
           String name  = data.get("name");
           String image  = data.get("image");
           String datecreate  = data.get("datecreate");
           String category  = data.get("category");
           listFeatures.add(FeatureModel(name: name,assetsIcon: image,dateCreate: datecreate,id: data.id.toString(),category: category ));
         }
         setState(() {

         });

       });
     }


  }

  itemFeatured(FeatureModel listFeatur) {
   return InkWell(
     child: SizedBox(
       width: 180,
       height: 180,
       child:  Stack(
         children: [
           SizedBox(
             width: double.infinity,
             height: double.infinity,
             child:  Image.network(listFeatur.assetsIcon.toString(),fit: BoxFit.fill,),
           ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Spacer(flex: 1,),
               Container(
                 margin: EdgeInsets.only(left: 5),
                 child: Text(listFeatur.category.toString(),style: GoogleFonts.bodoniModa(
                   fontSize: 16,
                   color: Colors.white,
                   fontWeight: FontWeight.w700
                 ),),
               ),
               Container(
                 width: 120,
                 margin: const EdgeInsets.only(left: 5),

                 child: Text(listFeatur.name.toString(),maxLines: 1,style: GoogleFonts.bodoniModa(
                   fontSize: 15,
                   color: Colors.white,
                   fontWeight: FontWeight.w900
                 ),),
               ),
               Container(
                 width: 120,
                 margin: const EdgeInsets.only(left: 5),

                 child: Text(listFeatur.dateCreate.toString(),maxLines: 1,style: GoogleFonts.bodoniModa(
                   fontSize: 10,
                   color: Colors.white,
                   fontWeight: FontWeight.w400
                 ),),
               ),
             ],
           )
           
         ],
       ),
     ),
     onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=> FeatureDetailScreen(listFeatur.id.toString())));
     },
   );
  }

  @override
  void initState() {
    init();
    super.initState();

  }
  init()async{
     final category = await NavigatorConfig.getCategory();
     setState(() {
       current = category;
       switch(current){
         case 0 : initFeatured("ALL");break;
         case 1 : initFeatured("Men");break;
         case 2 : initFeatured("Women");break;
         case 3 : initFeatured("LifeStyle");break;
         case 4 : initFeatured("Season");break;
       }
     });
  }


}