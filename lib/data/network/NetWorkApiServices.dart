import 'dart:convert';
import 'dart:io';

import 'package:mvvm/data/app_exceptions.dart';
import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic jsonResponse;

    try {
      final getResponse =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      jsonResponse = returnResponse(getResponse);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  @override
  Future getPostApiResponse(String url) async {
    dynamic jsonResponse;

    try {
      final postResponse =
          await http.post(Uri.parse(url)).timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(postResponse);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnAuthorizedException(response.body.toString());
      default:
        throw FetchDataException(
            "Error Occurred during communicating with server With Status Code: ${response.statusCode}");
    }
  }
}
