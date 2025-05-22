import 'dart:convert';

import '../data/network/NetworkApiService.dart';

class AttendanceRepo {
  NetworkApiService apiServices = NetworkApiService() ;

  Future<Map<String, dynamic>> fectdata(String code) async {

    final url = 'https://premierspulse.com/ess/attendance/fetchPulseAttendance.php?empcode=${code}';
    print(url);
    dynamic response = await apiServices.getGetApiResponsewithheareds(url);
    print(response);
    return response;
  }
  Future<Map<String, dynamic>> dsf_attendance(String code) async {

    final url = 'https://booster.b2bpremier.com/services/DsfAttendanceData';
    print(url);
    print("Code: ${code}");
    dynamic response = await apiServices.getPostApiResponse(url, jsonEncode( [{
      "dsfcode": code
    }]
    ));
    print(response);
    return response;
  }
}