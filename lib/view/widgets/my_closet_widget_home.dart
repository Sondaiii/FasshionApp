

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thietkethoitrang/model/my_closet_model.dart';
import 'package:thietkethoitrang/view/account/login_screen.dart';
import 'package:thietkethoitrang/view/details/detail_mycloset_screen.dart';

class MyCloseWidgetHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyCloseWidgetHome();
}
class _MyCloseWidgetHome extends State<MyCloseWidgetHome>{
  String email = "";
  List<MyClosetModel> listMyCloset = [];
  @override
  Widget build(BuildContext context) {
     return  FirebaseAuth.instance.currentUser==null ?  Column(
       children: [
         SizedBox(height: 150,),
         Container(
           width: double.infinity,
           height: 50,
           alignment: Alignment.center,
           child: const Icon(Icons.bookmark_border)
         ),
         Container(
           alignment: Alignment.center,
           margin: const EdgeInsets.only(left: 25,right: 25),
           child: Text("Save your favorite outfits and create mood boards to organize your inspirations. ",style: GoogleFonts.bodoniModa(
             fontSize: 17,
             color: Colors.black
           ),textAlign: TextAlign.justify,),
         ),
         InkWell(
           child: Container(
             width: double.infinity,
             height: 60,
             margin: EdgeInsets.only(top: 30),
             alignment: Alignment.center,
             child: Container(
               width: 320,
               height: 50,
               alignment: Alignment.center,
               decoration: BoxDecoration(
                 border: Border.all(color: Colors.black)
               ),
               child: Text("Sign in to continue",style: GoogleFonts.bodoniModa(
                 fontSize: 16,
                 color: Colors.black,
                 fontWeight: FontWeight.w400
               ),),
             ),

           ),
           onTap: (){
              if(email.isEmpty){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
              }else{

              }
              print("OK");

           },
         )

       ],
     ) : Column(
       children: [

         listMyCloset.isNotEmpty ? Container(
           width: double.infinity,
           height: 490,
           margin: const EdgeInsets.only(left: 9,right: 9),
           child: GridView.builder(gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2,
               childAspectRatio: 0.7,
               crossAxisSpacing: 10,
               mainAxisSpacing: 9
           ),
               itemCount: listMyCloset.length,
               itemBuilder: (context,index)=> itemFeatured(listMyCloset[index])),
         ) : Container(
             width: double.infinity,
             margin: const EdgeInsets.only(top: 90),
             alignment: Alignment.center,
             child:  Text("No data",style: GoogleFonts.adamina(
               fontSize: 18,
               color: Colors.grey,

             ),)
         )


       ],
     );
  }
  itemFeatured(MyClosetModel listFeatur) {
    return InkWell(
      child: SizedBox(
        width: 180,
        height: 180,
        child:  Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child:  Image.network(listFeatur.image.toString(),fit: BoxFit.fill,),
            ),
            Container(
              width: double.infinity,

              alignment: Alignment.bottomRight,
              child: IconButton(onPressed: (){
                FirebaseFirestore.instance.collection("MyCloset")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("Closet").doc(listFeatur.id.toString()).delete().then((value){

                  setState(() {
                    listMyCloset.remove(listFeatur);
                  });
                });

              }, icon: Icon(Icons.delete,color: Colors.white,)),
            )


          ],
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailMyClosetScreen(listFeatur)));

       
      },
    );
  }
  @override
  void initState() {
    super.initState();
    init();
  }
  init(){
    if(FirebaseAuth.instance.currentUser!=null){
      FirebaseFirestore.instance.collection("MyCloset")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Closet").get().then((value) {
        for(final i in value.docs){
          String id = i.id.toString();
          String image = i.get("image");
          String idOutfit = i.get("id");
          listMyCloset.add(MyClosetModel(id: id,image: image,idOutfit: idOutfit));
        }
        setState(() {

        });

      });
    }

  }


}