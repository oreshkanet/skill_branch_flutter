import 'dart:convert';

import 'package:FlutterGalleryApp/models/models.dart';
import 'package:http/http.dart' as http;

/*
 async {
  const url = "$baseUrl/api/v1/login";
  var response = await http.post(url, body: {
    'user': '$username',
    'password': '$pwd',
  });
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return Login.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
*/

class UnsplashProvider {
  static const String _appId = "184537"; //not used, just for info
  static String authToken =
      "H5KSJVe71H16Rn8ZIaeBUy8KVn3pjKhTTAjAhwduaXc"; //"NiAm1niaD6t0uNrInTGR27UmSXSMvDNAluvb52SqT3U";
  static const String _accessKey =
      'uYpsEMuU_nKS3PsUYbTpYZQbvR8Rdma3IbTQR7k0o8w'; //app access key from console
  static const String _secretKey =
      'iQ14YRenJXs9jbNAn632iW-dRPOuRPxRAYnEfwqWEes'; //app secrey key from console
  static const String authUrl =
      'https://unsplash.com/oauth/authorize?client_id=$_accessKey&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=public+write_likes'; //authorize url from https://unsplash.com/oauth/applications/{your_app_id}

  static Future<Auth> doLogin({String oneTimeCode}) async {
    var response = await http.post('https://unsplash.com/oauth/token',
        headers: {
          'Content-Type': 'application/json',
        },
        body:
            '{"client_id":"$_accessKey","client_secret":"$_secretKey","redirect_uri":"urn:ietf:wg:oauth:2.0:oob","code":"$oneTimeCode","grant_type":"authorization_code"}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Auth.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Future<PhotoList> getPhotos(int page, int perPage) async {
    var response = await http.get(
        'https://api.unsplash.com/photos?page=$page&per_page=$perPage',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return PhotoList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Future<PhotoSearch> searchPhotos(
      String keyword, int page, int perPage) async {
    var response = await http.get(
        'https://api.unsplash.com/search/photos?query=$keyword&page=$page&per_page=$perPage',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return PhotoSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Future<Photo> getPhoto(String photoId) async {
    var response = await http.get('https://api.unsplash.com/photos/$photoId',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Photo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<Photo> getRandomPhoto() async {
    var response = await http.get('https://api.unsplash.com/photos/random?=1',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Photo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<PhotoList> getRandomPhotos(int count) async {
    var response = await http.get(
        'https://api.unsplash.com/photos/random?=$count',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return PhotoList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<bool> likePhoto(String photoId) async {
    var response = await http
        .post('https://api.unsplash.com/photos/$photoId/like', headers: {
      'Authorization': 'Bearer $authToken',
    });

    print(response.body);
    print(response.reasonPhrase);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true; //returns 201 - Created
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<bool> unlikePhoto(String photoId) async {
    var response = await http
        .delete('https://api.unsplash.com/photos/$photoId/like', headers: {
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true; //returns 201 - Created
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}
