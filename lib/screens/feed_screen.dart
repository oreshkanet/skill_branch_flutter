import 'package:FlutterGalleryApp/color_converter.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/services/unsplash_repository.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/models/models.dart' as models;

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  ScrollController _scrollController = ScrollController();
  int pageCount = 0;
  bool isLoading = false;
  var data = List<models.Photo>();

  @override
  void initState() {
    _getData(pageCount);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        _getData(pageCount);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildListView(context, data),
    );
  }

  Widget _buildListView(BuildContext context, List<models.Photo> photos) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            height: 1.0,
            thickness: 1.0,
            indent: 1.0,
          );
        },
        controller: _scrollController,
        itemBuilder: (context, i) {
          if (i == data.length) {
            return Center(
              child: Opacity(
                opacity: isLoading ? 1 : 0,
                child: CircularProgressIndicator(),
              ),
            );
          }

          return _buildItem(photos[i]);
        },
        itemCount: photos.length,
      ),
    );
  }

  Widget _buildItem(models.Photo photoItem) {
    final heroTag = 'feedItem_${photoItem.id}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/fullScreenImage',
              arguments: FullScreenImageArguments(
                routeSettings: RouteSettings(
                  arguments: 'Photo',
                ),
                heroTag: heroTag,
                photoItem: photoItem,
              ),
            );
          },
          child: Hero(
              tag: heroTag,
              child: Photo(
                isRect: true,
                photoLink: photoItem.urls.regular,
                placeholderColor: ColorConverter.decode(photoItem.color),
              )),
        ),
        _buildPhotoMeta(photoItem),
        _buildPhotoDescription(photoItem),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildPhotoMeta(models.Photo photoItem) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              UserAvatar(avatarLink: photoItem.user.profileImage.small),
              const SizedBox(width: 10),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(photoItem.user.name,
                        style: Theme.of(context).textTheme.headline2),
                    Text('@${photoItem.user.username}',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: AppColors.manatee)),
                  ]),
            ],
          ),
          LikeButton(photoItem.likes, photoItem.likedByUser),
        ],
      ),
    );
  }

  Widget _buildPhotoDescription(models.Photo photoItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        photoItem.altDescription ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .headline3
            .copyWith(color: AppColors.manatee),
      ),
    );
  }

  void _getData(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var tempList = await UnsplashRepository().getPhotos(page, 10);

      setState(() {
        isLoading = false;
        data.addAll(tempList.photos);
        pageCount++;
      });
    }
  }
}
