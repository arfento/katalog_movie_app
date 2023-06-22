import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/airing_today_tvs_bloc/airing_today_tvs_bloc.dart';
import 'package:katalog_movie_app/presentation/widgets/tv_card_list.dart';

class AiringTodayTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-today-tvs';
  const AiringTodayTvsPage({Key? key}) : super(key: key);

  @override
  State<AiringTodayTvsPage> createState() => _AiringTodayTvsPageState();
}

class _AiringTodayTvsPageState extends State<AiringTodayTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<AiringTodayTvsBloc>(context, listen: false)
            .add(FetchAiringTodayTvs()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringTodayTvsBloc, AiringTodayTvsState>(
          builder: (context, state) {
            if (state is AiringTodayTvsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AiringTodayTvsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.listTv[index];
                  return TvCard(tv);
                },
                itemCount: state.listTv.length,
              );
            } else if (state is AiringTodayTvsError) {
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
