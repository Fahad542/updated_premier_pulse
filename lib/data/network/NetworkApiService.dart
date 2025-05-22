
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mvvm/data/app_excaptions.dart';
import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices {


  @override
  Future getGetApiResponse(String url) async {

    dynamic responseJson ;
    try {

      final response = await http.get(

          Uri.parse(url),

      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    }
    on SocketException

    {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;

  }


  @override
  Future getPostApiResponse(String url , dynamic data) async
  {

    dynamic responseJson ;
    try {

      Response response = await post(
        Uri.parse(url),
        body: data
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {

      throw FetchDataException('No Internet Connection');
    }

    return responseJson ;
  }
  Future getPostApiResponsewithheader(String url , dynamic data) async
  {

    dynamic responseJson ;
    try {
      Map<String, String> headers = {
        'Authorization': 'Basic UHJFbSFlci5Hcm91cCQkJCsrOkNyRThpVmUmKl4xMjM0NTYrKw==',
        'Pr3mKEY': 'W74=Jse==ZU1JWR158TjJuUjlVN@t3Zz09', // Assuming content type is JSON
      };
      Response response = await post(
          Uri.parse(url),
          body: data,
        headers: headers
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {

      throw FetchDataException('No Internet Connection');
    }

    return responseJson ;
  }

  @override
  Future getPostApiResponsewithheaders(String url , dynamic data) async
  {

    dynamic responseJson ;
    try {

      Response response = await post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Basic cHNwbGJpXHJhZmlxdWUuamFja3dhbmk6UkBmaXF1ZUAxMjM="
          },

          body: data
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {

      throw FetchDataException('No Internet Connection');
    }

    return responseJson ;
  }





  @override
  Future getGetApiResponsewithheareds(String url) async {

    dynamic responseJson ;
    try {

      final response = await http.get(

        Uri.parse(url),
        headers: {
          "Authorization": "Basic Qm9vc3RlckFwcDp4MkJzVEhrcQ=="
        },
      );
      responseJson = returnResponse(response);
    }
    on SocketException

    {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;

  }







  dynamic returnResponse (http.Response response)

  {
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        print(responseJson);
        return responseJson ;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException('Error accured while communicating with server'+
            'with status code' +response.statusCode.toString());
    }
  }

}