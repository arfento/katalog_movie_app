import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:katalog_movie_app/domain/entities/movie.dart';
import 'package:katalog_movie_app/domain/usecases/movie_usecase/get_upcoming_movies.dart';

part 'upcoming_movies_event.dart';
part 'upcoming_movies_state.dart';

class UpcomingMoviesBloc
    extends Bloc<UpcomingMoviesEvent, UpcomingMoviesState> {
  final GetUpcomingMovies upcomingMovies;
  UpcomingMoviesBloc({
    required this.upcomingMovies,
  }) : super(UpcomingMoviesInitial()) {
    on<FetchUpcomingMovies>(((event, emit) async {
      emit(UpcomingMoviesLoading());
      final result = await upcomingMovies.execute();
      result.fold(
        (failure) => emit(UpcomingMoviesError(failure.message)),
        (movies) => emit(UpcomingMoviesHasData(movies)),
      );
    }));
  }
}
