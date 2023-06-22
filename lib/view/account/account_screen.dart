
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:thietkethoitrang/main.dart';

class AccountScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _AccountScreen();
}
class _AccountScreen extends State<AccountScreen>{
  @override
  Widget build(BuildContext context) {
     return WillPopScope(child: Scaffold(
        appBar: AppBar(
           backgroundColor: Colors.white,
           leading: IconButton(onPressed: (){
             Navigator.pop(context);
           }, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
           elevation: 0,
           centerTitle: true,
           title: Text("Fashion App",style: GoogleFonts.oswald(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700
          ),),

        ),
        body:  Column(
          children: [
            itemAccount("EMAIL", FirebaseAuth.instance.currentUser!.email.toString(), () { }),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 15,right: 15),
              height: 1,
              color: Colors.black
            ),
            itemAccount("RATE OUR APP", "", () {
              final _dialog = RatingDialog(
                initialRating: 1.0,
                // your app's name?
                title: Text(
                  'FASHION APP',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // encourage your user to leave a high rating?
                message: Text(
                  'Tap a star to set your rating. Add more description here if you want.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
                // your app's logo?
                image: Image.asset("assets/logo.png",width: 120,height: 120,),
                submitButtonText: 'Submit',
                commentHint: 'Set your custom comment hint',
                onCancelled: () => print('cancelled'),
                onSubmitted: (response) {
                  print('rating: ${response.rating}, comment: ${response.comment}');

                  // TODO: add your own logic
                  if (response.rating < 3.0) {
                    // send their comments to your email or anywhere you wish
                    // ask the user to contact you instead of leaving a bad review
                  } else {

                  }
                },
              );

              // show the dialog
              showDialog(
                context: context,
                barrierDismissible: true, // set to false if you want to force a rating
                builder: (context) => _dialog,
              );
            }),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 15,right: 15),
                height: 1,
                color: Colors.black
            ),
            itemAccount("LOG OUT", "", () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyApp()));
            }),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 15,right: 15),
                height: 1,
                color: Colors.black
            )
             
          ],
        ),
     ), onWillPop: ()async{

       Navigator.pop(context);
       return true;
     });
  }
  itemAccount(String title,String info,VoidCallback press){
    return InkWell(
      onTap: press,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child:  Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(left: 15,right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: GoogleFonts.oswald(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500
            ),),
            Container(
              child: Text(info,style: GoogleFonts.oswald(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500
              ),),
            ),
          ],
        ),
      ),
    );
  }

}