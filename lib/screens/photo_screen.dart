import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String kFlutterDash =
    'https://248006.selcdn.ru/main/iblock/6f8/6f895fcf6ade1b0b20209ebe73ee72ea/b3b9ff725eb73759e796e743433df535.png.webp';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({this.name, this.userName, this.altDescription, Key key})
      : super(key: key);

  final String name;
  final String userName;
  final String altDescription;

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImageState();
  }
}

class _FullScreenImageState extends State<FullScreenImage> {
  String name;
  String userName;
  String altDescription;

  @override
  void initState() {
    super.initState();

    name = widget.name == null ? '' : widget.name;
    userName = widget.userName == null ? '' : widget.userName;
    altDescription = widget.altDescription == null ? '' : widget.altDescription;
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
          Photo(photoLink: kFlutterDash),
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
          UserAvatar(
              'https://avatars0.githubusercontent.com/u/69664569?s=460&v=4'),
          SizedBox(width: 6),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(name, style: AppStyles.h2Black),
                Text('@$userName',
                    style:
                        AppStyles.h5Black.copyWith(color: AppColors.manatee)),
              ]),
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
