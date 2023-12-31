import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:katalog_movie_app/domain/entities/movie.dart';
import 'package:katalog_movie_app/domain/usecases/movie_usecase/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies watchlistMovies;

  WatchlistMovieBloc({required this.watchlistMovies})
      : super(WatchlistMovieEmpty()) {
    on<FetchWatchlistMovie>(((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await watchlistMovies.execute();
      result.fold(
        (failure) => emit(WatchlistMovieError(failure.message)),
        (movies) {
          emit(WatchlistMovieHasData(movies));
          if (movies.isEmpty) {
            emit(WatchlistMovieEmpty());
          }
        },
      );
    }));
  }
}
