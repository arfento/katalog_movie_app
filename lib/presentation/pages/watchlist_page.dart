import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:katalog_movie_app/utils/constants.dart';

import 'watchlist_movies_page.dart';
import 'package:flutter/material.dart';

import 'watchlist_tvs_page.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            indicatorColor: kMikadoYellow,
            tabs: [
              Tab(icon: Icon(EvaIcons.video), text: "Movie"),
              Tab(icon: Icon(EvaIcons.tv), text: "Tv Show"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [WatchlistMoviesPage(), WatchlistTvsPage()],
        ),
      ),
    );
  }
}
