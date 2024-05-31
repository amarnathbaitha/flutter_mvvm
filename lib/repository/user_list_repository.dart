
import 'package:flutter_mvvm/data/network/base_api_services.dart';
import 'package:flutter_mvvm/data/network/network_api_services.dart';
import 'package:flutter_mvvm/model/user_list_model.dart';
import 'package:flutter_mvvm/res/app_url.dart';

class UserListRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<UserListModel> userListApi() async{
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.userListEndPoint);
      return response = UserListModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }
}