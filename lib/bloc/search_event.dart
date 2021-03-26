import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchStartEvent extends SearchEvent {
  final String keyword;
  final int perPage;

  SearchStartEvent({this.keyword, this.perPage});
}

class SearchLoadEvent extends SearchEvent {}

class SearchCancelEvent extends SearchEvent {}
