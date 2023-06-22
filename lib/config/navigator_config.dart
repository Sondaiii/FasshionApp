import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigatorConfig {
  static void showToast(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  static void setCategory(int category)async{
    final shared = await SharedPreferences.getInstance();
     shared.setInt("category", category);
  }
  static Future<int> getCategory()async{
    final shared = await SharedPreferences.getInstance();
    return shared.getInt("category")?? 0;
  }
}
