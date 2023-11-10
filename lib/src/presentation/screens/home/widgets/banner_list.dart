import 'package:flutter/material.dart';
import 'package:learn_apps/src/domain/entity/banner_response_entity.dart';

class BannerListWidget extends StatelessWidget {
  final List<BannerDataEntity> bannerList;
  const BannerListWidget({super.key, required this.bannerList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 146,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 29,),
        scrollDirection: Axis.horizontal,
        itemCount: bannerList.length,
        itemBuilder: (context, index) {
          final banner = bannerList[index];

          return ClipRRect(// untuk membuat border radius
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 146,
              width: 284,
              child: Image.network(
                banner.eventImage,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
