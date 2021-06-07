import 'package:FlutterGalleryApp/models/models.dart';
import 'package:equatable/equatable.dart';

class PhotoList {
  List<Photo> photos;

  PhotoList({this.photos});

  PhotoList.fromJson(List<dynamic> json) {
    photos = List<Photo>();
    json.forEach((value) {
      photos.add(Photo.fromJson(value as Map<String, dynamic>));
    });
  }

  List<dynamic> toJson() {
    List<dynamic> result = List<dynamic>();

    photos.forEach((element) {
      result.add(element.toJson());
    });

    return result;
  }
}
