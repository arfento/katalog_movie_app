import 'package:dartz/dartz.dart';
import 'package:katalog_movie_app/utils/failure.dart';
import 'package:katalog_movie_app/domain/entities/movie.dart';
import 'package:katalog_movie_app/domain/repositories/movie_repository.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
