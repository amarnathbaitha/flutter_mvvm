import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm/data/response/api_response.dart';
import 'package:flutter_mvvm/model/user_list_model.dart';
import 'package:flutter_mvvm/repository/user_list_repository.dart';

class UserListViewModel with ChangeNotifier{

  ApiResponse<UserListModel> apiResponse = ApiResponse.loading();

  setUserList(ApiResponse<UserListModel> response){
    apiResponse = response;
    notifyListeners();
  }
  final _myRepo = UserListRepository();
  Future<void> fetchUserList() async{
    setUserList(ApiResponse.loading());
    _myRepo.userListApi().then((value) {
      setUserList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setUserList(ApiResponse.error(error.toString()));
    });
  }
}