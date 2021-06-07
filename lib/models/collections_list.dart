import 'package:FlutterGalleryApp/models/models.dart';

class CollectionsList {
  List<Collection> collections;

  CollectionsList({this.collections});

  CollectionsList.fromJson(List<dynamic> json) {
    collections = List<Collection>();
    json.forEach((value) {
      collections.add(Collection.fromJson(value as Map<String, dynamic>));
    });
  }

  List<dynamic> toJson() {
    List<dynamic> result = List<dynamic>();

    collections.forEach((element) {
      result.add(element.toJson());
    });

    return result;
  }
}
