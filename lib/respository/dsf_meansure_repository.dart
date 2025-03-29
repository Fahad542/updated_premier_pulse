import 'dart:convert';
import '../model/dsf_measure_model.dart';
import 'api_services.dart';

class dsf_measure_Repository {

  final PostApiService _apiService = PostApiService();

  Future<List<DsfMeasureModel>> fetchData(String startdate, String enddate, int dsfcode)
  async
  {
    try {
      final url = 'https://api.psplbi.com/api/dsfmmeasures';
      print(url);
      final requestData =
      [
        {
          "FirstDate": startdate,
          "LastDate": enddate,
          "DSFCode": dsfcode,
          "MeasureName":
          [
            "SAF Customer",
            "Productive Customer",
            "ECO% S",
            "First Order",
            "Last Order",
            "Duration",
            "Avg Value Per Bill",
            "Avg SKU Per Bill",
            "DSFTarget Days DSF Remaining",
            "DSFTarget Days DSF Worked",
            "DSFTarget %",
            "DSFTarget Remaining",
            "DSFTarget Per Day Required",
            "DSFTarget Expected Landing",
            "DSFTarget Value",
            "Order Quantity",
            "Order Value",
            "Non Productive Customers*",
          ]
        }
      ];

      print("Data: ${json.encode(requestData)}");

      return _apiService.postData(url, requestData, (data) =>

      List<DsfMeasureModel>.from(

        data.map((json) => DsfMeasureModel.fromJson(json),),),);
    }
    catch(e, stack)
    {
      print("error: ${stack.toString()}");
      return [];
    }
  }




  Future<List<DsfMeasureModel>> dsftargetvalue(String startdate, String enddate, String dsfcode) async
  {
    try {
      final url = 'https://api.psplbi.com/api/dsfmmeasures';
      print(url);

      final requestData = [
        {
          "FirstDate": startdate,
          "LastDate": enddate,
          "DSFCode": dsfcode,
          "MeasureName": [
            "DSFTarget Value",
          ]
        }
      ];
      print("Request Data: ${json.encode(requestData)}");


      var response = await _apiService.postData(
          url,
          requestData,
              (data) => List<DsfMeasureModel>.from(data.map((json) => DsfMeasureModel.fromJson(json)))
      );
      if (response.isEmpty) {
        return [
          DsfMeasureModel.fromJson({
            "DSFTarget_Value": 0,
          }),
        ];
      }
      return response;

    }
    catch (e, stack)
    {
      print("Error: ${stack.toString()}");
      return [];
    }
  }

}