import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/upcoming_movies_bloc/upcoming_movies_bloc.dart';
import 'package:katalog_movie_app/presentation/pages/now_playing_movies_page.dart';
import 'package:katalog_movie_app/presentation/pages/popular_movies_page.dart';
import 'package:katalog_movie_app/presentation/pages/top_rated_movies_page.dart';
import 'package:katalog_movie_app/presentation/pages/upcoming_movies_page.dart';
import 'package:katalog_movie_app/presentation/widgets/movie_list.dart';
import 'package:katalog_movie_app/utils/constants.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingMoviesBloc>(context, listen: false)
          .add(FetchNowPlayingMovies());
      BlocProvider.of<TopRatedMoviesBloc>(context, listen: false)
          .add(FetchTopRatedMovies());
      BlocProvider.of<PopularMoviesBloc>(context, listen: false)
          .add(FetchPopularMovies());
      BlocProvider.of<UpcomingMoviesBloc>(context, listen: false)
          .add(FetchUpcomingMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
            builder: (context, state) {
              if (state is UpcomingMoviesLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is UpcomingMoviesHasData) {
                return Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: false,
                        viewportFraction: 1.0,
                        aspectRatio: 2 / 2.3,
                        enlargeCenterPage: true,
                      ),
                      items: state.listMovie
                          .map(
                            (movie) => Stack(
                              children: [
                                AspectRatio(
                                    aspectRatio: 2 / 2.3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                                        width: screenWidth,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    )),
                                AspectRatio(
                                  aspectRatio: 2 / 2.3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          stops: const [
                                            0.0,
                                            0.4,
                                            0.4,
                                            1.0
                                          ],
                                          colors: [
                                            Colors.black.withOpacity(1.0),
                                            Colors.black.withOpacity(0.0),
                                            Colors.black.withOpacity(0.0),
                                            Colors.black.withOpacity(0.7),
                                          ]),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 5.0,
                                    right: 10.0,
                                    child: SafeArea(
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Release date: ",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          Text(
                                            movie.releaseDate!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    Positioned(
                        left: 10.0,
                        top: 10.0,
                        child: SafeArea(
                          child: Text(
                            "Upcoming movies",
                            style: TextStyle(
                                fontFamily: 'NunitoBold',
                                fontSize: 18.0,
                                color: Colors.white.withOpacity(0.5)),
                          ),
                        )),
                  ],
                );
              } else {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(child: Text("Failed")),
                );
              }
            },
          ),
          const SizedBox(
            height: 8,
          ),
          _buildSubHeading(
            title: "Now Playing",
            onTap: () {
              Navigator.pushNamed(context, NowPlayingMoviesPage.ROUTE_NAME);
            },
          ),
          BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
            builder: (context, state) {
              if (state is NowPlayingMovieLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is NowPlayingMovieHasData) {
                return MovieList(movies: state.listMovie);
              } else {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(child: Text("Failed")),
                );
              }
            },
          ),
          _buildSubHeading(
            title: "Popular",
            onTap: () {
              Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME);
            },
          ),
          BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
            builder: (context, state) {
              if (state is PopularMoviesLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is PopularMoviesHasData) {
                return MovieList(movies: state.listMovie);
              } else {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(child: Text("Failed")),
                );
              }
            },
          ),
          _buildSubHeading(
            title: "Upcomiing",
            onTap: () {
              Navigator.pushNamed(context, UpcomingMoviesPage.ROUTE_NAME);
            },
          ),
          BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
            builder: (context, state) {
              if (state is UpcomingMoviesLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is UpcomingMoviesHasData) {
                return MovieList(movies: state.listMovie);
              } else {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(child: Text("Failed")),
                );
              }
            },
          ),
          _buildSubHeading(
            title: "Top Rated",
            onTap: () {
              Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME);
            },
          ),
          BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
            builder: (context, state) {
              if (state is TopRatedMoviesLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is TopRatedMoviesHasData) {
                return MovieList(movies: state.listMovie);
              } else {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(child: Text("Failed")),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: kSmallTitle,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        )
      ],
    );
  }
}
