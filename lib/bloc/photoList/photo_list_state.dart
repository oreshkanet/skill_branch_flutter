import 'package:FlutterGalleryApp/models/models.dart';
import 'package:flutter/cupertino.dart';

enum PhotoListType {
  random,
  userPhotos,
  userLikes,
  collectionPhotos,
}

abstract class PhotoListState {}

class EmptyPhotoListState extends PhotoListState {}

class LoadingPhotoListState extends PhotoListState {}

class LoadedPhotoListState extends PhotoListState {
  PhotoListType type;
  PhotoList photoList;
  String id;
  int perPage;
  int currPage;
  bool lastPage;

  LoadedPhotoListState({
    @required this.type,
    @required this.photoList,
    this.id,
    this.perPage,
    this.currPage,
    this.lastPage,
  });
}

class ErrorPhotoListState extends PhotoListState {
  String errorText;

  ErrorPhotoListState({
    @required errorText,
  });
}
