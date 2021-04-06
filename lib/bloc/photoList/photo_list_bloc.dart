import 'dart:async';
import 'dart:developer' as developer;

import 'package:FlutterGalleryApp/bloc/photoList/photo_list_event.dart';
import 'package:FlutterGalleryApp/bloc/photoList/photo_list_state.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/services/unsplash_repository.dart';
import 'package:bloc/bloc.dart';

class PhotoListBloc extends Bloc<PhotoListEvent, PhotoListState> {
  final UnsplashRepository _repository = UnsplashRepository();

  PhotoListBloc() : super(EmptyPhotoListState());

  @override
  Stream<PhotoListState> mapEventToState(
    PhotoListEvent event,
  ) async* {
    final currentState = state;

    try {
      // TODO: Кучу кода можно вынести в отдельную процедуру и не повторять одно и то же
      if (event is LoadRandomPhotoListEvent) {
        yield LoadingPhotoListState();

        final PhotoList _result = await _repository.getRandomPhotos(9);
        yield LoadedPhotoListState(
          type: PhotoListType.random,
          photoList: _result,
          perPage: 9,
          currPage: 1,
          lastPage: true,
        );
      }
      if (event is LoadUserPhotosPhotoListEvent) {
        yield LoadingPhotoListState();

        final PhotoList _result =
            await _repository.getUserPhotos(event.userName, event.perPage);
        yield LoadedPhotoListState(
          type: PhotoListType.userPhotos,
          id: event.userName,
          photoList: _result,
          perPage: event.perPage,
          lastPage: (_result.photos.length < event.perPage),
        );
      }
      if (event is LoadUserLikesPhotoListEvent) {
        yield LoadingPhotoListState();

        final PhotoList _result =
            await _repository.getUserLikes(event.userName, event.perPage);
        yield LoadedPhotoListState(
          type: PhotoListType.userPhotos,
          id: event.userName,
          photoList: _result,
          perPage: event.perPage,
          lastPage: (_result.photos.length < event.perPage),
        );
      }
      if (event is LoadCollectionPhotoListEvent) {
        yield LoadingPhotoListState();

        final PhotoList _result = await _repository.getCollectionPhotos(
          event.collectionId,
          1,
          event.perPage,
        );
        yield LoadedPhotoListState(
          type: PhotoListType.collectionPhotos,
          id: event.collectionId,
          photoList: _result,
          perPage: event.perPage,
          currPage: 1,
          lastPage: (_result.photos.length < event.perPage),
        );
      }

      //FIXME:  ReloadPhotoListEvent
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ProfileBloc', error: _, stackTrace: stackTrace);
      yield ErrorPhotoListState(errorText: _.toString());
    }
  }
}
