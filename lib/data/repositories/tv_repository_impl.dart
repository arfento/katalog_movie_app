import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:katalog_movie_app/utils/exception.dart';
import 'package:katalog_movie_app/utils/failure.dart';
import 'package:katalog_movie_app/data/datasources/tv_local_data_source.dart';
import 'package:katalog_movie_app/data/datasources/tv_remote_data_source.dart';
import 'package:katalog_movie_app/data/models/tv_table.dart';
import 'package:katalog_movie_app/domain/entities/tv.dart';
import 'package:katalog_movie_app/domain/entities/tv_detail.dart';
import 'package:katalog_movie_app/domain/entities/tv_season.dart';
import 'package:katalog_movie_app/domain/repositories/tv_repository.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;

  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Tv>>> getOnTheAirTvs() async {
    try {
      final result = await remoteDataSource.getOnTheAirTvs();
      return Right(result.map((data) => data.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTvs() async {
    try {
      final result = await remoteDataSource.getPopularTvs();
      return Right(result.map((data) => data.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTvs() async {
    try {
      final result = await remoteDataSource.getTopRatedTvs();
      return Right(result.map((data) => data.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getAiringTodayTvs() async {
    try {
      final result = await remoteDataSource.getAiringTodayTvs();
      return Right(result.map((data) => data.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((data) => data.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvSimilar(int id) async {
    try {
      final result = await remoteDataSource.getTvSimilar(id);
      return Right(result.map((data) => data.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTv(String query) async {
    try {
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvSeason>> getTvSeason(
      int tvId, int seasonNumber) async {
    try {
      final result = await remoteDataSource.getTvSeason(tvId, seasonNumber);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTvs() async {
    try {
      final result = await localDataSource.getWatchlistTvs();
      return Right(result.map((data) => data.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }

  @override
  Future<bool> isTvAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail movie) async {
    try {
      final result =
          await localDataSource.removeWatchlist(TvTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail movie) async {
    try {
      final result =
          await localDataSource.insertWatchlist(TvTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw Exception(e);
    }
  }
}
