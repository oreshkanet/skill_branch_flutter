import 'package:FlutterGalleryApp/models/models.dart';
import 'package:flutter/cupertino.dart';

enum PhotoListType {
  random,
  userPhotos,
  userLikes,
  userCollections,
}

abstract class PhotoListState {}

class EmptyPhotoListState extends PhotoListState {}

class LoadingPhotoListState extends PhotoListState {}

class LoadedPhotoListState extends PhotoListState {
  PhotoListType type;
  String userName;
  PhotoList photoList;

  LoadedPhotoListState({
    this.type,
    this.userName,
    this.photoList,
  });
}

class ErrorPhotoListState extends PhotoListState {
  String errorText;

  ErrorPhotoListState({
    @required errorText,
  });
}
