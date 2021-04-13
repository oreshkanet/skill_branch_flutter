import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    this.onTap,
    this.text,
    Key key,
  }) : super(key: key);
  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
}
