import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:katalog_movie_app/presentation/widgets/movie_card_list.dart';

class NowPlayingMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-movie';
  const NowPlayingMoviesPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingMoviesPage> createState() => _NowPlayingMoviesPageState();
}

class _NowPlayingMoviesPageState extends State<NowPlayingMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<NowPlayingMoviesBloc>(context, listen: false)
            .add(FetchNowPlayingMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
          builder: (context, state) {
            if (state is NowPlayingMovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingMovieHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.listMovie[index];
                  return MovieCard(movie);
                },
                itemCount: state.listMovie.length,
              );
            } else if (state is NowPlayingMovieError) {
              return Center(
                key: const Key('error_message'), // key to test app
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text("Failed"),
              );
            }
          },
        ),
      ),
    );
  }
}
