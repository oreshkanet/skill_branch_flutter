import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/services/unsplash_provider.dart';
import 'package:FlutterGalleryApp/services/unsplash_repository.dart';
import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:FlutterGalleryApp/models/models.dart' as models;

class FullScreenImageArguments {
  FullScreenImageArguments({
    this.heroTag,
    this.photoItem,
    this.key,
    this.routeSettings,
  });
  final String heroTag;
  final models.Photo photoItem;
  final Key key;
  final RouteSettings routeSettings;
}

class FullScreenImage extends StatefulWidget {
  FullScreenImage({
    this.heroTag,
    this.photoItem,
    Key key,
  }) : super(key: key);

  final String heroTag;
  final models.Photo photoItem;

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
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Hero(
                    tag: widget.heroTag,
                    child: Photo(photoLink: widget.photoItem.urls.regular),
                  ),
                  const SizedBox(height: 10),
                  _buildPhotoDescription(),
                  const SizedBox(height: 9),
                  _buildPhotoMeta(),
                  const SizedBox(height: 17),
                  _buildButtons(
                    () {
                      GallerySaver.saveImage(widget.photoItem.urls.full);
                      Navigator.of(context).pop();
                    },
                    () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 17),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: _buildRandom(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAppBar() {
    String title = ModalRoute.of(context).settings.arguments ?? 'Test';

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
        widget.photoItem.altDescription ?? '',
        maxLines: 2,
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _controller,
            child: UserAvatar(
                avatarLink: widget.photoItem.user.profileImage.medium),
            builder: (context, Widget child) {
              return Opacity(opacity: opacityUserAvatar.value, child: child);
            },
          ),
          const SizedBox(width: 10),
          AnimatedBuilder(
            animation: _controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.photoItem.user.name,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text('@${widget.photoItem.user.username}',
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
          const SizedBox(width: 12),
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
          const SizedBox(width: 12),
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

  Widget _buildRandom() {
    return FutureBuilder(
      future: UnsplashRepository().getRandomPhotos(9),
      builder: (context, AsyncSnapshot<models.PhotoList> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Что-то пошло не так :\'('));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return new GridView.count(
            primary: false,
            crossAxisCount: 3,
            childAspectRatio: 1.3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: snapshot.data.photos.map((models.Photo photoItem) {
              return Photo(
                photoLink: photoItem.urls.small,
                paddingHorizontal: 0,
                paddingVertical: 0,
                borderRadius: 7,
              );
            }).toList(),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildRandomList(List<models.Photo> photoList) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 4.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
              height: MediaQuery.of(context).size.width / 4,
              child: Photo(
                photoLink: photoList[index].urls.small,
              ));
        },
        childCount: photoList.length,
      ),
    );
  }
}
