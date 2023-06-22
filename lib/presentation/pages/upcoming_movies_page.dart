import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/upcoming_movies_bloc/upcoming_movies_bloc.dart';
import 'package:katalog_movie_app/presentation/widgets/movie_card_list.dart';

class UpcomingMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/upcoming-movie';
  const UpcomingMoviesPage({Key? key}) : super(key: key);

  @override
  State<UpcomingMoviesPage> createState() => _UpcomingMoviesPageState();
}

class _UpcomingMoviesPageState extends State<UpcomingMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<UpcomingMoviesBloc>(context, listen: false)
            .add(FetchUpcomingMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
          builder: (context, state) {
            if (state is UpcomingMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UpcomingMoviesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.listMovie[index];
                  return MovieCard(movie);
                },
                itemCount: state.listMovie.length,
              );
            } else if (state is UpcomingMoviesError) {
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
