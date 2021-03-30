import 'package:FlutterGalleryApp/bloc/profile/profile_bloc.dart';
import 'package:FlutterGalleryApp/bloc/profile/profile_event.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:FlutterGalleryApp/widgets/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocProvider(
        create: (context) {
          ProfileBloc profileBloc = ProfileBloc();
          profileBloc.add(ProfileLoadMeEvent());
          return profileBloc;
        },
        child: ProfileWidget(),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: [
        PopupMenuButton(
          icon: Icon(
            Icons.more_vert,
            color: AppColors.grayChateau,
          ),
          onSelected: (result) {},
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text("Logout"),
              ),
            ];
          },
        ),
      ],
      backgroundColor: AppColors.white,
      centerTitle: true,
      title: Text(
        "Profile",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
