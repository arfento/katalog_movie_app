part of 'upcoming_movies_bloc.dart';

abstract class UpcomingMoviesEvent extends Equatable {
  const UpcomingMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchUpcomingMovies extends UpcomingMoviesEvent {}
