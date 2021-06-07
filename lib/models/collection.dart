import 'package:FlutterGalleryApp/models/common.dart';
import 'package:FlutterGalleryApp/models/models.dart';

class Collection {
  String id;
  String title;
  String description;
  String publishedAt;
  String lastCollectedAt;
  String updatedAt;
  bool curated;
  bool featured;
  int totalPhotos;
  bool private;
  String shareKey;
  Links links;
  User user;
  Photo coverPhoto;
  List<Photo> previewPhotos;

  Collection(
      {this.id,
      this.title,
      this.description,
      this.publishedAt,
      this.lastCollectedAt,
      this.updatedAt,
      this.curated,
      this.featured,
      this.totalPhotos,
      this.private,
      this.shareKey,
      this.links,
      this.user,
      this.coverPhoto,
      this.previewPhotos});

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    publishedAt = json['published_at'];
    lastCollectedAt = json['last_collected_at'];
    updatedAt = json['updated_at'];
    curated = json['curated'];
    featured = json['featured'];
    totalPhotos = json['total_photos'];
    private = json['private'];
    shareKey = json['share_key'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    coverPhoto = json['cover_photo'] != null
        ? new Photo.fromJson(json['cover_photo'])
        : null;
    if (json['preview_photos'] != null) {
      previewPhotos = new List<Photo>();
      json['preview_photos'].forEach((v) {
        previewPhotos.add(new Photo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['published_at'] = this.publishedAt;
    data['last_collected_at'] = this.lastCollectedAt;
    data['updated_at'] = this.updatedAt;
    data['curated'] = this.curated;
    data['featured'] = this.featured;
    data['total_photos'] = this.totalPhotos;
    data['private'] = this.private;
    data['share_key'] = this.shareKey;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.coverPhoto != null) {
      data['cover_photo'] = this.coverPhoto.toJson();
    }
    if (this.previewPhotos != null) {
      data['preview_photos'] =
          this.previewPhotos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
