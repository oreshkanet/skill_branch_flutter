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
  AnimationController _controller;
  Animation<double> opacityUserAvatar;
  Animation<double> opacityUserName;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    opacityUserName = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.5,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );
    opacityUserAvatar = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            tag: widget.heroTag,
            child: Photo(photoLink: widget.photo),
          ),
          const SizedBox(height: 11),
          _buildPhotoDescription(),
          const SizedBox(height: 9),
          _buildPhotoMeta(),
          const SizedBox(height: 17),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildPhotoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        widget.altDescription,
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
          AnimatedBuilder(
            animation: _controller,
            child: UserAvatar(avatarLink: widget.userPhoto),
            builder: (context, Widget child) {
              return Opacity(opacity: opacityUserAvatar.value, child: child);
            },
          ),
          SizedBox(width: 10),
          AnimatedBuilder(
            animation: _controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.name, style: AppStyles.h1Black),
                Text('@${widget.userName}',
                    style:
                        AppStyles.h5Black.copyWith(color: AppColors.manatee)),
              ],
            ),
            builder: (context, Widget child) {
              return Opacity(opacity: opacityUserName.value, child: child);
            },
          ),
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
