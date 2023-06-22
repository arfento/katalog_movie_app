import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:katalog_movie_app/domain/entities/tv.dart';
import 'package:katalog_movie_app/domain/entities/tv_detail.dart';
import 'package:katalog_movie_app/domain/usecases/tv_usecase/get_tv_detail.dart';
import 'package:katalog_movie_app/domain/usecases/tv_usecase/get_tv_recommendations.dart';
import 'package:katalog_movie_app/domain/usecases/tv_usecase/get_tv_similar.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetTvSimilar getTvSimilar;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getTvSimilar,
  }) : super(TvDetailInitial()) {
    on<FetchTvDetail>(
      (((event, emit) async {
        final id = event.id;
        emit(TvDetailLoading());
        final detailResult = await getTvDetail.execute(id);
        final recommendationResult = await getTvRecommendations.execute(id);
        final similarResult = await getTvSimilar.execute(id);

        detailResult.fold((failure) {
          emit(TvDetailError(failure.message));
        }, (tvDetail) {
          emit(TvDetailLoading());
          recommendationResult.fold(
            (failure) {
              emit(TvDetailError(failure.message));
            },
            (tvRecommendation) {
              emit(TvDetailLoading());
              similarResult.fold(
                (failure) {
                  emit(TvDetailError(failure.message));
                },
                (tvSimilar) {
                  emit(TvDetailHasData(tvDetail, tvRecommendation, tvSimilar));
                },
              );
            },
          );
        });
      })),
    );
  }
}
