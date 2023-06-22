import 'package:dartz/dartz.dart';
import 'package:katalog_movie_app/utils/failure.dart';
import 'package:katalog_movie_app/domain/entities/tv.dart';
import 'package:katalog_movie_app/domain/entities/tv_detail.dart';
import 'package:katalog_movie_app/domain/entities/tv_season.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTvs();
  Future<Either<Failure, List<Tv>>> getPopularTvs();
  Future<Either<Failure, List<Tv>>> getTopRatedTvs();
  Future<Either<Failure, List<Tv>>> getAiringTodayTvs();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, TvSeason>> getTvSeason(int tvId, int seasonNumber);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Tv>>> getTvSimilar(int id);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, List<Tv>>> getWatchlistTvs();
  Future<bool> isTvAddedToWatchlist(int id);
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tv);
}
