import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:katalog_movie_app/domain/entities/tv_season.dart';
import 'package:katalog_movie_app/domain/usecases/tv_usecase/get_tv_season.dart';

part 'tv_season_event.dart';
part 'tv_season_state.dart';

class TvSeasonBloc extends Bloc<TvSeasonEvent, TvSeasonState> {
  final GetTvSeason getTvSeason;
  TvSeasonBloc({required this.getTvSeason}) : super(TvSeasonInitial()) {
    on<FetchTvSeason>(((event, emit) async {
      emit(TvSeasonLoading());
      final id = event.id;
      final seasonNumber = event.seasonNumber;

      final result = await getTvSeason.execute(id, seasonNumber);

      result.fold((failure) => emit(TvSeasonError(failure.message)),
          (tvSeason) => emit(TvSeasonHasData(tvSeason)));
    }));
  }
}
