import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {

  // To save the user's token
  Future<bool> saveUser(UserModel userModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", userModel.token!);
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final token = sp.getString("token");
    return UserModel(token: token);
  }

  Future<bool> remove()async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("token");
    return true;
  }
}