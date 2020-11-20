import 'package:FlutterGalleryApp/data_provider.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/models/photo_list/model.dart' as photoModel;

const String kFlutterDash =
    'https://248006.selcdn.ru/main/iblock/6f8/6f895fcf6ade1b0b20209ebe73ee72ea/b3b9ff725eb73759e796e743433df535.png.webp';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  ScrollController _scrollController = ScrollController();
  int pageCount = 0;
  bool isLoading = false;
  var data = List<photoModel.Photo>();

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

  Widget _buildListView(BuildContext context, List<photoModel.Photo> photos) {
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

  Widget _buildItem(photoModel.Photo photoItem) {
    final heroTag = 'feedItem_${photoItem.id}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 6),
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
                photoLink: photoItem.urls.regular,
              )),
        ),
        _buildPhotoMeta(photoItem),
        _buildPhotoDescription(photoItem),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildPhotoMeta(photoModel.Photo photoItem) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              UserAvatar(avatarLink: photoItem.user.profileImage.small),
              SizedBox(width: 6),
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

  Widget _buildPhotoDescription(photoModel.Photo photoItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        photoItem.altDescription ?? '',
        maxLines: 3,
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
      var tempList = await DataProvider.getPhotos(page, 10);

      setState(() {
        isLoading = false;
        data.addAll(tempList.photos);
        pageCount++;
      });
    }
  }
}
