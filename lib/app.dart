import 'dart:io';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/collection_screen.dart';
import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/screens/user_profile_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String kFlutterDash =
    'https://248006.selcdn.ru/main/iblock/6f8/6f895fcf6ade1b0b20209ebe73ee72ea/b3b9ff725eb73759e796e743433df535.png.webp';

class MyApp extends StatelessWidget {
  bool isNice = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: buildAppTextTheme(),
      ),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/fullScreenImage') {
          FullScreenImageArguments args =
              settings.arguments as FullScreenImageArguments;
          final route = FullScreenImage(
            heroTag: args.heroTag,
            photoItem: args.photoItem,
            key: args.key,
          );
          if (Platform.isAndroid) {
            return MaterialPageRoute(
                builder: (context) => route, settings: args.routeSettings);
          } else if (Platform.isIOS) {
            return CupertinoPageRoute(
                builder: (context) => route, settings: args.routeSettings);
          }
        } else if (settings.name == '/userProfile') {
          UserProfileScreenArguments args =
              settings.arguments as UserProfileScreenArguments;
          final route = UserProfileScreen(
            heroTag: args.heroTag,
            userName: args.userName,
          );
          if (Platform.isAndroid) {
            return MaterialPageRoute(
                builder: (context) => route, settings: args.routeSettings);
          } else if (Platform.isIOS) {
            return CupertinoPageRoute(
                builder: (context) => route, settings: args.routeSettings);
          }
        } else if (settings.name == '/collection') {
          CollectionScreenArguments args =
              settings.arguments as CollectionScreenArguments;
          final route = CollectionScreen(
            collectionId: args.collectionId,
          );
          if (Platform.isAndroid) {
            return MaterialPageRoute(
                builder: (context) => route, settings: args.routeSettings);
          } else if (Platform.isIOS) {
            return CupertinoPageRoute(
                builder: (context) => route, settings: args.routeSettings);
          }
        }
      },
      home: Home(Connectivity().onConnectivityChanged),
    );
  }
}

class ConnectivityOverlay {
  static final ConnectivityOverlay _singleton = ConnectivityOverlay._internal();

  factory ConnectivityOverlay() {
    return _singleton;
  }

  ConnectivityOverlay._internal();

  static OverlayEntry overlayEntry;

  void showOverlay(BuildContext context, Widget child) {
    if (ConnectivityOverlay.overlayEntry != null) {
      return;
    }
    ConnectivityOverlay.overlayEntry =
        OverlayEntry(builder: (BuildContext context) {
      return Positioned(
        top: MediaQuery.of(context).viewInsets.top + 50,
        child: Material(
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              decoration: BoxDecoration(
                color: AppColors.mercury,
                borderRadius: BorderRadius.circular(12),
              ),
              child: child,
            ),
          ),
        ),
      );
    });
    Overlay.of(context).insert(overlayEntry);
  }

  void removeOverlay(BuildContext context) {
    ConnectivityOverlay.overlayEntry.remove();
    ConnectivityOverlay.overlayEntry = null;
  }
}
