import 'package:dartz/dartz.dart';
import 'package:katalog_movie_app/utils/failure.dart';
import 'package:katalog_movie_app/domain/entities/movie.dart';
import 'package:katalog_movie_app/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
