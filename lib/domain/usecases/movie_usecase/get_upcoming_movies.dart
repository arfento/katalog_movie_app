import 'package:dartz/dartz.dart';
import 'package:katalog_movie_app/utils/failure.dart';
import 'package:katalog_movie_app/domain/entities/movie.dart';
import 'package:katalog_movie_app/domain/repositories/movie_repository.dart';

class GetUpcomingMovies {
  final MovieRepository repository;

  GetUpcomingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getUpcomingMovies();
  }
}
