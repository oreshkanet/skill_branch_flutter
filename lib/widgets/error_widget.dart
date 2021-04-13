import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    this.errorText,
    Key key,
  }) : super(key: key);

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.errorBackground,
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(children: [
        Icon(
          Icons.warning_amber_rounded,
          color: AppColors.white,
        ),
        SizedBox(
          width: 16.0,
        ),
        Text(
          errorText,
          style: TextStyle(color: AppColors.white),
        ),
      ]),
    );
  }
}
