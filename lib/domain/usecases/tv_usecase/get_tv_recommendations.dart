import 'package:dartz/dartz.dart';
import 'package:katalog_movie_app/utils/failure.dart';
import 'package:katalog_movie_app/domain/entities/tv.dart';
import 'package:katalog_movie_app/domain/repositories/tv_repository.dart';

class GetTvRecommendations {
  TvRepository tvRepository;

  GetTvRecommendations(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute(int id) {
    return tvRepository.getTvRecommendations(id);
  }
}
