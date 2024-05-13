import 'dart:convert';
import 'package:http/http.dart' as http;
import '../app_exceptions.dart';

class ResponseHandler {
  static dynamic returnResponse(http.Response response) {
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
