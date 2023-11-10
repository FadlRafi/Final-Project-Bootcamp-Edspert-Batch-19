import 'package:learn_apps/src/data/datasource/banner_remote_datasource.dart';
import 'package:learn_apps/src/data/model/banner_response_model.dart';
import 'package:learn_apps/src/domain/entity/banner_response_entity.dart';
import 'package:learn_apps/src/domain/repository/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDatasource remoteDatasource;

  const BannerRepositoryImpl({required this.remoteDatasource});

  @override
  Future<BannerResponseEntity> getBanners() async {
    final bannerModel = await remoteDatasource.getBanners();

    final data = BannerResponseEntity(
      status: bannerModel.status ?? -1,
      message: bannerModel.message ?? '',
      data: List<Datum>.from(bannerModel.data ?? [])
          .map(
            (e) => BannerDataEntity(
              eventImage: e.eventImage ?? '',
            ),
          )
          .toList(),
    );
    return data;
  }
}
