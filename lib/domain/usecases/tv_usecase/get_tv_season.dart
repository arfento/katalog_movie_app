import 'package:dartz/dartz.dart';
import 'package:katalog_movie_app/utils/failure.dart';
import 'package:katalog_movie_app/domain/entities/tv_season.dart';
import 'package:katalog_movie_app/domain/repositories/tv_repository.dart';

class GetTvSeason {
  TvRepository tvRepository;

  GetTvSeason(this.tvRepository);

  Future<Either<Failure, TvSeason>> execute(int tvId, int seasonNumber) {
    return tvRepository.getTvSeason(tvId, seasonNumber);
  }
}
