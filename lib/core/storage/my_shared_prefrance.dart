import 'package:products_app/screens/manage_products/model/product_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class MySharedPrefs {
  static MySharedPrefs _instance = new MySharedPrefs._internal();

  MySharedPrefs._internal();

  factory MySharedPrefs() => _instance;

  static Future<String> getStringVal(String _key) async {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String stringValue = prefs.getString(_key);
      return stringValue;
  }

  static setStringVal(String _key, String _val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _val);
  }



}
