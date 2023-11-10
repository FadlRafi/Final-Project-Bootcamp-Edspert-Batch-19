import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:learn_apps/src/data/model/banner_response_model.dart';
import 'package:learn_apps/src/value/path.dart';

class BannerRemoteDatasource {
  Future<BannerResponse> getBanners() async {
    try {
      final url = '${LearningPath.baseUrl}${LearningPath.bannerPath}';

      final result = await Dio().get(
        url,
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
      );
      final bannerResponse = BannerResponse.fromJson(result.data);

      return bannerResponse;
    } catch (e, stacktrace) {
      log(e.toString(), stackTrace: stacktrace, error: e);
      rethrow;
    }
  }
}
