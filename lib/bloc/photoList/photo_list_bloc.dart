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

      if (event is LoadMorePhotoListEvent) {
        yield LoadingPhotoListState();

        if (currentState is LoadedPhotoListState) {
          if (currentState.lastPage) {
            yield currentState;
            return;
          }
          if (currentState.type == PhotoListType.collectionPhotos) {
            currentState.currPage++;
            final PhotoList _result = await _repository.getCollectionPhotos(
              currentState.id,
              currentState.currPage,
              currentState.perPage,
            );
            currentState.lastPage =
                (_result.photos.length < currentState.perPage);
            currentState.photoList.photos += _result.photos;
          }
          yield currentState;
          return;
        }
      }

      if (event is ReloadPhotoListEvent) {
        if (currentState is LoadedPhotoListState) {
          LoadedPhotoListState newState = LoadedPhotoListState(
            photoList: null,
            type: currentState.type,
            id: currentState.id,
            currPage: 1,
            perPage: currentState.perPage,
          );

          if (newState.type == PhotoListType.userPhotos) {
            newState.photoList = await _repository.getUserPhotos(
              newState.id,
              newState.perPage,
            );
          } else if (newState.type == PhotoListType.userLikes) {
            newState.photoList = await _repository.getUserLikes(
              newState.id,
              newState.perPage,
            );
          } else if (newState.type == PhotoListType.collectionPhotos) {
            newState.photoList = await _repository.getCollectionPhotos(
              newState.id,
              newState.currPage,
              newState.perPage,
            );
          }
          newState.lastPage =
              (newState.photoList.photos.length < newState.perPage);

          yield newState;
        }
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ProfileBloc', error: _, stackTrace: stackTrace);
      yield ErrorPhotoListState(errorText: _.toString());
    }
  }
}
