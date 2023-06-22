import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thietkethoitrang/config/navigator_config.dart';
import 'package:thietkethoitrang/model/feature_child_category_model.dart';
import 'package:thietkethoitrang/view/home_screen.dart';

class CategoyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryScreen();
}

class _CategoryScreen extends State<CategoyScreen> {
  int current = 0;
  List<FeatureChildCategoryModel> listFeatues =
  FeatureChildCategoryModel().getDataList();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            body: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 25),
                      child: Text(
                        "Choose your featured",
                        style: GoogleFonts.abrilFatface(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          itemDanhMuc("MEN", 1),
                          itemDanhMuc("WOMEN", 2),
                          itemDanhMuc("LIFESTYLE", 3),
                          itemDanhMuc("SEASON", 4),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10, top: 30),
                      alignment: Alignment.center,
                      child: Text(
                        "---------------------------------",
                        style: GoogleFonts.bodoniModa(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      margin: const EdgeInsets.only(top: 15, left: 5, right: 5),
                      child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 3),
                          itemCount: listFeatues.length,
                          itemBuilder: (context, index) =>
                              itemChild(listFeatues[index])),
                    ),
                    Container(
                        width: 180,
                        height: 50,
                        margin: EdgeInsets.only(top: 150),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          child:  Text("Continue",style: GoogleFonts.bodoniModa(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w500), ),
                        ))
                  ],
                ),
              ],
            )),
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        });
  }

  itemDanhMuc(String listDanhMuc, int currentIndex) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
          margin: const EdgeInsets.only(left: 5, right: 5, top: 15),
          height: 25,
          width: 85,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: current == currentIndex ? Colors.white : Colors.grey,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black45, offset: Offset(1, 1), blurRadius: 4)
              ]),
          child: Text(
            listDanhMuc,
            style: GoogleFonts.bodoniModa(
                fontSize: 12,
                color: current == currentIndex ? Colors.black : Colors.white,
                fontWeight: FontWeight.w700),
          )),
      onTap: () {
        setState(() {
          current = currentIndex;
          NavigatorConfig.setCategory(currentIndex);
        });
      },
    );
  }

  itemChild(FeatureChildCategoryModel listFeatu) {
    return InkWell(
      onTap: () {
        setState(() {
          if (listFeatu.ischeck == true) {
            listFeatu.ischeck = false;
          } else {
            listFeatu.ischeck = true;
          }
        });
      },
      child: Container(
        width: 60,
        height: 15,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: listFeatu.ischeck == true ? Colors.black12 : Colors.white,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          listFeatu.name.toString(),
          style: GoogleFonts.bodoniModa(fontSize: 11, color: Colors.black),
        ),
      ),
    );
  }
}
