import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:thietkethoitrang/model/reminder_screen.dart';
import 'package:thietkethoitrang/view/account/account_screen.dart';
import 'package:thietkethoitrang/view/account/login_screen.dart';
import 'package:thietkethoitrang/view/search/search_screen.dart';
import 'package:thietkethoitrang/view/widgets/features_widget_home.dart';
import 'package:thietkethoitrang/view/widgets/my_calendar_widget_home.dart';
import 'package:thietkethoitrang/view/widgets/my_closet_widget_home.dart';
import 'package:thietkethoitrang/view/widgets/news_widget_home.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            centerTitle: true,
            title: Text(
              "FASHION APP",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Abri'),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    if(FirebaseAuth.instance.currentUser!=null){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AccountScreen()));
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    }
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ))
            ],
          ),
          body: currentIndex== 3? MyCalendarWidgetHome():  currentIndex== 2?  MyCloseWidgetHome():Column(
            children: [
              Container(
                width: double.infinity,
                height: 1,
                margin: const EdgeInsets.only(bottom: 5),
                color: Colors.grey.shade200,
              ),
               IndexedStack(
                index: currentIndex,
                children: [
                  NewsWidgetScreen(),
                  FeatureWidgetScreen(),



                ],
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            selectedItemColor: Colors.black,
            selectedIconTheme: const IconThemeData(
              color: Colors.black,
            ),
            unselectedIconTheme: IconThemeData(color: Colors.grey.shade700),
            onTap: (tapCurrent) {
              setState(() {
                currentIndex = tapCurrent;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.camera_alt_outlined),
                  label: "News",
                  activeIcon: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.black,
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/features.png",
                  ),
                  label: "Featured",
                  activeIcon: Image.asset(
                    "assets/features.png",
                    color: Colors.black,
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/closet.png",
                  ),
                  label: "My Closet",
                  activeIcon: Image.asset(
                    "assets/closet.png",
                    color: Colors.black,
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: "Calendar",
                  activeIcon: Icon(
                    Icons.calendar_month,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        });
  }

  @override
  void initState() {
    Reminder.instances.init();
    if(FirebaseAuth.instance.currentUser!=null){
      int breaks = 0;
      DateFormat d = DateFormat("dd/MM/yyyy");
      FirebaseFirestore.instance.collection("Calendar")
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection("MyCalendar")
          .get().then((value){
        for(final i in value.docs){
          String date = i.get("Datetime");
          if(date == d.format(DateTime.now())){
            Reminder.instances.showNotifications();
            breaks=1;
            break;
          }
        }
        if(breaks==0){
          Reminder.instances.showNotificationsWelcome();
        }

      });
    }else{
      Reminder.instances.showNotificationsWelcome();

    }
    super.initState();



  }
}
