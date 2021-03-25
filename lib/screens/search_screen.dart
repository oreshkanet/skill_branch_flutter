import 'package:FlutterGalleryApp/bloc/bloc.dart';
import 'package:FlutterGalleryApp/bloc/search_bloc.dart';
import 'package:FlutterGalleryApp/bloc/search_event.dart';
import 'package:FlutterGalleryApp/color_converter.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/services/unsplash_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart' as widgets;

class SearchScreen extends StatelessWidget {
  final _repository = UnsplashRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: BlocProvider(
        create: (context) => SearchBloc(repository: _repository),
        child: _SearchPhotoList(),
      ),
    );
  }
}

class _SearchPhotoList extends StatefulWidget {
  _SearchPhotoList({Key key}) : super(key: key);

  @override
  _SearchPhotoListState createState() => _SearchPhotoListState();
}

class _SearchPhotoListState extends State<_SearchPhotoList> {
  final _scrollController = ScrollController();

  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();

    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        _searchBloc.add(SearchLoadEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchEmptyState) {
          return Column(
            children: [
              SearchButtons(),
              Text("empty"),
            ],
          );
        } else if (state is SearchErrorState) {
          return Text("error");
        } else if (state is SearchLoadedState) {
          return _buildListView(context, state);
        } else if (state is SearchLoadingState) {
          return CircularProgressIndicator();
        } else {
          return Text("unknown");
        }
      },
    );
  }

  Widget _buildListView(BuildContext context, SearchLoadedState state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            height: 1.0,
            thickness: 1.0,
            indent: 1.0,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return index >= state.photoList.length
              ? _buildBottomLoader()
              : _buildItem(state.photoList[index]);
        },
        controller: _scrollController,
        itemCount: (state.currPage == state.maxPage)
            ? state.photoList.length
            : state.photoList.length + 1,
      ),
    );
  }

  Widget _buildBottomLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildItem(Photo photoItem) {
    final heroTag = 'feedItem_${photoItem.id}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/fullScreenImage',
              arguments: FullScreenImageArguments(
                routeSettings: RouteSettings(
                  arguments: 'Photo',
                ),
                heroTag: heroTag,
                photoItem: photoItem,
              ),
            );
          },
          child: Hero(
              tag: heroTag,
              child: widgets.Photo(
                photoLink: photoItem.urls.regular,
                placeholderColor: ColorConverter.decode(photoItem.color),
              )),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class SearchButtons extends StatelessWidget {
  SearchButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RaisedButton(
          child: Text('Search'),
          onPressed: () {
            searchBloc.add(SearchStartEvent(keyword: 'AI'));
          },
        ),
        SizedBox(width: 8.0),
        RaisedButton(
          child: Text('Cancel'),
          onPressed: () {
            SearchCancelEvent();
          },
        ),
      ],
    );
  }
}
