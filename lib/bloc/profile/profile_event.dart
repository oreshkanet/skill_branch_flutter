abstract class ProfileEvent {}

class ProfileLoadMeEvent extends ProfileEvent {}

class ProfileLoadUserEvent extends ProfileEvent {
  final String userName;

  ProfileLoadUserEvent({this.userName});
}

class ProfileReloadEvent extends ProfileEvent {}
