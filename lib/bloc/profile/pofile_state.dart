import 'package:FlutterGalleryApp/models/profile.dart';

enum ProfileType { me, user }

abstract class ProfileState {}

class EmptyProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class LoadedProfileState extends ProfileState {
  String userName;
  Profile profile;
  ProfileType type;

  LoadedProfileState({
    this.type,
    this.profile,
    this.userName,
  });
}

class ErrorProfileState extends ProfileState {}
