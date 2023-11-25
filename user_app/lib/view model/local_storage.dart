import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/models/user_model.dart';

class LocalStorage with ChangeNotifier {
  Future<UserModel> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? res = sharedPreferences.getString('adminItem');
    print(res);
    return UserModel.fromJson(res!);
  }

  Future<bool> setUser(UserModel u) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool res = await sharedPreferences.setString('adminItem', u.toJson());
    return res;
  }
}
