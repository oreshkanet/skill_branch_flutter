import 'dart:async';
import 'dart:developer' as developer;

import 'package:FlutterGalleryApp/bloc/profile/pofile_state.dart';
import 'package:FlutterGalleryApp/bloc/profile/profile_event.dart';
import 'package:FlutterGalleryApp/models/profile.dart';
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
      if (event is LoadMeProfileEvent) {
        yield LoadingProfileState();

        final Profile _loadedProfile = await _repository.getMe();
        yield LoadedProfileState(
          profile: _loadedProfile,
          type: ProfileType.me,
        );
      }
      if (event is LoadUserProfileEvent) {
        yield LoadingProfileState();

        final Profile _loadedProfile =
            await _repository.getUser(event.userName);
        yield LoadedProfileState(
          profile: _loadedProfile,
          userName: event.userName,
          type: ProfileType.user,
        );
      }
      // FIXME: ReloadProfileEvent
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ProfileBloc', error: _, stackTrace: stackTrace);
      yield ErrorProfileState();
    }
  }
}
