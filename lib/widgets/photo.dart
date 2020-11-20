import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  Photo(
      {Key key,
      this.photoLink,
      this.paddingHorizontal = 10,
      this.paddingVertical = 5,
      this.borderRadius = 17})
      : super(key: key);

  final String photoLink;
  final double paddingHorizontal;
  final double paddingVertical;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Container(
            color: AppColors.grayChateau,
            child: CachedNetworkImage(
              imageUrl: photoLink,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          )),
    );
  }
}
