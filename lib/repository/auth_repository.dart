
import 'package:flutter_mvvm/data/network/base_api_services.dart';
import 'package:flutter_mvvm/data/network/network_api_services.dart';
import 'package:flutter_mvvm/res/app_url.dart';

class AuthRepository{

BaseApiServices _apiServices = NetworkApiServices();

Future<dynamic> loginApi(dynamic data) async{
  try{
     dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
     return response;
  }catch(e){
    throw e;
  }
}

Future<dynamic> signUpApi(dynamic data) async{
  try{
    dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerEndPoint, data);
    return response;
  }catch(e){
    throw e;
  }
}
}