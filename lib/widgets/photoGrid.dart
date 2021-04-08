import 'package:FlutterGalleryApp/bloc/bloc.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/widgets/photo.dart';
import 'package:FlutterGalleryApp/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoGridWidget extends StatefulWidget {
  PhotoGridWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PhotoGridWidgetState();
  }
}

class _PhotoGridWidgetState extends State<PhotoGridWidget> {
  PhotoListBloc _photoListBloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _photoListBloc = BlocProvider.of<PhotoListBloc>(context);
    /*
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        _photoListBloc.add(LoadMorePhotoListEvent());
      }
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoListBloc, PhotoListState>(
      builder: (context, state) {
        if (state is EmptyPhotoListState) {
          return _buildEmptyPhotoList();
        } else if (state is LoadingPhotoListState) {
          return _buildLoadingPhotoList();
        } else if (state is LoadedPhotoListState) {
          return _buildPhotoList(state);
        } else if (state is ErrorPhotoListState) {
          return _buildEmptyPhotoList(); //(state.errorText);
        } else {
          return _buildEmptyPhotoList();
        }
      },
    );
  }

  _buildEmptyPhotoList() {
    return Center(
      child: Text("Empty"),
    );
  }

  _buildLoadingPhotoList() {
    return Center(child: ProgressIndicatorWidget());
  }

  _buildPhotoList(LoadedPhotoListState state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index < state.photoList.photos.length) {
              return _buildPhotoListItem(state.photoList.photos[index]);
            } else {
              _photoListBloc.add(LoadMorePhotoListEvent());
              return _buildPhotoListProgressIndicator();
            }
          },
          controller: _scrollController,
          itemCount: state.lastPage
              ? state.photoList.photos.length
              : state.photoList.photos.length + 1,
        ),
      ),
    );
  }

  _buildPhotoListItem(Photo photo) {
    final heroTag = 'photoGrid_${photo.id}';
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/photoScreen',
          arguments: PhotoScreenArguments(
            routeSettings: RouteSettings(
              arguments: 'Photo',
            ),
            heroTag: heroTag,
            photoItem: photo,
          ),
        );
      },
      child: Hero(
        tag: heroTag,
        child: PhotoWidget(
          photoLink: photo.urls.small,
          paddingHorizontal: 0.0,
          paddingVertical: 0.0,
          isRect: true,
        ),
      ),
    );
  }

  _buildPhotoListProgressIndicator() {
    return Center(
      child: ProgressIndicatorWidget(),
    );
  }
}
