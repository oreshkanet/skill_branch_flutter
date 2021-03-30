import 'package:FlutterGalleryApp/bloc/profile/profile_bloc.dart';
import 'package:FlutterGalleryApp/bloc/profile/profile_event.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/widgets/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreenArguments {
  UserProfileScreenArguments({
    this.routeSettings,
    this.heroTag,
    this.userName,
  });
  final RouteSettings routeSettings;
  final String heroTag;
  final String userName;
}

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({
    this.userName,
    this.heroTag,
  });

  final String heroTag;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocProvider(
        create: (context) {
          ProfileBloc profileBloc = ProfileBloc();
          profileBloc.add(ProfileLoadUserEvent(userName: this.userName));
          return profileBloc;
        }, //SearchBloc(repository: _repository),
        child: ProfileWidget(heroTag: heroTag),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: AppColors.grayChateau,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: AppColors.white,
      centerTitle: true,
      title: Text(
        "Profile",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
