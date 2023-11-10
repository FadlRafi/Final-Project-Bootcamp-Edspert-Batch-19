import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_apps/src/domain/entity/banner_response_entity.dart';
import 'package:learn_apps/src/domain/usecase/banner/get_banner_usecase.dart';
import 'package:meta/meta.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBannerUsecase getBannerUsecase;
  BannerBloc(this.getBannerUsecase) : super(BannerInitial()) {
    on<BannerEvent>((event, emit) async {
      // TODO: implement event handler
      if(event is GetBannerListEvent){
        emit(BannerLoading());

        final result = await getBannerUsecase();

        emit(BannerSucces(banner: result));
      }
    });
  }
}
