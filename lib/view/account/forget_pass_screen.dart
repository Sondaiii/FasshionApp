


import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/navigator_config.dart';

class ForgetPassScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _ForgetPassScreen();
}
class _ForgetPassScreen extends State<ForgetPassScreen>{
  TextEditingController txtEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back,color: Colors.black,)),

        centerTitle: true,
        title: Text(
          "Fashion App",
          style: GoogleFonts.oswald(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
       
      ),

      body:  Column(
        children: [
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 25, right: 25, top: 15),
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      "Email",
                      style: GoogleFonts.oswald(
                          fontSize: 14, color: Colors.black),
                    ),
                  ),
                  TextFormField(
                      controller: txtEmail,
                      decoration: InputDecoration(
                        hintText: "Type your Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey.shade700,
                        ),
                      )),
                ],
              )),
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.only(top: 15),
            alignment: Alignment.center,
            child: Container(
              width: 320,
              height: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.pink]),
                  borderRadius: BorderRadius.circular(30)),
              child: ElevatedButton(
                onPressed: () {
                  String email = txtEmail.text.toString().trim();

                  if (email.isNotEmpty) {
                    if (EmailValidator.validate(email)) {
                      try{
                        FirebaseAuth.instance.sendPasswordResetEmail(email: email)
                            .then((value) {
                          NavigatorConfig.showToast("Please go to gmail to change password your account!", context);

                        });
                      }catch(e){
                        NavigatorConfig.showToast("Wrong email/pass", context);
                      }
                    } else {
                      NavigatorConfig.showToast(
                          "Email not valid!", context);
                    }
                  } else {
                    NavigatorConfig.showToast(
                        "Please fill Email!", context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Text(
                  "Login",
                  style: GoogleFonts.oswald(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    ), onWillPop: ()async=>false);
  }

}