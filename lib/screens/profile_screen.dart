import 'package:FlutterGalleryApp/bloc/profile/profile_bloc.dart';
import 'package:FlutterGalleryApp/bloc/profile/profile_event.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/widgets/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileBloc _profileBloc;

  @override
  Widget build(BuildContext context) {
    _profileBloc = ProfileBloc();
    _profileBloc.add(ProfileLoadMeEvent());
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocProvider(
        create: (context) =>
            _profileBloc, //SearchBloc(repository: _repository),
        child: ProfileWidget(),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      title: Text("Profile"),
      backgroundColor: AppColors.white,
      centerTitle: true,
    );
  }
}
