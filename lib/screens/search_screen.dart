import 'package:FlutterGalleryApp/bloc/bloc.dart';
import 'package:FlutterGalleryApp/color_converter.dart';
import 'package:FlutterGalleryApp/models/models.dart';
import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/services/unsplash_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart' as widgets;

class SearchScreen extends StatelessWidget {
  //final _repository = UnsplashRepository();
  SearchBloc _searchBloc;

  @override
  Widget build(BuildContext context) {
    _searchBloc = SearchBloc();
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocProvider(
        create: (context) => _searchBloc, //SearchBloc(repository: _repository),
        child: _SearchPhotoList(),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          style: TextStyle(fontSize: 17),
          decoration: InputDecoration(
            hintText: "Search",
            prefixIcon: Center(
              child: Icon(
                Icons.search,
                color: AppColors.textGray1,
              ),
            ),
            prefixIconConstraints:
                BoxConstraints(maxHeight: 32, minHeight: 32, maxWidth: 32),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                style: BorderStyle.none,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                style: BorderStyle.none,
              ),
            ),
            fillColor: AppColors.grayButton,
            filled: true,
          ),
          autofocus: false,
          onSubmitted: (text) => _searchBloc.add(
            SearchStartEvent(keyword: text, perPage: 30),
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      centerTitle: true,
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
    /*
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        _searchBloc.add(SearchLoadEvent());
      }
    });
    */
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
          return Center(child: Text("empty"));
        } else if (state is SearchErrorState) {
          return Center(child: Text("empty"));
        } else if (state is SearchLoadedState) {
          return _buildListView(context, state);
        } else if (state is SearchLoadingState) {
          return Center(child: widgets.ProgressIndicatorWidget());
        } else {
          return Center(child: Text("empty"));
        }
      },
    );
  }

  Widget _buildListView(BuildContext context, SearchLoadedState state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var indexPhoto = index * 3;
          if (index < (state.photoList.length ~/ 3)) {
            if ((index + 1) % 3 == 0) {
              return _buildRow12(
                state.photoList[indexPhoto],
                state.photoList[indexPhoto + 1],
                state.photoList[indexPhoto + 2],
              );
            } else if ((index + 1) % 2 == 0) {
              return _buildRow21(
                state.photoList[indexPhoto],
                state.photoList[indexPhoto + 1],
                state.photoList[indexPhoto + 2],
              );
            } else {
              return _buildRow111(
                state.photoList[indexPhoto],
                state.photoList[indexPhoto + 1],
                state.photoList[indexPhoto + 2],
              );
            }
          } else {
            return _buildBottomLoader();
          }
        },
        controller: _scrollController,
        itemCount: (state.currPage == state.maxPage)
            ? (state.photoList.length ~/ 3)
            : (state.photoList.length ~/ 3) + 1,
      ),
    );
  }

  Widget _buildBottomLoader() {
    return Center(child: widgets.ProgressIndicatorWidget());
  }

  Widget _buildRow111(Photo photoItem1, Photo photoItem2, Photo photoItem3) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: _buildItem(photoItem1),
            flex: 1,
          ),
          Expanded(
            child: _buildItem(photoItem2),
            flex: 1,
          ),
          Expanded(
            child: _buildItem(photoItem3),
            flex: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildRow12(Photo photoItem1, Photo photoItem2, Photo photoItem3) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _buildItem(photoItem1),
            flex: 2,
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  _buildItem(photoItem2),
                  _buildItem(photoItem3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow21(Photo photoItem1, Photo photoItem2, Photo photoItem3) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                _buildItem(photoItem1),
                _buildItem(photoItem2),
              ],
            ),
          ),
          Expanded(
            child: _buildItem(photoItem3),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildItem(Photo photoItem) {
    final heroTag = 'feedItem_${photoItem.id}';

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
            photoItem: photoItem,
          ),
        );
      },
      child: Hero(
          tag: heroTag,
          child: widgets.PhotoWidget(
            paddingHorizontal: 5,
            paddingVertical: 5,
            isRect: true,
            photoLink: photoItem.urls.regular,
            placeholderColor: ColorConverter.decode(photoItem.color),
          )),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
