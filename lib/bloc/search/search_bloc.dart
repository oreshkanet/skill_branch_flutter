import 'package:FlutterGalleryApp/bloc/search/search_event.dart';
import 'package:FlutterGalleryApp/bloc/search/search_state.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/services/unsplash_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FlutterGalleryApp/res/res.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final UnsplashRepository repository = UnsplashRepository();

  static final SearchBloc _searchBloc = SearchBloc._internal();
  factory SearchBloc() {
    return _searchBloc;
  }
  SearchBloc._internal() : super(SearchEmptyState());

  @override
  Future<void> close() async {
    await super.close();
  }

  SearchState get initialState => SearchEmptyState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    final currentState = state;
    if (event is SearchStartEvent) {
      yield SearchLoadingState();
      try {
        throw Error();
        final PhotoSearch _loadedPhotoList = await repository.searchPhotos(
          event.keyword,
          0,
          event.perPage,
        );
        yield SearchLoadedState(
          keyword: event.keyword,
          photoList: _loadedPhotoList.results,
          perPage: event.perPage,
          currPage: 0,
          maxPage: _loadedPhotoList.totalPages,
        );
      } catch (_) {
        yield SearchErrorState(errorText: AppMessages.errorSearch);
      }
    } else if (event is SearchLoadEvent) {
      yield SearchLoadingState();
      try {
        if (currentState is SearchLoadedState) {
          if (currentState.currPage == currentState.maxPage) {
            yield currentState;
            return;
          }
          final PhotoSearch _loadedPhotoList = await repository.searchPhotos(
            currentState.keyword,
            currentState.currPage + 1,
            currentState.perPage,
          );
          currentState.currPage = currentState.currPage + 1;
          currentState.photoList =
              currentState.photoList + _loadedPhotoList.results;

          yield currentState;
        } else {
          yield SearchErrorState(errorText: AppMessages.errorSearch);
        }
      } catch (_) {
        yield SearchErrorState(errorText: AppMessages.errorSearch);
      }
    } else if (event is SearchCancelEvent) {
      yield SearchEmptyState();
    }
  }
}
