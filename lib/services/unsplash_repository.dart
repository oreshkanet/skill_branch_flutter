import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/services/samples_provider.dart';
import 'package:FlutterGalleryApp/services/unsplash_provider.dart';

class UnsplashRepository {
  // FIXME: Переписать Unsplashprovider на Dio
  //final UnsplashProvider _provider = UnsplashProvider();
  final SamplesProvider _provider = SamplesProvider();

  //ME

  Future<User> getMe() => _provider.getMe();

  // USER

  Future<User> getUser(String userName) => _provider.getUser(userName);

  Future<PhotoList> getUserPhotos(String userName, int perPage) =>
      _provider.getUserPhotos(userName, perPage);

  Future<PhotoList> getUserLikes(String userName, int perPage) =>
      _provider.getUserLikes(userName, perPage);

  Future<CollectionsList> getUserCollections(String userName, int perPage) =>
      _provider.getUserCollections(userName, perPage);

  // PHOTOS

  Future<PhotoList> getPhotos(int page, int perPage) =>
      _provider.getPhotos(page, perPage);

  Future<PhotoSearch> searchPhotos(String keyword, int page, int perPage) =>
      _provider.searchPhotos(keyword, page, perPage);

  Future<Photo> getPhoto(String photoId) => _provider.getPhoto(photoId);

  Future<Photo> getRandomPhoto() => _provider.getRandomPhoto();

  Future<PhotoList> getRandomPhotos(int count) =>
      _provider.getRandomPhotos(count);
}
