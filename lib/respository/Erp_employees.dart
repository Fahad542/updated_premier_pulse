import 'dart:convert';

import 'package:mvvm/model/Getemployees_model.dart';
import 'package:mvvm/view/Login_screen/login_view.dart';

import '../data/network/NetworkApiService.dart';

class GetErpEmployeesRepo {
  NetworkApiService apiServices = NetworkApiService() ;


  Future<List<ErpEmployee>> getErpEmployees(String code) async {
    final url = 'http://pg-ERPBI.premiergroup.com.pk:7060/api/Worker/GetErpEmployees?EmpCode=$code';
    print(url);
    print("Code: $code");

    dynamic response = await apiServices.getPostApiResponsewithheader(url, []);
    print("Response: ${response}");

    List<dynamic> data = response['response'];
    return data.map((e) => ErpEmployee.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> Send_request(String requestedfor_code,String requestedfor_name,
      String requestedunder_code,String requestedunder_name
      ) async {
    final url = 'https://premierspulse.com/ess/scripts/pulse/sendHierarchyRequest.php';
    print(url);

    final requestData =
    [
      {
        "requestedby_code": empcode.auth,
        "requestedby_name": empcode.name,
        "requestedfor_code": requestedfor_code,
        "requestedfor_name": requestedfor_name,
        "requestedunder_code": requestedunder_code,
        "requestedunder_name": requestedunder_name
      }
    ];
    dynamic response = await apiServices.getPostApiResponsewithheader(url, jsonEncode((requestData)  ));
    print("Response: ${response}");


    return response;
  }

}