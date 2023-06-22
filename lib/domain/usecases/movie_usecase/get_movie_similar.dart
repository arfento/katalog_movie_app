import 'package:dartz/dartz.dart';
import 'package:katalog_movie_app/utils/failure.dart';
import 'package:katalog_movie_app/domain/entities/movie.dart';
import 'package:katalog_movie_app/domain/repositories/movie_repository.dart';

class GetMovieSimilar {
  final MovieRepository repository;

  GetMovieSimilar(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieSimilar(id);
  }
}
