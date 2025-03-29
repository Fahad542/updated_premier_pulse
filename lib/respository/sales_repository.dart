
import 'dart:convert';


import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm/view/Login_screen/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/sales_model.dart';
import 'api_services.dart';
import 'authentication and base_url.dart';


class SalesRepository {

  final PostApiService _apiService = PostApiService();
  Future<List> fetchData(String empCodes,String startdate, String enddate, List<int> companyCodes,List<int> branchcode,List<String> measures, String designation) async {
    for (int i = 0; i < measures.length; i++) {
      if(designation =="DSF") {

      }
      if (measures[i] == "Sales Inc ST") {
        measures.removeAt(i);
        break; // Exit the loop after removing the value
      }
    }

    final url = 'https://api.psplbi.com/api/empmeasure';
    print(url);
    final requestData =
    [
      {
        "EmpCode": empCodes,
        "EmpDesignation": empcode.designation,
        "Depth": empcode.depth,
        "FirstDate": startdate,
        "LastDate": enddate,
        "CompanyID": companyCodes,
        "BranchID": branchcode,
        "MeasureName":[... measures, "Sales Inc ST","DSFTarget Value"],
      }
    ];
    print(jsonEncode(requestData));

    var response = await _apiService.postData1(url, requestData);
    print("api data: $response");
    return response;
  }



  Future<Map<String,dynamic>> getdsftarget(String empCodes,String startdate, String enddate) async {
    final url = 'https://api.psplbi.com/api/empgraph';
    print(url);
    final requestData =
    [
      {
        "EmpCode": empCodes,
        "FirstDate": startdate,
        "LastDate": enddate,
      }
    ];
    print(jsonEncode(requestData));

    var response = await _apiService.postData1(url, requestData);
    print("api data: $response");
    return response;
  }








}
