import 'package:FlutterGalleryApp/bloc/profile/pofile_state.dart';
import 'package:FlutterGalleryApp/bloc/profile/profile_bloc.dart';
import 'package:FlutterGalleryApp/models/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<StatefulWidget> {
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();

    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileEmptyState) {
          return _buildEmptyProfile();
        } else if (state is ProfileLoadingState) {
          return _buildLoadingProfile();
        } else if (state is ProfileLoadedState) {
          return _buildProfile(state.profile);
        } else if (state is ProfileErrorState) {
          return _buildErrorProfile();
        } else {
          return _buildEmptyProfile();
        }
      },
    );
  }

  _buildEmptyProfile() {
    return Center(
      child: Text("Empty"),
    );
  }

  _buildLoadingProfile() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildProfile(Profile profile) {
    return Column(
      children: [
        _buildProfileSummery(profile),
        _buildProfileBio(profile),
        _buildProfileTabs(profile),
      ],
    );
  }

  _buildProfileSummery(Profile profile) {
    return Row(
      children: [
        Text(profile.name),
      ],
    );
  }

  _buildProfileBio(Profile profile) {
    return Text(
      profile.bio,
      maxLines: 3,
    );
  }

  _buildProfileTabs(Profile profile) {
    return Center();
  }

  _buildErrorProfile() {
    return Center();
  }
}
