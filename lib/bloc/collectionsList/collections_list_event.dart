import 'package:flutter/cupertino.dart';

abstract class CollectionsListEvent {}

class LoadUserCollectionsListEvent extends CollectionsListEvent {
  final String userName;
  final int perPage;

  LoadUserCollectionsListEvent({
    @required this.userName,
    this.perPage = 9,
  });
}

class LoadMoreCollectionsListEvent extends CollectionsListEvent {}

class ReloadCollectionsListEvent extends CollectionsListEvent {}
