import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/widgets/photo.dart';
import 'package:flutter/cupertino.dart';

class PhotoGridWidget extends StatelessWidget {
  const PhotoGridWidget({
    this.photoList,
    Key key,
  }) : super(key: key);

  final PhotoList photoList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(10.0),
        children: List.generate(
          photoList.photos.length,
          (index) => PhotoWidget(
            photoLink: photoList.photos[index].urls.small,
            paddingHorizontal: 0.0,
            paddingVertical: 0.0,
            isRect: true,
          ),
        ),
      ),
    );
  }
}
