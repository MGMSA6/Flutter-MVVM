import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetWorkApiServices.dart';
import 'package:mvvm/res/app_url.dart';

import '../model/movies_model.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<MovieListModel> getMoviesList() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesUrl);
      return response = MovieListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
