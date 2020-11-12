import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String kFlutterDash =
    'https://248006.selcdn.ru/main/iblock/6f8/6f895fcf6ade1b0b20209ebe73ee72ea/b3b9ff725eb73759e796e743433df535.png.webp';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedState();
  }
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              _buildItem(index),
              Divider(thickness: 2, color: AppColors.mercury),
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }

  Widget _buildItem(int index) {
    final heroTag = 'feedItem_$index';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/fullScreenImage',
              arguments: FullScreenImageArguments(
                  routeSettings: RouteSettings(
                    arguments: 'Some Title',
                  ),
                  heroTag: heroTag,
                  name: 'Денис Сайгин',
                  userName: 'oreshkanet',
                  userPhoto:
                      'https://avatars0.githubusercontent.com/u/69664569?s=460&v=4',
                  photo: kFlutterDash,
                  altDescription:
                      'Beautiful girl in a yellow dress with a flower on her head in the summer in the forest'),
            );
          },
          child: Hero(tag: heroTag, child: Photo(photoLink: kFlutterDash)),
        ),
        _buildPhotoMeta(),
        _buildPhotoDescription(),
      ],
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              UserAvatar(
                  avatarLink:
                      'https://avatars0.githubusercontent.com/u/69664569?s=460&v=4'),
              SizedBox(width: 6),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Денис Сайгин',
                        style: Theme.of(context).textTheme.headline2),
                    Text('@oreshkanet',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: AppColors.manatee)),
                  ]),
            ],
          ),
          LikeButton(10, true),
        ],
      ),
    );
  }

  Widget _buildPhotoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        'Beautiful girl in a yellow dress with a flower on her head in the summer in the forest',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .headline3
            .copyWith(color: AppColors.manatee),
      ),
    );
  }
}
