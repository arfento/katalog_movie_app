import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/airing_today_tvs_bloc/airing_today_tvs_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/on_the_air_tvs_bloc/on_the_air_tvs_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/popular_tvs_bloc/popular_tvs_bloc.dart';
import 'package:katalog_movie_app/presentation/bloc/tvs/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';
import 'package:katalog_movie_app/presentation/pages/airing_today_tvs_page.dart';
import 'package:katalog_movie_app/presentation/pages/on_the_air_tvs_page.dart';
import 'package:katalog_movie_app/presentation/pages/popular_tvs_page.dart';
import 'package:katalog_movie_app/presentation/pages/top_rated_tvs_page.dart';
import 'package:katalog_movie_app/presentation/widgets/tv_list.dart';
import 'package:katalog_movie_app/utils/constants.dart';

class TvPage extends StatefulWidget {
  const TvPage({Key? key}) : super(key: key);

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<OnTheAirTvsBloc>(context, listen: false)
          .add(FetchOnTheAirTvs());
      BlocProvider.of<PopularTvsBloc>(context, listen: false)
          .add(FetchPopularTvs());
      BlocProvider.of<TopRatedTvsBloc>(context, listen: false)
          .add(FetchTopRatedTvs());
      BlocProvider.of<AiringTodayTvsBloc>(context, listen: false)
          .add(FetchAiringTodayTvs());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocBuilder<TopRatedTvsBloc, TopRatedTvsState>(
            builder: (context, state) {
              if (state is TopRatedTvsLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is TopRatedTvsHasData) {
                return Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: false,
                        viewportFraction: 1.0,
                        aspectRatio: 2 / 2.3,
                        enlargeCenterPage: true,
                      ),
                      items: state.listTv
                          .map(
                            (tv) => Stack(
                              children: [
                                AspectRatio(
                                    aspectRatio: 2 / 2.3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/original/${tv.posterPath}',
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
                                            "Title Name: ",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          Text(
                                            tv.name!,
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
                            "Top Rated Tvs",
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
          _buildSubHeading(
            title: "On The Air",
            onTap: () {
              Navigator.pushNamed(context, OnTheAirTvsPage.ROUTE_NAME);
            },
          ),
          BlocBuilder<OnTheAirTvsBloc, OnTheAirTvsState>(
            builder: (context, state) {
              if (state is OnTheAirTvLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is OnTheAirTvHasData) {
                return TvList(tvs: state.listTv);
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
              Navigator.pushNamed(context, PopularTvsPage.ROUTE_NAME);
            },
          ),
          BlocBuilder<PopularTvsBloc, PopularTvsState>(
            builder: (context, state) {
              if (state is PopularTvsLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is PopularTvsHasData) {
                return TvList(tvs: state.listTv);
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
            title: "Airing Today",
            onTap: () {
              Navigator.pushNamed(context, AiringTodayTvsPage.ROUTE_NAME);
            },
          ),
          BlocBuilder<AiringTodayTvsBloc, AiringTodayTvsState>(
            builder: (context, state) {
              if (state is AiringTodayTvsLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is AiringTodayTvsHasData) {
                return TvList(tvs: state.listTv);
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
              Navigator.pushNamed(context, TopRatedTvsPage.ROUTE_NAME);
            },
          ),
          BlocBuilder<TopRatedTvsBloc, TopRatedTvsState>(
            builder: (context, state) {
              if (state is TopRatedTvsLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is TopRatedTvsHasData) {
                return TvList(tvs: state.listTv);
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
