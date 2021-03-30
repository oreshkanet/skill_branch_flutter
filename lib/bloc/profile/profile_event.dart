import 'package:flutter/cupertino.dart';

abstract class ProfileEvent {}

class ProfileLoadMeEvent extends ProfileEvent {}

class ProfileLoadUserEvent extends ProfileEvent {
  final String userName;

  ProfileLoadUserEvent({@required this.userName});
}

class ProfileReloadEvent extends ProfileEvent {}
