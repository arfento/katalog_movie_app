import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:katalog_movie_app/domain/entities/tv.dart';
import 'package:katalog_movie_app/domain/usecases/tv_usecase/get_airing_today_tvs.dart';

part 'airing_today_tvs_event.dart';
part 'airing_today_tvs_state.dart';

class AiringTodayTvsBloc
    extends Bloc<AiringTodayTvsEvent, AiringTodayTvsState> {
  final GetAiringTodayTvs airingTodayTvs;
  AiringTodayTvsBloc({required this.airingTodayTvs})
      : super(AiringTodayTvsInitial()) {
    on<FetchAiringTodayTvs>(((event, emit) async {
      emit(AiringTodayTvsLoading());
      final result = await airingTodayTvs.execute();
      result.fold(
        (failure) => emit(AiringTodayTvsError(failure.message)),
        (tvs) => emit(AiringTodayTvsHasData(tvs)),
      );
    }));
  }
}
