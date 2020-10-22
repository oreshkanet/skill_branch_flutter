import 'package:FlutterGalleryApp/screens/home.dart';
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
        ),
        home: Home());
  }
}
