import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thietkethoitrang/config/navigator_config.dart';
import 'package:thietkethoitrang/model/reminder_screen.dart';
import 'package:thietkethoitrang/view/category_screen.dart';
import 'package:thietkethoitrang/view/home_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: SplashPage()
    );
  }
}

class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _SplashPage();

}
class _SplashPage extends State<SplashPage>{
  bool loadsLogo = false;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Stack(
         children: [
       loadsLogo ?    Container(
             width: double.infinity,
             height: double.infinity,
             child: Image.asset("assets/intro.gif",fit: BoxFit.fill,),
           ):
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Container(
                 alignment: Alignment.center,
                 child: RichText(
                   text: TextSpan(
                       children: [
                         TextSpan(
                             text: "FASHION ",
                             style: TextStyle(
                                 fontSize: 32,
                                 color: Colors.black,
                                 fontWeight: FontWeight.w400,
                                 fontFamily: 'Abri'
                             )
                         ),
                         TextSpan(
                           text: "APP",
                           style: TextStyle(
                               fontSize: 32,
                               fontWeight: FontWeight.w400,
                               fontFamily: 'Abri',
                               color: Colors.white,
                               shadows: [
                                 BoxShadow(
                                     color: Colors.black,
                                     blurRadius: 4
                                 )
                               ]

                           ),

                         ),
                       ]
                   ),
                 ),
               ),
               Container(
                 width: double.infinity,
                 alignment: Alignment.center,
                 height: 27,
                 child: Container(
                   width: 200,
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       border: Border.all(
                           color: Colors.black
                       )
                   ),
                   child:  Text("M a k e Y ou r S t y l e",style: TextStyle(
                       fontFamily: 'Bodoni',
                       fontWeight: FontWeight.w400,
                       fontSize: 18
                   ),),
                 ),
               )


             ],
           ),
         ],
       )
     );
  }
  @override
  void initState() {
   Reminder.instances.init();
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      setState(() {
        loadsLogo = true;
      });
    });
    Future.delayed(const Duration(seconds: 9),()async{
      final isCheck = await NavigatorConfig.getCategory();
      if(isCheck>0){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoyScreen()));
      }


    });
  }

}
