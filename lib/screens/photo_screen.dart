import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
//import '../res/res.dart';
//import '../widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({
    this.heroTag,
    this.name,
    this.userName,
    this.userPhoto,
    this.photo,
    this.altDescription,
    Key key,
  }) : super(key: key);

  final String heroTag;
  final String name;
  final String userName;
  final String userPhoto;
  final String altDescription;
  final String photo;

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImageState();
  }
}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  String heroTag;
  String name;
  String userName;
  String userPhoto;
  String altDescription;
  String photo;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    heroTag = widget.heroTag == null ? '' : widget.heroTag;
    name = widget.name == null ? '' : widget.name;
    userName = widget.userName == null ? '' : widget.userName;
    userPhoto = widget.userPhoto == null ? '' : widget.userPhoto;
    altDescription = widget.altDescription == null ? '' : widget.altDescription;
    photo = widget.photo == null ? '' : widget.photo;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward().orCancel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo', style: AppStyles.h1Black),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(icon: Icon(CupertinoIcons.back), onPressed: null),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: heroTag,
            child: Photo(photoLink: photo),
          ),
          _buildPhotoDescription(),
          _buildPhotoMeta(),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildPhotoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        altDescription,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: AppStyles.h3.copyWith(color: AppColors.manatee),
      ),
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          PhotoMetaAnimation(
            controller: _controller.view,
            name: name,
            userName: userName,
            userPhoto: userPhoto,
          )
          /*
          UserAvatar(avatarLink: userPhoto),
          SizedBox(width: 6),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  name,
                  style: AppStyles.h1Black,
                ),
                Text('@$userName',
                    style:
                        AppStyles.h5Black.copyWith(color: AppColors.manatee)),
              ]),
              */
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          LikeButton(2157, false),
          SizedBox(width: 12),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 105,
              height: 36,
              decoration: BoxDecoration(
                  color: AppColors.dodgerBlue,
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              child: Center(
                child: Text(
                  'Save',
                  textAlign: TextAlign.center,
                  style: AppStyles.h2Black.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 105,
              height: 36,
              decoration: BoxDecoration(
                  color: AppColors.dodgerBlue,
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              child: Center(
                child: Text(
                  'Visit',
                  textAlign: TextAlign.center,
                  style: AppStyles.h2Black.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoMetaAnimation extends StatelessWidget {
  PhotoMetaAnimation({
    Key key,
    this.controller,
    this.userPhoto,
    this.name,
    this.userName,
  })  : opacityUserAvatar = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.500,
              curve: Curves.ease,
            ),
          ),
        ),
        opacityUserName = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1.000,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final String userPhoto;
  final String userName;
  final String name;

  final AnimationController controller;
  final Animation<double> opacityUserAvatar;
  final Animation<double> opacityUserName;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Opacity(
            opacity: opacityUserAvatar.value,
            child: UserAvatar(avatarLink: userPhoto),
          ),
          SizedBox(width: 6),
          Opacity(
            opacity: opacityUserName.value,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name,
                    style: AppStyles.h1Black,
                  ),
                  Text('@$userName',
                      style:
                          AppStyles.h5Black.copyWith(color: AppColors.manatee)),
                ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
