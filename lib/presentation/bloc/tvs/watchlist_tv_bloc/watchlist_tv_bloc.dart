import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:katalog_movie_app/domain/entities/tv.dart';
import 'package:katalog_movie_app/domain/usecases/tv_usecase/get_watchlist_tvs.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTvs watchlistTvs;
  WatchlistTvBloc({required this.watchlistTvs}) : super(WatchlistTvInitial()) {
    on<FetchWatchlistTv>(((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await watchlistTvs.execute();
      result.fold(
        (failure) => emit(WatchlistTvError(failure.message)),
        (tvs) {
          emit(WatchlistTvHasData(tvs));
          if (tvs.isEmpty) {
            emit(WatchlistTvEmpty());
          }
        },
      );
    }));
  }
}
