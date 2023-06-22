import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:katalog_movie_app/utils/constants.dart';
import 'package:katalog_movie_app/utils/exception.dart';
import 'package:katalog_movie_app/data/models/tv_detail_model.dart';
import 'package:katalog_movie_app/data/models/tv_model.dart';
import 'package:katalog_movie_app/data/models/tv_response.dart';
import 'package:katalog_movie_app/data/models/tv_season_model.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getOnTheAirTvs();
  Future<List<TvModel>> getPopularTvs();
  Future<List<TvModel>> getTopRatedTvs();
  Future<List<TvModel>> getAiringTodayTvs();
  Future<TvDetailResponse> getTvDetail(int id);
  Future<List<TvModel>> getTvRecommendations(int id);
  Future<List<TvModel>> getTvSimilar(int id);
  Future<List<TvModel>> searchTv(String query);
  Future<TvSeasonModel> getTvSeason(int tvId, int seasonNumber);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<TvDetailResponse> getTvDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));
    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getOnTheAirTvs() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?page=2&$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTvs() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvs() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getAiringTodayTvs() async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/airing_today?page=3&$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTv(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeasonModel> getTvSeason(int tvId, int seasonNumber) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$tvId/season/$seasonNumber?$API_KEY'));
    if (response.statusCode == 200) {
      return TvSeasonModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvSimilar(int id) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/$id/similar?$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
