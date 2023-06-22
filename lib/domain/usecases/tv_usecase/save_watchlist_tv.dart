import 'package:dartz/dartz.dart';
import 'package:katalog_movie_app/utils/failure.dart';
import 'package:katalog_movie_app/domain/entities/tv_detail.dart';
import 'package:katalog_movie_app/domain/repositories/tv_repository.dart';

class SaveWatchlistTv {
  TvRepository repository;

  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return repository.saveWatchlistTv(tvDetail);
  }
}
