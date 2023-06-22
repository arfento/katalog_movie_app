import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:katalog_movie_app/domain/entities/movie.dart';
import 'package:katalog_movie_app/domain/usecases/movie_usecase/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies popularMovies;
  PopularMoviesBloc({
    required this.popularMovies,
  }) : super(PopularMoviesInitial()) {
    on<FetchPopularMovies>(((event, emit) async {
      emit(PopularMoviesLoading());
      final result = await popularMovies.execute();
      result.fold(
        (failure) => emit(PopularMoviesError(failure.message)),
        (movies) => emit(PopularMoviesHasData(movies)),
      );
    }));
  }
}
