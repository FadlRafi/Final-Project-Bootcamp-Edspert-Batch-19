import 'package:learn_apps/src/domain/entity/banner_response_entity.dart';
import 'package:learn_apps/src/domain/repository/banner_repository.dart';

class GetBannerUsecase{
  final BannerRepository repository;
  const GetBannerUsecase({required this.repository});

  Future<BannerResponseEntity> call() async => await repository.getBanners();
}