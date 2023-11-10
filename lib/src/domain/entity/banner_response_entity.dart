
class BannerResponseEntity {
  int status;
  String message;
  List<BannerDataEntity> data;

  BannerResponseEntity(
      {required this.status, required this.message, required this.data});
}

class BannerDataEntity {
  String eventImage;
  BannerDataEntity({required this.eventImage});
}
