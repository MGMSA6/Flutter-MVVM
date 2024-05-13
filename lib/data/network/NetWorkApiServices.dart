import 'dart:io';

import 'package:mvvm/data/app_exceptions.dart';
import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm/data/response/response_handler.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic jsonResponse;

    try {
      final getResponse =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      jsonResponse = ResponseHandler.returnResponse(getResponse);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return jsonResponse;
  }

  @override
  Future getPostApiResponse(String url, dynamic body) async {
    dynamic jsonResponse;
    try {
      final postResponse = await http
          .post(Uri.parse(url), body: body)
          .timeout(const Duration(seconds: 10));

      jsonResponse = ResponseHandler.returnResponse(postResponse);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return jsonResponse;
  }
}
