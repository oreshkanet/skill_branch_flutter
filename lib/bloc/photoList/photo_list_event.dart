import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PhotoListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

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

class LoadCollectionPhotoListEvent extends PhotoListEvent {
  final String collectionId;
  final int perPage;

  LoadCollectionPhotoListEvent({
    @required this.collectionId,
    this.perPage = 9,
  });
}

class LoadMorePhotoListEvent extends PhotoListEvent {}

class ReloadPhotoListEvent extends PhotoListEvent {}
