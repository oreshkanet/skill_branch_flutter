import 'package:FlutterGalleryApp/models/models.dart';
import 'package:flutter/cupertino.dart';

abstract class CollectionsListState {}

class EmptyCollectionsListState extends CollectionsListState {}

class LoadingCollectionsListState extends CollectionsListState {}

class LoadedCollectionsListState extends CollectionsListState {
  String userName;
  CollectionsList collectionsList;
  int perPage;
  int currPage;
  bool lastPage;

  LoadedCollectionsListState({
    @required this.collectionsList,
    this.userName,
    this.perPage,
    this.currPage,
    this.lastPage,
  });
}

class ErrorCollectionsListState extends CollectionsListState {
  String errorText;

  ErrorCollectionsListState({
    @required errorText,
  });
}
