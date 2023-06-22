import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:katalog_movie_app/presentation/pages/search_page.dart';
import 'package:katalog_movie_app/presentation/pages/watchlist_page.dart';
import 'package:katalog_movie_app/presentation/pages/watchlist_tvs_page.dart';
import 'package:katalog_movie_app/utils/constants.dart';
import 'movie_page.dart';
import 'tv_page.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;
  final _page = [
    const MoviePage(),
    const TvPage(),
    const WatchlistPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.video,
            ),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.tv,
            ),
            label: 'Tv Shows',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.bookmark,
            ),
            label: 'Watchlist',
          ),
        ],
        currentIndex: _selectIndex,
        onTap: (index) {
          // if (index == 2) {
          // Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
          // } else {
          setState(() {
            _selectIndex = index;
          });
          // }
        },
        backgroundColor: kRichBlack,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kWhite,
        unselectedFontSize: 11,
        iconSize: 22,
        selectedFontSize: 11,
        unselectedItemColor: kDavysGrey,
        elevation: 1,
      ),
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              EvaIcons.film,
              color: kMikadoYellow,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              _selectIndex == 0
                  ? "KATALOG MOVIES"
                  : _selectIndex == 1
                      ? "KATALOG TVS"
                      : "WATCHLIST",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: kMikadoYellow,
                fontSize: 19,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: const Icon(
              EvaIcons.search,
              color: kWhite,
            ),
          )
        ],
      ),
      body: _page[_selectIndex],
    );
  }
}
