import 'package:katalog_movie_app/domain/repositories/movie_repository.dart';

class GetWatchlistStatus {
  final MovieRepository repository;

  GetWatchlistStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
