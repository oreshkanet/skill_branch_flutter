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
    try {
      // TODO: Кучу кода можно вынести в отдельную процедуру и не повторять одно и то же
      if (event is LoadRandomPhotoListEvent) {
        yield LoadingPhotoListState();

        final PhotoList _result = await _repository.getRandomPhotos(9);
        yield LoadedPhotoListState(
          photoList: _result,
          type: PhotoListType.random,
        );
      }
      if (event is LoadUserPhotosPhotoListEvent) {
        yield LoadingPhotoListState();

        final PhotoList _result =
            await _repository.getUserPhotos(event.userName, 9);
        yield LoadedPhotoListState(
          photoList: _result,
          type: PhotoListType.userPhotos,
        );
      }
      if (event is LoadUserLikesPhotoListEvent) {
        yield LoadingPhotoListState();

        final PhotoList _result =
            await _repository.getUserLikes(event.userName, 9);
        yield LoadedPhotoListState(
          photoList: _result,
          type: PhotoListType.userPhotos,
        );
      }
      if (event is LoadUserLikesPhotoListEvent) {
        yield LoadingPhotoListState();

        final CollectionsList _result =
            await _repository.getUserCollections(event.userName, 9);
        yield LoadedPhotoListState(
          photoList: _result,
          type: PhotoListType.userPhotos,
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
