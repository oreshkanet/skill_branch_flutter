import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class FullScreenImageArguments {
  FullScreenImageArguments({
    this.heroTag,
    this.name,
    this.userName,
    this.userPhoto,
    this.photo,
    this.altDescription,
    this.key,
    this.routeSettings,
  });
  final String heroTag;
  final String name;
  final String userName;
  final String userPhoto;
  final String altDescription;
  final String photo;
  final Key key;
  final RouteSettings routeSettings;
}

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
      appBar: _buildAppBar(),
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
          _buildButtons(
            () {
              GallerySaver.saveImage(
                  'https://avatars0.githubusercontent.com/u/69664569?s=460&v=4');
              Navigator.of(context).pop();
            },
            () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    String title = ModalRoute.of(context).settings.arguments??'Test';

    return AppBar(
      elevation: 0,
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.grayChateau,
            ),
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                context: context,
                builder: (context) {
                  return ClaimBottomSheet();
                },
              );
            }),
      ],
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
        title,
        style: Theme.of(context).textTheme.headline1,
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
        style: Theme.of(context)
            .textTheme
            .headline3
            .copyWith(color: AppColors.manatee),
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
                Text(widget.name, style: Theme.of(context).textTheme.headline1),
                Text('@${widget.userName}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: AppColors.manatee)),
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

  Widget _buildButtons(VoidCallback onSave, VoidCallback onClose) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          LikeButton(2157, false),
          SizedBox(width: 12),
          _buildButton('Save', () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('download photos'),
                content: Text('Are you sure want to download photo?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: onSave,
                    child: Text('Download'),
                  ),
                  FlatButton(
                    onPressed: onClose,
                    child: Text('Close'),
                  ),
                ],
              ),
            );
          }),
          SizedBox(width: 12),
          _buildButton(
            'Visit',
            () async {
              OverlayState overlayState = Overlay.of(context);
              OverlayEntry overlayEntry =
                  OverlayEntry(builder: (BuildContext context) {
                return Positioned(
                  top: MediaQuery.of(context).viewInsets.top + 50,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                        decoration: BoxDecoration(
                          color: AppColors.mercury,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('SkillBranch'),
                      ),
                    ),
                  ),
                );
              });
              overlayState.insert(overlayEntry);
              await Future.delayed(Duration(seconds: 1));
              overlayEntry.remove();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: 105,
        height: 36,
        decoration: BoxDecoration(
            color: AppColors.dodgerBlue,
            borderRadius: BorderRadius.all(Radius.circular(7))),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
