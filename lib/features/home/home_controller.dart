import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/services/preferences_manger.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  String? username;
  List<TaskModel> tasks = [];
  String? userImagePath;
  bool isLoading = false;



  void init() {
    lodeUserData();
  }

  void lodeUserData() async {
    // await Future.delayed(Duration(seconds: 5));
    print("user name is (home) $username");

    username = PreferencesManger().getString(StorageKey.username);
    isLoading = true;
    userImagePath = PreferencesManger().getString(StorageKey.userImage);
    notifyListeners();
  }


}
