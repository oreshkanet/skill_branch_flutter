import 'package:FlutterGalleryApp/models/profile.dart';

enum ProfileType { me, user }

abstract class ProfileState {}

class ProfileEmptyState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  String userName;
  Profile profile;
  ProfileType type;

  ProfileLoadedState({
    this.type,
    this.profile,
    this.userName,
  });
}

class ProfileErrorState extends ProfileState {}
