import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:katalog_movie_app/domain/usecases/movie_usecase/get_movie_similar.dart';
import 'package:katalog_movie_app/domain/usecases/movie_usecase/get_upcoming_movies.dart';
import 'package:katalog_movie_app/domain/usecases/tv_usecase/get_airing_today_tvs.dart';
import 'package:katalog_movie_app/domain/usecases/tv_usecase/get_tv_similar.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/movie_search_bloc/movie_search_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/upcoming_movies_bloc/upcoming_movies_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/airing_today_tvs_bloc/airing_today_tvs_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/on_the_air_tvs_bloc/on_the_air_tvs_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/popular_tvs_bloc/popular_tvs_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/tv_search_bloc/tv_search_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/tv_season_bloc/tv_season_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/watchlist_tv_bloc/watchlist_tv_bloc.dart';

import '../data/datasources/database/database_helper.dart';
import '../data/datasources/movie_local_data_source.dart';
import '../data/datasources/movie_remote_data_source.dart';
import '../data/datasources/tv_local_data_source.dart';
import '../data/datasources/tv_remote_data_source.dart';
import '../data/repositories/movie_repository_impl.dart';
import '../data/repositories/tv_repository_impl.dart';
import '../domain/repositories/movie_repository.dart';
import '../domain/repositories/tv_repository.dart';
import '../domain/usecases/movie_usecase/get_movie_detail.dart';
import '../domain/usecases/movie_usecase/get_movie_recommendations.dart';
import '../domain/usecases/movie_usecase/get_now_playing_movies.dart';
import '../domain/usecases/movie_usecase/get_popular_movies.dart';
import '../domain/usecases/movie_usecase/get_top_rated_movies.dart';
import '../domain/usecases/movie_usecase/get_watchlist_movies.dart';
import '../domain/usecases/movie_usecase/get_watchlist_status.dart';
import '../domain/usecases/movie_usecase/remove_watchlist.dart';
import '../domain/usecases/movie_usecase/save_watchlist.dart';
import '../domain/usecases/movie_usecase/search_movies.dart';
import '../domain/usecases/tv_usecase/get_on_the_air_tvs.dart';
import '../domain/usecases/tv_usecase/get_popular_tvs.dart';
import '../domain/usecases/tv_usecase/get_top_rated_tvs.dart';
import '../domain/usecases/tv_usecase/get_tv_detail.dart';
import '../domain/usecases/tv_usecase/get_tv_recommendations.dart';
import '../domain/usecases/tv_usecase/get_tv_season.dart';
import '../domain/usecases/tv_usecase/get_watchlist_tv_status.dart';
import '../domain/usecases/tv_usecase/get_watchlist_tvs.dart';
import '../domain/usecases/tv_usecase/remove_watchlist_tv.dart';
import '../domain/usecases/tv_usecase/save_watchlist_tv.dart';
import '../domain/usecases/tv_usecase/search_tvs.dart';

final locator = GetIt.instance;

void init() {
  ///movie bloc
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getMovieSimilar: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieWatchlistBloc(
      getWatchlistStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
      () => NowPlayingMoviesBloc(getNowPlayingMovies: locator()));
  locator.registerFactory(() => PopularMoviesBloc(popularMovies: locator()));
  locator.registerFactory(() => UpcomingMoviesBloc(upcomingMovies: locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(topRatedMovies: locator()));
  locator.registerFactory(() => MovieSearchBloc(locator()));
  locator.registerFactory(() => WatchlistMovieBloc(watchlistMovies: locator()));

  ///tv bloc
  locator.registerFactory(() => OnTheAirTvsBloc(getOnTheAirTvs: locator()));
  locator.registerFactory(() => PopularTvsBloc(popularTvs: locator()));
  locator.registerFactory(() => TopRatedTvsBloc(topRatedTvs: locator()));
  locator.registerFactory(() => AiringTodayTvsBloc(airingTodayTvs: locator()));
  locator.registerFactory(
    () => TvDetailBloc(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getTvSimilar: locator(),
    ),
  );
  locator.registerFactory(() => TvSeasonBloc(getTvSeason: locator()));
  locator.registerFactory(() => TvSearchBloc(locator()));
  locator.registerFactory(() => WatchlistTvBloc(watchlistTvs: locator()));
  locator.registerFactory(
    () => TvWatchlistBloc(
      getWatchlistStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );

  //use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetUpcomingMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetMovieSimilar(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case tv show
  locator.registerLazySingleton(() => GetOnTheAirTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetAiringTodayTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => GetTvSimilar(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));
  locator.registerLazySingleton(() => GetTvSeason(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovielocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helpers
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
