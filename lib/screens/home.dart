import 'dart:async';

import 'package:FlutterGalleryApp/res/bottom_nav_icons_icons.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/feed_screen.dart';
import 'package:FlutterGalleryApp/screens/login_screen.dart';
import 'package:FlutterGalleryApp/screens/profile_screen.dart';
import 'package:FlutterGalleryApp/screens/search_screen.dart';
import 'package:FlutterGalleryApp/services/unsplash_repository.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/app.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart' as widgets;

class HomeScreenArguments {
  HomeScreenArguments({
    this.onConnectivityChanged,
    this.key,
  });

  final Stream<ConnectivityResult> onConnectivityChanged;
  final Key key;
}

class Home extends StatefulWidget {
  Home(this.onConnectivityChanged);

  final Stream<ConnectivityResult> onConnectivityChanged;

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription subscription;

  int currentTab = 0;
  List<Widget> padges;

  @override
  void initState() {
    super.initState();

    padges = <Widget>[
      _buildLogin(),
      _buildLogin(),
      _buildLogin(),
    ];

    subscription = widget.onConnectivityChanged.listen(
      (ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.wifi:
            {
              ConnectivityOverlay().removeOverlay(context);
              break;
            }
          case ConnectivityResult.mobile:
            {
              ConnectivityOverlay().removeOverlay(context);
              break;
            }
          case ConnectivityResult.none:
            {
              ConnectivityOverlay()
                  .showOverlay(context, Text('No internet connection'));
              break;
            }
        }
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (UnsplashRepository().isLogged()) {
      padges = [
        Feed(),
        SearchScreen(),
        ProfileScreen(),
      ];
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            padges[currentTab],
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavyBar(
                backgroundColor: Colors.white,
                curve: Curves.ease,
                showElevation: true,
                currentTab: currentTab,
                onItemSelected: (index) => setState(() {
                  currentTab = index;
                }),
                items: [
                  BottomNavyBarItem(
                    asset: BottomNavIcons.home,
                    title: Text('Home'),
                    activeColor: AppColors.dodgerBlue,
                    inactiveColor: AppColors.manatee,
                  ),
                  BottomNavyBarItem(
                    asset: BottomNavIcons.search,
                    title: Text('Search'),
                    activeColor: AppColors.dodgerBlue,
                    inactiveColor: AppColors.manatee,
                  ),
                  BottomNavyBarItem(
                    asset: BottomNavIcons.profile,
                    title: Text('Profile'),
                    activeColor: AppColors.dodgerBlue,
                    inactiveColor: AppColors.manatee,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogin() {
    return Center(
      child: widgets.ButtonWidget(
        text: "Login",
        onTap: () {
          Navigator.pushNamed(
            context,
            '/login',
            arguments: LoginScreenArguments(
              routeSettings: RouteSettings(),
            ),
          );
        },
      ),
    );
  }
}

class BottomNavyBar extends StatelessWidget {
  BottomNavyBar({
    Key key,
    this.backgroundColor = Colors.transparent,
    this.showElevation = true,
    this.containerHeight = 56,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.items,
    this.onItemSelected,
    this.currentTab,
    this.animationDuration = const Duration(milliseconds: 200),
    this.itemCornerRadius = 24,
    this.curve,
  }) : super(key: key);

  final Color backgroundColor;
  final bool showElevation;
  final double containerHeight;
  final MainAxisAlignment mainAxisAlignment;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final int currentTab;
  final Duration animationDuration;
  final double itemCornerRadius;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          if (showElevation)
            BoxShadow(color: backgroundColor, blurRadius: 3, spreadRadius: 3),
          if (showElevation)
            BoxShadow(color: backgroundColor, blurRadius: 25, spreadRadius: 5),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);

              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  isSelected: currentTab == index,
                  item: item,
                  backgroundColor: backgroundColor,
                  animationDuration: animationDuration,
                  itemCornerRadius: itemCornerRadius,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  _ItemWidget(
      {@required this.isSelected,
      @required this.item,
      @required this.backgroundColor,
      @required this.animationDuration,
      this.curve = Curves.linear,
      @required this.itemCornerRadius})
      : assert(animationDuration != null, 'animationDuration is null'),
        assert(curve != null, 'curve is null'),
        assert(isSelected != null, 'isSelected is null'),
        assert(item != null, 'item is null'),
        assert(backgroundColor != null, 'backgroundColor is null'),
        assert(itemCornerRadius != null, 'itemCornerRadius is null');

  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve curve;
  final double itemCornerRadius;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      width: (MediaQuery.of(context).size.width - 8 * 3 - 3 * 2) / 3,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      curve: curve,
      child: Column(
        children: <Widget>[
          Icon(
            item.asset,
            size: 20,
            color: isSelected ? item.activeColor : item.inactiveColor,
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: DefaultTextStyle.merge(
                child: item.title,
                textAlign: item.textAlign,
                maxLines: 1,
                style: AppStyles.h6.copyWith(
                  color: isSelected ? item.activeColor : item.inactiveColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem(
      {this.asset,
      this.title,
      this.activeColor,
      this.inactiveColor,
      this.textAlign}) {
    assert(asset != null, 'Asset is null');
    assert(title != null, 'Title is null');
  }

  final IconData asset;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;
}
