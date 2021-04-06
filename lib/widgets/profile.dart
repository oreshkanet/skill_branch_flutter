import 'package:FlutterGalleryApp/bloc/bloc.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/photo.dart';
import 'package:FlutterGalleryApp/widgets/photoGrid.dart';
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
        if (state is EmptyProfileState) {
          return _buildEmptyProfile();
        } else if (state is LoadingProfileState) {
          return _buildLoadingProfile();
        } else if (state is LoadedProfileState) {
          return _buildProfile(
            state.profile,
            state.userPhotos,
            state.userLikes,
            state.userCollections,
          );
        } else if (state is ErrorProfileState) {
          return _buildErrorProfile(state.errorText);
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

  _buildProfile(
    User profile,
    PhotoList userPhotos,
    PhotoList userLikes,
    CollectionsList userCollections,
  ) {
    return Column(
      children: [
        _buildProfileSummery(profile),
        _buildProfileBio(profile),
        Expanded(
          child: _ProfileTabWidget(
            userName: profile.username,
            userPhotos: userPhotos,
            userLikes: userLikes,
            userCollections: userCollections,
          ),
        ),
      ],
    );
  }

  _buildProfileSummery(User profile) {
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

  _buildProfileSummeryAvatar(User profile) {
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

  _buildProfileSummeryName(User profile) {
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

  _buildProfileSummeryFollowers(User profile) {
    return Row(
      children: [
        Text(profile.followersCount.toString()),
        Text("followers"),
        Text(profile.followingCount.toString()),
        Text("following"),
      ],
    );
  }

  _buildProfileSummeryLocation(User profile) {
    if (profile.location != null) {
      return Row(
        children: [
          Icon(Icons.location_on),
          SizedBox(width: 8.0),
          Text(profile.location),
        ],
      );
    } else {
      return Container();
    }
  }

  _buildProfileSummeryLink(User profile) {
    if (profile.badge != null && profile.badge.link != null) {
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
    } else {
      return Container();
    }
  }

  _buildProfileBio(User profile) {
    if (profile.bio != null) {
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
    } else {
      return Container();
    }
  }

  _buildErrorProfile(String errorText) {
    return Center(child: Text(errorText));
  }
}

class _ProfileTabWidget extends StatefulWidget {
  const _ProfileTabWidget({
    this.userName,
    this.userPhotos,
    this.userLikes,
    this.userCollections,
    Key key,
  }) : super(key: key);

  final String userName;
  final PhotoList userPhotos;
  final PhotoList userLikes;
  final CollectionsList userCollections;

  @override
  _ProfileTabWidgetState createState() => _ProfileTabWidgetState();
}

class _ProfileTabWidgetState extends State<_ProfileTabWidget>
    with TickerProviderStateMixin {
  TabController _tabController;
  PhotoListBloc _userPhotoBloc;
  PhotoListBloc _userLikesBloc;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _userPhotoBloc = PhotoListBloc();
    _userPhotoBloc.add(LoadUserPhotosPhotoListEvent(userName: widget.userName));
    _userLikesBloc = PhotoListBloc();
    _userLikesBloc.add(LoadUserLikesPhotoListEvent(userName: widget.userName));
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
        children: <Widget>[
          BlocProvider(
            create: (context) {
              return _userPhotoBloc;
            },
            child: PhotoGridWidget(),
          ),
          BlocProvider(
            create: (context) {
              return _userLikesBloc;
            },
            child: PhotoGridWidget(),
          ),
          _buildUserCollections(widget.userCollections),
        ],
      ),
    );
  }

  _buildUserCollections(CollectionsList userCollections) {
    return Center(
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(10.0),
        children: List.generate(
          userCollections.collections.length,
          (index) => PhotoWidget(
            photoLink: userCollections.collections[index].coverPhoto.urls.small,
            paddingHorizontal: 0.0,
            paddingVertical: 0.0,
            isRect: true,
          ),
        ),
      ),
    );
  }
}
