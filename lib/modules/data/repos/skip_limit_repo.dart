import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_manager_app/constants/app_constants.dart';
import 'package:task_manager_app/modules/data/connection/network_helper.dart';

import '../models/skip_limit.dart';

class SkipLimitRepo {
  NetworkHelper networkHelper = NetworkHelper();

  Future<SkipLimit?> getSkipLimit (Map<String,dynamic> params) async {
    try {
      Response? response = await networkHelper.get(ApplicationConstants.todos,parameters: params);
      if(response!.statusCode == 200) {

        Map<String,dynamic> convertFromJson = response.data;
        print(convertFromJson);
        SkipLimit skipLimit = SkipLimit.fromJson(convertFromJson);
        return skipLimit;
      }else {
        SkipLimit skipLimit = SkipLimit.onError({'message':"something went wrong ."});
        return skipLimit;
      }
    }catch (e) {
      SkipLimit skipLimit = SkipLimit.onError({"message":e.toString()});
      return skipLimit;
    }
  }
}