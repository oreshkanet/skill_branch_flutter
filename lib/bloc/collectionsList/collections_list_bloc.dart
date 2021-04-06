import 'dart:async';
import 'dart:developer' as developer;

import 'package:FlutterGalleryApp/bloc/collectionsList/collections_list_event.dart';
import 'package:FlutterGalleryApp/bloc/collectionsList/collections_list_state.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/services/unsplash_repository.dart';
import 'package:bloc/bloc.dart';

class CollectionsListBloc
    extends Bloc<CollectionsListEvent, CollectionsListState> {
  final UnsplashRepository _repository = UnsplashRepository();

  CollectionsListBloc() : super(EmptyCollectionsListState());

  @override
  Stream<CollectionsListState> mapEventToState(
    CollectionsListEvent event,
  ) async* {
    try {
      if (event is LoadUserCollectionsListEvent) {
        yield LoadingCollectionsListState();

        final CollectionsList _result =
            await _repository.getUserCollections(event.userName, event.perPage);
        yield LoadedCollectionsListState(
          userName: event.userName,
          collectionsList: _result,
          perPage: event.perPage,
          lastPage: (_result.collections.length < event.perPage),
        );
      }
      //FIXME:  ReloadCollectionsListEvent
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ProfileBloc', error: _, stackTrace: stackTrace);
      yield ErrorCollectionsListState(errorText: _.toString());
    }
  }
}
