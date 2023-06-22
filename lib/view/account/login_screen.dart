import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thietkethoitrang/config/navigator_config.dart';
import 'package:thietkethoitrang/view/account/forget_pass_screen.dart';
import 'package:thietkethoitrang/view/account/singup_screen.dart';
import 'package:thietkethoitrang/view/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 50),
                  width: double.infinity,
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontFamily: 'Abri'),
                  ),
                ),
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
                    margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Password",
                            style: GoogleFonts.oswald(
                                fontSize: 14, color: Colors.black),
                          ),
                          margin: EdgeInsets.only(left: 15),
                        ),
                        TextFormField(
                            controller: txtPass,
                            obscureText: true,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                              hintText: "Type your password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey.shade700,
                              ),
                            )),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey.shade200,
                        )
                      ],
                    )),
                Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(left: 25, top: 10),
                    height: 30,
                    child: InkWell(
                      child: SizedBox(
                        width: 120,
                        height: 50,
                        child: InkWell(
                          child: Text(
                            "Forget password?",
                            style: GoogleFonts.oswald(
                                fontSize: 14, color: Colors.black),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPassScreen()));
                          },
                        ),
                      ),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {},
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
                        String pass = txtPass.text.toString().trim();
                        if (email.isNotEmpty) {
                          if (EmailValidator.validate(email)) {
                            if (pass.isNotEmpty) {

                            try{
                              FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass)
                                  .then((value) {
                                try{
                                  if(value.user!=null){
                                    if(value.user!.emailVerified){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                                    }else{
                                      value.user?.sendEmailVerification();
                                      NavigatorConfig.showToast("Please go to gmail to verify your account!", context);
                                    }
                                  }else{
                                    NavigatorConfig.showToast("Wrong email/pass", context);
                                  }
                                }catch(e){
                                  NavigatorConfig.showToast("Wrong email/pass", context);
                                }

                              });
                            }catch(e){
                              NavigatorConfig.showToast("Wrong email/pass", context);
                            }

                            } else {
                              NavigatorConfig.showToast(
                                  "Please password", context);
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
                        "Sign In",
                        style: GoogleFonts.oswald(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    width: double.infinity,
                    height: 90,
                    margin: const EdgeInsets.only(top: 120),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "If you do not already have an account?",
                              style: GoogleFonts.oswald(
                                  fontSize: 15, color: Colors.grey.shade600)),
                          TextSpan(
                              text: "\nSign Up",
                              style: GoogleFonts.oswald(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        });
  }
}
