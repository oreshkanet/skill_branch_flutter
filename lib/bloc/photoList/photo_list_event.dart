import 'package:flutter/cupertino.dart';

abstract class PhotoListEvent {}

class LoadRandomPhotoListEvent extends PhotoListEvent {}

class LoadUserPhotosPhotoListEvent extends PhotoListEvent {
  final String userName;

  LoadUserPhotosPhotoListEvent({@required this.userName});
}

class LoadUserLikesPhotoListEvent extends PhotoListEvent {
  final String userName;

  LoadUserLikesPhotoListEvent({@required this.userName});
}

class LoadUserCollectionsPhotoListEvent extends PhotoListEvent {
  final String userName;

  LoadUserCollectionsPhotoListEvent({@required this.userName});
}

class ReloadPhotoListEvent extends PhotoListEvent {}
