import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  Photo({
    Key key,
    this.photoLink,
    this.paddingHorizontal = 10,
    this.paddingVertical = 5,
    this.borderRadius = 17,
    this.width,
    this.height,
    this.placeholderColor = Colors.black26,
  }) : super(key: key);

  final String photoLink;
  final double paddingHorizontal;
  final double paddingVertical;
  final double borderRadius;
  double width;
  double height;
  final Color placeholderColor;

  @override
  Widget build(BuildContext context) {
    if (width != null && height != null) {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.width / width * height;
      width = MediaQuery.of(context).size.width;
    }

    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: CachedNetworkImage(
            height: height,
            width: width,
            imageUrl: photoLink,
            fit: BoxFit.fill,
            placeholder: (context, url) => Center(
              child: Container(
                child: Container(
                  color: this.placeholderColor,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ));
  }
}
