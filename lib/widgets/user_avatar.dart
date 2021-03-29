import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class UserAvatarWidget extends StatelessWidget {
  final String avatarLink;
  double size = 40.0;

  UserAvatarWidget({
    Key key,
    this.avatarLink,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FIXME: Выводить серый фон, пока загружается
    return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          imageUrl: avatarLink,
          width: size,
          height: size,
          fit: BoxFit.fill,
          placeholder: (buildContext, text) {
            return Container(
              color: AppColors.grayPlaceholder,
            );
          },
        ));
  }
}
