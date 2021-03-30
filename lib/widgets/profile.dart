import 'package:FlutterGalleryApp/bloc/profile/pofile_state.dart';
import 'package:FlutterGalleryApp/bloc/profile/profile_bloc.dart';
import 'package:FlutterGalleryApp/models/profile.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:FlutterGalleryApp/widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileWidget extends StatefulWidget {
  ProfileWidget({
    this.heroTag,
    Key key,
  }) : super(key: key);

  final String heroTag;

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
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
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          _buildProfileSummeryAvatar(profile),
          SizedBox(width: 17.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildProfileSummeryName(profile),
                _buildProfileSummeryFollowers(profile),
                _buildProfileSummeryLocation(profile),
                _buildProfileSummeryLink(profile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildProfileSummeryAvatar(Profile profile) {
    final avatarWidget = UserAvatarWidget(
      avatarLink: profile.profileImage.small,
      size: 75.0,
    );
    if (widget.heroTag != null) {
      return Hero(
        tag: widget.heroTag + '_avatar',
        child: avatarWidget,
      );
    } else {
      return avatarWidget;
    }
  }

  _buildProfileSummeryName(Profile profile) {
    final nameWidget = Text(
      profile.name,
      style: AppStyles.h1Black,
    );
    if (widget.heroTag != null) {
      return Hero(
        tag: widget.heroTag + '_name',
        child: nameWidget,
      );
    } else {
      return nameWidget;
    }
  }

  _buildProfileSummeryFollowers(Profile profile) {
    return Row(
      children: [
        Text(profile.followersCount.toString()),
        Text("followers"),
        Text(profile.followingCount.toString()),
        Text("following"),
      ],
    );
  }

  _buildProfileSummeryLocation(Profile profile) {
    return Row(
      children: [
        Icon(Icons.location_on),
        SizedBox(width: 8.0),
        Text(profile.location),
      ],
    );
  }

  _buildProfileSummeryLink(Profile profile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.link),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(profile.badge.link),
        ),
      ],
    );
  }

  _buildProfileBio(Profile profile) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10.0),
      child: Expanded(
        child: Text(
          profile.bio,
          textAlign: TextAlign.justify,
          maxLines: 3,
        ),
      ),
    );
  }

  _buildProfileTabs(Profile profile) {
    return Expanded(
      child: _TabWidget(),
    );
  }

  _buildErrorProfile() {
    return Center();
  }
}

class _TabWidget extends StatefulWidget {
  const _TabWidget({Key key}) : super(key: key);

  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<_TabWidget> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0x00ffffff),
        flexibleSpace: Column(
          children: [
            TabBar(
              indicatorColor: AppColors.dodgerBlue,
              labelColor: AppColors.dodgerBlue,
              unselectedLabelColor: AppColors.black,
              controller: _tabController,
              tabs: const <Widget>[
                Tab(
                  icon: Icon(AppIcons.home),
                ),
                Tab(
                  icon: Icon(AppIcons.like),
                ),
                Tab(
                  icon: Icon(Icons.bookmark_border),
                ),
              ],
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
            child: Text('It\'s cloudy here'),
          ),
          Center(
            child: Text('It\'s rainy here'),
          ),
          Center(
            child: Text('It\'s sunny here'),
          ),
        ],
      ),
    );
  }
}
