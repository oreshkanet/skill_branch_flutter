import 'package:FlutterGalleryApp/models/models.dart';
import 'package:flutter/cupertino.dart';

abstract class SearchState {}

class SearchEmptyState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final String keyword;
  List<Photo> photoList;
  int currPage;
  int maxPage;

  SearchLoadedState({
    @required this.keyword,
    @required this.photoList,
    this.currPage,
    this.maxPage,
  }) : assert(photoList != null);
}

class SearchErrorState extends SearchState {}
