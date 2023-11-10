part of 'banner_bloc.dart';

@immutable
sealed class BannerState {}

final class BannerInitial extends BannerState {}
final class BannerLoading extends BannerState {}
final class BannerSucces extends BannerState {
  final BannerResponseEntity banner;

  BannerSucces({required this.banner});
}
final class BannerFailed extends BannerState {
  final String? message;

  BannerFailed({this.message});

}
