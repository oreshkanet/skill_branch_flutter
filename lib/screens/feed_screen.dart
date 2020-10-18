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
          return Column(children: <Widget>[
            _buildItem(index),
            Divider(thickness: 2, color: AppColors.mercury),
          ]);
        },
        itemCount: 10,
      ),
    );
  }

  Widget _buildItem(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImage(
                tag: 'dash' + index.toString(),
                name: 'Денис Сайгин',
                userName: 'oreshkanet',
                photo: kFlutterDash,
                altDescription:
                    'Beautiful girl in a yellow dress with a flower on her head in the summer in the forest'),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(tag: 'dash' + index.toString(), child: Photo(photoLink: kFlutterDash)),
          _buildPhotoMeta(),
          _buildPhotoDescription(),
        ],
      ),
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
                  'https://avatars0.githubusercontent.com/u/69664569?s=460&v=4'),
              SizedBox(width: 6),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Денис Сайгин', style: AppStyles.h2Black),
                    Text('@oreshkanet',
                        style: AppStyles.h5Black
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
        style: AppStyles.h3.copyWith(color: AppColors.manatee),
      ),
    );
  }
}
