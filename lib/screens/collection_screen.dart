import 'package:FlutterGalleryApp/bloc/bloc.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionScreenArguments {
  CollectionScreenArguments({
    this.routeSettings,
    this.collectionId,
  });
  final RouteSettings routeSettings;
  final String collectionId;
}

class CollectionScreen extends StatelessWidget {
  CollectionScreen({
    this.collectionId,
  });

  final String collectionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocProvider(
        create: (context) {
          final PhotoListBloc _photoListBloc = PhotoListBloc();
          _photoListBloc.add(
            LoadCollectionPhotoListEvent(
              collectionId: collectionId,
              perPage: 18,
            ),
          );
          return _photoListBloc;
        }, //SearchBloc(repository: _repository),
        child: PhotoGridWidget(),
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
        "Collection",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
