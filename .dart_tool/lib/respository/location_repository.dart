
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/Location_model.dart';
import '../model/non_productive customer.dart';
import 'api_services.dart';


class LoactionRepo {
  NetworkApiService apiServices = NetworkApiService() ;
  final PostApiService _apiService = PostApiService();
  Future<LocationResponse> fectdata(String dsfcode, String date) async {

    final url = 'https://booster.b2bpremier.com/services/fetch_dsf_route_journey.php?dsfcode=${dsfcode}&bookingdate=${date}';
    print(url);
    dynamic response = await apiServices.getGetApiResponsewithheareds(url);
    print(response);
    return response= LocationResponse.fromJson(response);
  }
  Future<List<NonproCustomer>> nonproductivecust(String code, String startdate, String enddate) async {

    final url = 'https://api.psplbi.com/api/nonproductive_customers';
    print(url);
    List<NonproCustomer> data=[];
    var body=
[
        {
          "EmpCode": code,
          "FirstDate": startdate,
          "LastDate": enddate
        }
]
    ;
    print(body);
    dynamic response = await _apiService.postData1(url,body);
    print("REsponse: ${response}");
    if (response is List) {
      return response.map((json) => NonproCustomer.fromJson(json)).toList();
    } else {
      throw Exception('Unexpected response format');
    }
  }
}