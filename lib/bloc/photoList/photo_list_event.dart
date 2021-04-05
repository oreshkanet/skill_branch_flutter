import 'package:flutter/cupertino.dart';

abstract class PhotoListEvent {}

class LoadRandomPhotoListEvent extends PhotoListEvent {}

class LoadUserPhotosPhotoListEvent extends PhotoListEvent {
  final String userName;
  final int perPage;

  LoadUserPhotosPhotoListEvent({
    @required this.userName,
    this.perPage = 9,
  });
}

class LoadUserLikesPhotoListEvent extends PhotoListEvent {
  final String userName;
  final int perPage;

  LoadUserLikesPhotoListEvent({
    @required this.userName,
    this.perPage = 9,
  });
}

class LoadMorePhotoListEvent extends PhotoListEvent {}

class ReloadPhotoListEvent extends PhotoListEvent {}
