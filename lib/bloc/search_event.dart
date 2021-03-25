import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchStartEvent extends SearchEvent {
  final String keyword;

  SearchStartEvent({this.keyword});
}

class SearchLoadEvent extends SearchEvent {}

class SearchCancelEvent extends SearchEvent {}
