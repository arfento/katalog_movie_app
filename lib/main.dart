import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/movies/upcoming_movies_bloc/upcoming_movies_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/airing_today_tvs_bloc/airing_today_tvs_bloc.dart';
import 'package:katalog_movie_app/presentation/pages/airing_today_tvs_page.dart';
import 'package:katalog_movie_app/presentation/pages/home_page.dart';
import 'package:katalog_movie_app/presentation/pages/movie_detail_page.dart';
import 'package:katalog_movie_app/presentation/pages/now_playing_movies_page.dart';
import 'package:katalog_movie_app/presentation/pages/on_the_air_tvs_page.dart';
import 'package:katalog_movie_app/presentation/pages/popular_movies_page.dart';
import 'package:katalog_movie_app/presentation/pages/popular_tvs_page.dart';
import 'package:katalog_movie_app/presentation/pages/search_page.dart';
import 'package:katalog_movie_app/presentation/pages/top_rated_movies_page.dart';
import 'package:katalog_movie_app/presentation/pages/top_rated_tvs_page.dart';
import 'package:katalog_movie_app/presentation/pages/tv_detail_page.dart';
import 'package:katalog_movie_app/presentation/pages/tv_season_page.dart';
import 'package:katalog_movie_app/presentation/pages/upcoming_movies_page.dart';
import 'package:katalog_movie_app/presentation/pages/watchlist_page.dart';
import 'package:katalog_movie_app/utils/constants.dart';
import 'package:katalog_movie_app/utils/router.dart';
import 'di/injection.dart' as di;
import 'presentation/bloc/movies/movie_detail_bloc/movie_detail_bloc.dart';
import 'presentation/bloc/movies/movie_search_bloc/movie_search_bloc.dart';
import 'presentation/bloc/movies/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'presentation/bloc/movies/popular_movies_bloc/popular_movies_bloc.dart';
import 'presentation/bloc/movies/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'presentation/bloc/movies/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'presentation/bloc/tvs/on_the_air_tvs_bloc/on_the_air_tvs_bloc.dart';
import 'presentation/bloc/tvs/popular_tvs_bloc/popular_tvs_bloc.dart';
import 'presentation/bloc/tvs/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';
import 'presentation/bloc/tvs/tv_detail_bloc/tv_detail_bloc.dart';
import 'presentation/bloc/tvs/tv_search_bloc/tv_search_bloc.dart';
import 'presentation/bloc/tvs/tv_season_bloc/tv_season_bloc.dart';
import 'presentation/bloc/tvs/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'presentation/bloc/tvs/watchlist_tv_bloc/watchlist_tv_bloc.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<NowPlayingMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<UpcomingMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<MovieSearchBloc>()),
        BlocProvider(create: (_) => di.locator<MovieWatchlistBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistMovieBloc>()),
        BlocProvider(create: (_) => di.locator<AiringTodayTvsBloc>()),
        BlocProvider(create: (_) => di.locator<OnTheAirTvsBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedTvsBloc>()),
        BlocProvider(create: (_) => di.locator<PopularTvsBloc>()),
        BlocProvider(create: (_) => di.locator<TvSearchBloc>()),
        BlocProvider(create: (_) => di.locator<TvDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TvSeasonBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistTvBloc>()),
        BlocProvider(create: (_) => di.locator<TvWatchlistBloc>()),
      ],
      child: MaterialApp(
        title: 'Katalog Movie App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case HomePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());
            case PopularMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case NowPlayingMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const NowPlayingMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case UpcomingMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const UpcomingMoviesPage());
            case SearchPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SearchPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case AiringTodayTvsPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const AiringTodayTvsPage());
            case OnTheAirTvsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const OnTheAirTvsPage());
            case PopularTvsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const PopularTvsPage());
            case TopRatedTvsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const TopRatedTvsPage());
            case TvSeasonPage.ROUTE_NAME:
              TvSeasonArguments arguments =
                  settings.arguments as TvSeasonArguments;
              return MaterialPageRoute(
                  builder: (_) => TvSeasonPage(
                        id: arguments.id,
                        seasonNumber: arguments.seasonNumber,
                      ));

            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
