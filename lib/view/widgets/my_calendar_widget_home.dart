import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thietkethoitrang/extensions/color.dart';
import 'package:thietkethoitrang/model/outfit_model.dart';
import 'package:thietkethoitrang/view/details/details_outfit_calendar_screen.dart';

import '../account/login_screen.dart';

class MyCalendarWidgetHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyCalendarWidgetHome();
}

class _MyCalendarWidgetHome extends State<MyCalendarWidgetHome> with WidgetsBindingObserver{
  DateTime focusday = DateTime.now();
  List<OutfitModel> listOutFit = [];

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser == null
        ? Column(
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
                    if (FirebaseAuth.instance.currentUser==null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    } else {}
                  },
                ),
              )
            ],
          )
        :    SingleChildScrollView(
      child: TableCalendar(
        calendarFormat: CalendarFormat.month,
        currentDay: DateTime.now(),
        headerVisible: true,
        onPageChanged: (datetime) {
          setState(() {
            focusday = datetime;
          });
        },
        calendarStyle: CalendarStyle(
            selectedTextStyle: GoogleFonts.oswald(
                fontSize: 23,
                color: "#676767".toColor(),
                fontWeight: FontWeight.w500),
            isTodayHighlighted: true,
            defaultTextStyle: GoogleFonts.nunito(
                fontSize: 15,
                color: "#3E3E3E".toColor(),
                fontWeight: FontWeight.w300),
            todayDecoration: BoxDecoration(
                color: Colors.pink.withOpacity(0.4),
                shape: BoxShape.circle)),
        calendarBuilders:  CalendarBuilders(


          todayBuilder:  (context,day,day1){
              OutfitModel? outfitModel;
              String linkImages = "";
              DateFormat dateFormat = DateFormat("dd/MM/yyyy");
              String dayNow = dateFormat.format(day);
              if(listOutFit.isNotEmpty){
                 for(final i in listOutFit){
                    if(i.dateTime.toString() == dayNow){
                       linkImages = i.outfitImage.toString();
                       outfitModel=i;
                    }
                 }
              }
              
            return InkWell(
              onTap: (){
                if(outfitModel!=null){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsOutFitCalendarScreen(outfitModel!)))
                  .then((value) {
                    setState(() {
                      initDate();
                    });
                  });
                }

              },
              child: Container(
                width: 90,
                height: 90,

                decoration: BoxDecoration(


                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    )

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(padding: const EdgeInsets.only(left: 5,top: 2),child: Text(day.day.toString(),style: GoogleFonts.oswald(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black
                          ),),),
                          linkImages.isNotEmpty ? Image.network(linkImages,width: 24,height: 24,):Container()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          defaultBuilder: (context,day,day1){
            OutfitModel? outfitModel;
            String linkImages = "";
            DateFormat dateFormat = DateFormat("dd/MM/yyyy");
            String dayNow = dateFormat.format(day);
            if(listOutFit.isNotEmpty){
              for(final i in listOutFit){
                if(i.dateTime.toString() == dayNow){
                  linkImages = i.outfitImage.toString();
                  outfitModel=i;
                }
              }
            }

            return InkWell(
              onTap: (){
                if(outfitModel!=null){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsOutFitCalendarScreen(outfitModel!)))
                      .then((value) {
                    setState(() {
                      initDate();
                    });
                  });
                }

              },
              child: Container(
                width: 90,
                height: 90,

                decoration: BoxDecoration(


                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    )

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(padding: const EdgeInsets.only(left: 5,top: 2),child: Text(day.day.toString(),style: GoogleFonts.oswald(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black
                          ),),),
                          linkImages.isNotEmpty ? Image.network(linkImages,width: 24,height: 24,):Container()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          outsideBuilder: (context,day,day1){

            OutfitModel? outfitModel;
            String linkImages = "";
            DateFormat dateFormat = DateFormat("dd/MM/yyyy");
            String dayNow = dateFormat.format(day);
            if(listOutFit.isNotEmpty){
              for(final i in listOutFit){
                if(i.dateTime.toString() == dayNow){
                  linkImages = i.outfitImage.toString();
                  outfitModel=i;
                }
              }
            }

            return InkWell(
              child: Container(
                width: 90,
                height: 90,

                decoration: BoxDecoration(


                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    )

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(padding: const EdgeInsets.only(left: 5,top: 2),child: Text(day.day.toString(),style: GoogleFonts.oswald(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey
                          ),),),
                          linkImages.isNotEmpty ? Image.network(linkImages,width: 24,height: 24,):Container()
                        ],
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){
                if(outfitModel!=null){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsOutFitCalendarScreen(outfitModel!)))
                      .then((value) {
                    setState(() {
                      initDate();
                    });
                  });
                }

              },
            );
          },

        ),

        daysOfWeekHeight: 40,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: GoogleFonts.oswald(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500),
          weekendStyle: GoogleFonts.oswald(
              fontSize: 16,
              color: "#FF4275".toColor(),
              fontWeight: FontWeight.w500),
        ),
        headerStyle: HeaderStyle(
          headerMargin: const EdgeInsets.only(left: 35, right: 35),
          titleCentered: true,
          formatButtonVisible: false,
          formatButtonShowsNext: true,
          titleTextStyle: GoogleFonts.oswald(
              fontSize: 23,
              color: "#676767".toColor(),
              fontWeight: FontWeight.w500),
        ),
        firstDay: DateTime.utc(2015, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: focusday,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            // thang = selectedDay.month;
            // nam = selectedDay.year;
            focusday = selectedDay;
          });
        },
      ),


    
    );
  }

  initDate(){
    listOutFit.clear();
    if(FirebaseAuth.instance.currentUser!=null){
      FirebaseFirestore.instance.collection("Calendar")
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection("MyCalendar")
          .get().then((value){
        for(final i in value.docs){
          String id = i.id.toString();
          String date = i.get("Datetime");
          String outfit = i.get("Outfit");
          listOutFit.add(OutfitModel(id: id,dateTime: date,outfitImage: outfit));
        }
        setState(() {

        });
      });
    }

  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      initDate();
    }
    if (state == AppLifecycleState.paused) {
      initDate();
    }
    if (state == AppLifecycleState.resumed) {
      initDate();
    }
  }
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    initDate();
    super.initState();
  }
}
