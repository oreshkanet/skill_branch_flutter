import 'package:FlutterGalleryApp/models/photo_list/model.dart';
import 'package:FlutterGalleryApp/services/unsplash_provider.dart';

class UnsplashRepository {
  // FIXME: Переписать Unsplashprovider на Dio
  UnsplashProvider _unsplashProvider = UnsplashProvider();

  Future<PhotoList> searchPhotos(String keyword, int page, int perPage) =>
      UnsplashProvider.searchPhotos(keyword, page, perPage);
}
