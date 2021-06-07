import 'package:FlutterGalleryApp/models/photo.dart';

class PhotoSearch {
  int total;
  int totalPages;
  List<Photo> results;

  PhotoSearch({this.total, this.totalPages, this.results});

  PhotoSearch.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = new List<Photo>();
      json['results'].forEach((v) {
        results.add(new Photo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
