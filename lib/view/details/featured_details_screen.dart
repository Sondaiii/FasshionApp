


import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thietkethoitrang/config/navigator_config.dart';
import 'package:thietkethoitrang/view/account/login_screen.dart';
import 'package:thietkethoitrang/view/details/details_outfit_screen.dart';

import '../../model/featured_child_model.dart';

class FeatureDetailScreen extends StatefulWidget{
  String id;
  FeatureDetailScreen(this.id);
  @override
  State<StatefulWidget> createState() => _FeatureDetailScreen();
}
class _FeatureDetailScreen extends State<FeatureDetailScreen>{
  
  List<FeaturedChildModel> listFeaturedChildModel = [];
  int pageNumber = 0;
  PageController pageController  = PageController();


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
            Container(
              margin: const EdgeInsets.only(top: 15,left: 10,right: 10),
              child: Text("${pageNumber+1}/${listFeaturedChildModel.length}",style: GoogleFonts.oswald(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w900
              ),),
            )
         ],
       ),
       body:  Column(
         children: [
            Expanded(child: PageView.builder(
                onPageChanged: (page){
                  setState(() {
                      pageNumber = page;
                  });
                },
                itemCount: listFeaturedChildModel.length,
                controller: pageController,
                itemBuilder: (context,index)=> itemPage(listFeaturedChildModel[index])))
         ],
       ),
     ), onWillPop: ()async{
       
       Navigator.pop(context);
       return true;
     });
  }
  itemPage(FeaturedChildModel featuredChildModel){
    return Stack(
      children: [
        InkWell(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(featuredChildModel.image.toString(),fit: BoxFit.fill,),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsOutFitScreen(featuredChildModel)));
          },
        ),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const Spacer(flex: 1,),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: (){
                      setState(() {
                        if(FirebaseAuth.instance.currentUser!=null){
                          HashMap<String,dynamic> hashMap = HashMap();
                          hashMap.putIfAbsent("image", () => featuredChildModel.image.toString());
                          hashMap.putIfAbsent("id", () => featuredChildModel.id.toString());
                          FirebaseFirestore.instance.collection("MyCloset")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("Closet").where("id",isEqualTo: featuredChildModel.id.toString())
                              .get().then((value) {

                            if(value.docs.isEmpty){
                              FirebaseFirestore.instance.collection("MyCloset")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("Closet").add(hashMap);
                              featuredChildModel.mycloset = true;
                            }else{
                              FirebaseFirestore.instance.collection("MyCloset")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("Closet").doc(featuredChildModel.id.toString()).delete();
                              featuredChildModel.mycloset = false;
                            }

                          });

                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                        }
                      });
                       print("closet");
                    }, icon:  Icon(featuredChildModel.mycloset==true ? Icons.bookmark:Icons.bookmark_border,color: Colors.white,)),
                    IconButton(onPressed: (){
                      if(FirebaseAuth.instance.currentUser!=null){
                        Share.share(featuredChildModel.image.toString());
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                      }
                    }, icon: const Icon(Icons.share,color: Colors.white,)),

                  ],
                ),
              )
            ],
          ),
        )

      ],
    );
  }
  
  init()async{
     FirebaseFirestore.instance.collection("FeaturedChild")
         .where("idfeature",isEqualTo: widget.id.toString())
         .get().then((value) {
       for(final data in value.docs){
         
         String image  = data.get("image");
         String outfit  = data.get("outfit");
         String id = data.id.toString();
         listFeaturedChildModel.add(FeaturedChildModel(idfeature: id,image: image,outfit: outfit,id: id));
       }

       for(final i in listFeaturedChildModel){
         FirebaseFirestore.instance.collection("MyCloset")
             .doc(FirebaseAuth.instance.currentUser!.uid)
             .collection("Closet").where("id",isEqualTo: i.id.toString())
             .get().then((value) {

           if(value.docs.isNotEmpty){
              i.mycloset= true;
           }

         });
       }
       setState(() {
         
       });
           
           
     });
  }
  @override
  void initState() {
    super.initState();
    init();
  }

  
}