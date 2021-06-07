import 'dart:async';
import 'dart:developer' as developer;

import 'package:FlutterGalleryApp/bloc/profile/profile_event.dart';
import 'package:FlutterGalleryApp/bloc/profile/profile_state.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/services/unsplash_repository.dart';
import 'package:bloc/bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UnsplashRepository _repository = UnsplashRepository();

  ProfileBloc() : super(EmptyProfileState());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    try {
      yield LoadingProfileState();

      User _loadedProfile;
      ProfileType _profileType;
      String _userName = "";
      if (event is LoadMeProfileEvent) {
        _profileType = ProfileType.me;
        _loadedProfile = await _repository.getMe();
        _userName = _loadedProfile.username;
      }
      if (event is LoadUserProfileEvent) {
        _profileType = ProfileType.user;
        _loadedProfile = await _repository.getUser(event.userName);
        _userName = event.userName;
      }

      List<dynamic> photoLists = await Future.wait([
        _repository.getUserPhotos(_userName, 9),
        _repository.getUserLikes(_userName, 9),
        _repository.getUserCollections(_userName, 9),
      ]);

      yield LoadedProfileState(
        type: _profileType,
        profile: _loadedProfile,
        userName: _userName,
        userPhotos: photoLists[0],
        userLikes: photoLists[1],
        userCollections: photoLists[2],
      );
      // FIXME: ReloadProfileEvent
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ProfileBloc', error: _, stackTrace: stackTrace);
      yield ErrorProfileState(errorText: _.message);
    }
  }
}
