import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_apis/model/user_model.dart';
import 'package:flutter_rest_apis/screens/search.dart';
import 'package:flutter_rest_apis/services/user_service.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_rest_apis/category/category1.dart';
import 'package:flutter_rest_apis/category/category10.dart';
import 'package:flutter_rest_apis/category/category2.dart';
import 'package:flutter_rest_apis/category/category3.dart';
import 'package:flutter_rest_apis/category/category4.dart';
import 'package:flutter_rest_apis/category/category5.dart';
import 'package:flutter_rest_apis/category/category6.dart';
import 'package:flutter_rest_apis/category/category7.dart';
import 'package:flutter_rest_apis/category/category8.dart';
import 'package:flutter_rest_apis/category/category9.dart';


class CategoryPosts extends StatefulWidget {
  CategoryPosts({Key key,  this.categoryId}) : super(key: key);

  PostModel categoryId;
  int index;

  @override
  _CategoryPostsState createState() => _CategoryPostsState();
}

class _CategoryPostsState extends State<CategoryPosts> {

  final _numberOfPostsPerRequest = 25;
  final PagingController<int, PostModel> _pagingController = PagingController(firstPageKey: 1);
  bool _showBackToTopButton = false;
  ScrollController _scrollController;
  Future<List<Categories>> _func1;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _func1 = ApiService().getCategories();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  Future<List<PostModel>> _fetchPage(int pageKey) async {
    try {
      final response = await get(Uri.parse(
          "https://alvin.nugsoftdemos.net/api/ctegories/1/posts?page=$pageKey&limit=$_numberOfPostsPerRequest"));
      List responseList = json.decode(response.body)['data'];
      List postList = responseList.map(((e) => PostModel.fromJson(e))).toList();
      final isLastPage = postList.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(postList);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(postList, nextPageKey);
      }
    } catch (e) {
      print("error --> $e");
      _pagingController.error = e;
    }
  }

  SliverAppBar showSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Color(0xff061829),
      floating: false,
      pinned: true,
      snap: false,
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: true,
      title: Text(
        'More Categories',
        style: TextStyle(
            color: Colors.teal, fontWeight: FontWeight.w800, fontSize: 22),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward, color: Colors.white),
        mini: true,
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Color(0xff061829),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              showSliverAppBar(),

            ];
          },
          body: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<Categories>>(
                  future: _func1,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var data = snapshot.data[index];
                          if (data.categoryId == 1) {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) => Category1(),
                                      fullscreenDialog: true
                                  ),
                                ),
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white12,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.category,
                                        style: TextStyle(
                                            color: Colors.teal, fontWeight: FontWeight.w500, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }
                          else if (data.categoryId == 2) {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) => Category2(),
                                      fullscreenDialog: true
                                  ),
                                ),
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.category,
                                        style: TextStyle(
                                            color: Colors.teal, fontWeight: FontWeight.w500, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }
                          else if (data.categoryId == 3) {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) => Category3(),
                                      fullscreenDialog: true
                                  ),
                                ),
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.category,
                                        style: TextStyle(
                                            color: Colors.teal, fontWeight: FontWeight.w500, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }
                          else if (data.categoryId == 4) {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) => Category4(),
                                      fullscreenDialog: true
                                  ),
                                ),
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.category,
                                        style: TextStyle(
                                            color: Colors.teal, fontWeight: FontWeight.w500, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }
                          else if (data.categoryId == 5) {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) => Category5(),
                                      fullscreenDialog: true
                                  ),
                                ),
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.category,
                                        style: TextStyle(
                                            color: Colors.teal, fontWeight: FontWeight.w500, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }
                          else if (data.categoryId == 6) {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) => Category6(),
                                      fullscreenDialog: true
                                  ),
                                ),
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.category,
                                        style: TextStyle(
                                            color: Colors.teal, fontWeight: FontWeight.w500, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }
                          else if (data.categoryId == 7) {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) => Category7(),
                                      fullscreenDialog: true
                                  ),
                                ),
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.category,
                                        style: TextStyle(
                                            color: Colors.teal, fontWeight: FontWeight.w500, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }
                          else if (data.categoryId == 8) {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) => Category8(),
                                      fullscreenDialog: true
                                  ),
                                ),
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.category,
                                        style: TextStyle(
                                            color: Colors.teal, fontWeight: FontWeight.w500, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }
                          else if (data.categoryId == 9) {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) => Category9(),
                                      fullscreenDialog: true
                                  ),
                                ),
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.category,
                                        style: TextStyle(
                                            color: Colors.teal, fontWeight: FontWeight.w500, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }
                          else if (data.categoryId == 10) {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) => Category10(),
                                      fullscreenDialog: true
                                  ),
                                ),
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.category,
                                        style: TextStyle(
                                            color: Colors.teal, fontWeight: FontWeight.w500, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.error,
                            style: TextStyle(
                                color: Colors.white60, fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator()
                      ],
                    );
                  },
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
