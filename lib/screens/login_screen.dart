import 'dart:async';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/services/unsplash_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreenArguments {
  LoginScreenArguments({
    this.key,
    this.routeSettings,
  });

  final Key key;
  final RouteSettings routeSettings;
}

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: Builder(
        builder: _buildWebView,
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: AppColors.grayChateau,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: AppColors.white,
      centerTitle: true,
      title: Text(
        "Login",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget _buildWebView(BuildContext context) {
    return WebView(
      initialUrl: UnsplashRepository().getLoginUrl(),
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: <JavascriptChannel>[
        _toasterJavascriptChannel(context),
      ].toSet(),
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onPageStarted: (String url) async {
        if (url.contains('https://unsplash.com/oauth/authorize/native?code=')) {
          _doLogin(context, url);
        }
      },
      onPageFinished: (String url) {
        if (url.contains('https://unsplash.com/oauth/authorize/native?code=')) {
          _doLogin(context, url);
        }
      },
      gestureNavigationEnabled: true,
    );
  }

  _doLogin(BuildContext context, String url) async {
    try {
      await UnsplashRepository().doLogin(oneTimeCode: url);
    } catch (_) {
      // TODO вывести popup?
      return;
    }
    Navigator.pop(context);
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Print',
        onMessageReceived: (JavascriptMessage message) {
          print(message);
        });
  }
}
