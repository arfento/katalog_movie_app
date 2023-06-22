part of 'upcoming_movies_bloc.dart';

abstract class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState();

  @override
  List<Object> get props => [];
}

class UpcomingMoviesInitial extends UpcomingMoviesState {}

class UpcomingMoviesEmpty extends UpcomingMoviesState {}

class UpcomingMoviesLoading extends UpcomingMoviesState {}

class UpcomingMoviesError extends UpcomingMoviesState {
  final String message;

  const UpcomingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class UpcomingMoviesHasData extends UpcomingMoviesState {
  final List<Movie> listMovie;

  const UpcomingMoviesHasData(this.listMovie);

  @override
  List<Object> get props => [listMovie];
}
