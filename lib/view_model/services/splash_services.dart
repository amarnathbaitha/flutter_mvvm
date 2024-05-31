
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm/model/user_model.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/view_model/user_view_model.dart';

class SplashServices{

  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context){
    getUserData().then((value)  async{
     if(value.token == null || value.token == ""){
       await Future.delayed(const Duration(seconds: 3));
       if(context.mounted){
         Navigator.pushNamed(context, RoutesName.login);
       }else{
         return;
       }

     }else{
       await Future.delayed(const Duration(seconds: 3));
       if(context.mounted){
         Navigator.pushNamed(context, RoutesName.home);
       }else{
         return;
       }

     }
    }).onError((error, stackTrace) {
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}