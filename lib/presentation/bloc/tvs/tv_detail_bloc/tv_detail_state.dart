part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailEmpty extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailError extends TvDetailState {
  final String message;

  const TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailHasData extends TvDetailState {
  final TvDetail tvDetail;
  final List<Tv> tvRecommendations;
  final List<Tv> tvSimilar;

  const TvDetailHasData(
    this.tvDetail,
    this.tvRecommendations,
    this.tvSimilar,
  );

  @override
  List<Object> get props => [tvDetail, tvRecommendations, tvSimilar];
}
