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
    this.placeholderColor = Colors.black26,
    this.isRect = false,
  }) : super(key: key);

  final String photoLink;
  final double paddingHorizontal;
  final double paddingVertical;
  final double borderRadius;
  final Color placeholderColor;
  final bool isRect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      child: this.isRect
          ? AspectRatio(
              aspectRatio: 1.0 / 1.0,
              child: _buildImage(context),
            )
          : _buildImage(context),
    );
  }

  Widget _buildImage(context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      child: CachedNetworkImage(
        imageUrl: photoLink,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            color: this.placeholderColor,
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
