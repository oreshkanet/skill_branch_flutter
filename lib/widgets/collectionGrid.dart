import 'package:FlutterGalleryApp/bloc/bloc.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/screens/collection_screen.dart';
import 'package:FlutterGalleryApp/widgets/photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionsGridWidget extends StatefulWidget {
  CollectionsGridWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CollectionsGridWidgetState();
  }
}

class _CollectionsGridWidgetState extends State<CollectionsGridWidget> {
  CollectionsListBloc _collectionsListBloc;

  @override
  void initState() {
    super.initState();

    _collectionsListBloc = BlocProvider.of<CollectionsListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionsListBloc, CollectionsListState>(
      builder: (context, state) {
        if (state is EmptyCollectionsListState) {
          return _buildEmptyCollectionsList();
        } else if (state is LoadingCollectionsListState) {
          return _buildLoadingCollectionsList();
        } else if (state is LoadedCollectionsListState) {
          return _buildCollectionsList(state.collectionsList);
        } else if (state is ErrorCollectionsListState) {
          return _buildEmptyCollectionsList(); //(state.errorText);
        } else {
          return _buildEmptyCollectionsList();
        }
      },
    );
  }

  _buildEmptyCollectionsList() {
    return Center(
      child: Text("Empty"),
    );
  }

  _buildLoadingCollectionsList() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildCollectionsList(CollectionsList collectionsList) {
    return Center(
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(10.0),
        children: List.generate(
          collectionsList.collections.length,
          (index) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/collection',
                arguments: CollectionScreenArguments(
                  routeSettings: RouteSettings(
                    arguments: 'Collection',
                  ),
                  collectionId: collectionsList.collections[index].id,
                ),
              );
            },
            child: PhotoWidget(
              photoLink:
                  collectionsList.collections[index].coverPhoto.urls.small,
              paddingHorizontal: 0.0,
              paddingVertical: 0.0,
              isRect: true,
            ),
          ),
        ),
      ),
    );
  }
}
