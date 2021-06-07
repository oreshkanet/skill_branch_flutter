import 'package:flutter/cupertino.dart';

abstract class ProfileEvent {}

class LoadMeProfileEvent extends ProfileEvent {}

class LoadUserProfileEvent extends ProfileEvent {
  final String userName;

  LoadUserProfileEvent({@required this.userName});
}

class ReloadProfileEvent extends ProfileEvent {}
