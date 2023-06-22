import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/watchlist_tv_bloc/watchlist_tv_bloc.dart';
import 'package:katalog_movie_app/utils/constants.dart';
import 'package:katalog_movie_app/utils/router.dart';

import '../widgets/tv_card_list.dart';

class WatchlistTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';
  const WatchlistTvsPage({super.key});

  @override
  State<WatchlistTvsPage> createState() => _WatchlistTvsPageState();
}

class _WatchlistTvsPageState extends State<WatchlistTvsPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<WatchlistTvBloc>(context, listen: false)
            .add(FetchWatchlistTv()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Future.microtask(() =>
        BlocProvider.of<WatchlistTvBloc>(context, listen: false)
            .add(FetchWatchlistTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
        builder: (context, state) {
          if (state is WatchlistTvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvHasData) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemBuilder: (context, index) {
                final tvShow = state.listTv[index];
                return TvCard(tvShow);
              },
              itemCount: state.listTv.length,
            );
          } else if (state is WatchlistTvError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else if (state is WatchlistTvEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  EvaIcons.tvOutline,
                  size: 150,
                ),
                Text(
                  "Your tv show watchlist is empty",
                  style: kSmallTitle,
                )
              ],
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
