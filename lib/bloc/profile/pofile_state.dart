import 'package:FlutterGalleryApp/models/models.dart';

enum ProfileType { me, user }

abstract class ProfileState {}

class EmptyProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class LoadedProfileState extends ProfileState {
  ProfileType type;
  String userName;
  User profile;
  PhotoList userPhotos;
  PhotoList userLikes;
  PhotoList userCollections;

  LoadedProfileState({
    this.type,
    this.profile,
    this.userName,
    this.userPhotos,
    this.userLikes,
    this.userCollections,
  });
}

class ErrorProfileState extends ProfileState {
  final String errorText;

  ErrorProfileState({
    this.errorText,
  });
}
