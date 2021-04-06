import 'package:FlutterGalleryApp/bloc/bloc.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/widgets/photo.dart';
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

  @override
  void initState() {
    super.initState();

    _photoListBloc = BlocProvider.of<PhotoListBloc>(context);
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
          return _buildPhotoList(state.photoList);
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
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildPhotoList(PhotoList photoList) {
    return Center(
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(10.0),
        children: List.generate(
          photoList.photos.length,
          (index) => PhotoWidget(
            photoLink: photoList.photos[index].urls.small,
            paddingHorizontal: 0.0,
            paddingVertical: 0.0,
            isRect: true,
          ),
        ),
      ),
    );
  }
}

class PhotoGridWidgetOld extends StatelessWidget {
  const PhotoGridWidgetOld({
    this.photoList,
    Key key,
  }) : super(key: key);

  final PhotoList photoList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(10.0),
        children: List.generate(
          photoList.photos.length,
          (index) => PhotoWidget(
            photoLink: photoList.photos[index].urls.small,
            paddingHorizontal: 0.0,
            paddingVertical: 0.0,
            isRect: true,
          ),
        ),
      ),
    );
  }
}
