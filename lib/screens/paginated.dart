import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_apis/model/user_model.dart';
import 'package:flutter_rest_apis/screens/category_posts.dart';
import 'package:flutter_rest_apis/screens/category_search.dart';
import 'package:flutter_rest_apis/screens/detail_page.dart';
import 'package:flutter_rest_apis/screens/search.dart';
import 'package:flutter_rest_apis/services/user_service.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
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


class Paginated extends StatefulWidget {
  @override
  _PaginatedState createState() => _PaginatedState();
}

class _PaginatedState extends State<Paginated> {

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
          "https://alvin.nugsoftdemos.net/api/posts?page=$pageKey&limit=$_numberOfPostsPerRequest"));
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
      leading: Icon(Ionicons.disc_outline, color: Colors.teal),
      title: Text(
        'Blog App',
        style: TextStyle(
            color: Colors.teal, fontWeight: FontWeight.w800, fontSize: 22),
      ),
      actions: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                        builder: (context) =>  Jobs(),
                        fullscreenDialog: true
                    ),
                  );},
                child: Icon(Ionicons.search, color: Colors.teal)
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var timeNow = int.parse(DateFormat('kk').format(now));
    var message = '';
    if (timeNow <= 12) {
      message = 'Hello, Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      message = 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      message = 'Good Evening';
    } else {
      message = 'Good Night';

    }

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
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff061829),
                    borderRadius: BorderRadius.circular(00),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Explore Categories',
                        style: TextStyle(
                            color: Colors.white60, fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                              builder: (context) => CategoryPosts(),
                              fullscreenDialog: true
                          ),
                        ),
                        child: Text(
                          'View more',
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      )
                    ],
                  )
              ),
              Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 15),
                  child: FutureBuilder<List<Categories>>(
                    future: _func1,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
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
                                    height: 25,
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            width: 1, color: Colors.teal
                                        )
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
                                    height: 30,
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            width: 1, color: Colors.teal
                                        )
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
                                    height: 30,
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            width: 1, color: Colors.teal
                                        )
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
                                    height: 30,
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            width: 1, color: Colors.teal
                                        )
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
                                    height: 30,
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            width: 1, color: Colors.teal
                                        )
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
                                    height: 30,
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            width: 1, color: Colors.teal
                                        )
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
                                    height: 30,
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            width: 1, color: Colors.teal
                                        )
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
                                    height: 30,
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            width: 1, color: Colors.teal
                                        )
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
                                    height: 30,
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            width: 1, color: Colors.teal
                                        )
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
                                    height: 30,
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            width: 1, color: Colors.teal
                                        )
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
                        return ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 30,
                              width: 80,
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(40),
                              ),
                            );
                          },
                        );
                      }
                      return ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 30,
                            width: 80,
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(40),
                            ),
                          );
                        },
                      );
                    },
                  )
              ),
              Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xff061829),
                      borderRadius: BorderRadius.circular(00),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Headlines for you',
                          style: TextStyle(
                              color: Colors.white60, fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                      ],
                    )
                ),
              ),
              Expanded(
                flex: 8,
                child: PagedListView<int, PostModel>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<PostModel>(
                      itemBuilder: (context, item, index) {
                        var data = item;
                        return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (context) => DetailPage(
                                    data: data,
                                  ),
                                  fullscreenDialog: true
                              ),
                            ),
                            child: Container(
                              height: 130, width: double.infinity,
                              margin: EdgeInsets.only(left:10, right: 10, bottom: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(00),
                                  color: Colors.transparent
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 130,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white12
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Ionicons.image_outline, color: Colors.white54, size: 30)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 130,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                image: NetworkImage('${data.images[index].imgUrl}'),
                                                fit: BoxFit.cover,
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                                            child: Text(
                                              data.postTitle,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
                                            )
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.access_time_outlined, color: Colors.white54, size: 14),
                                                SizedBox(width: 5),
                                                Text(
                                                  data.updatedAt,
                                                  style: TextStyle(
                                                      color: Colors.white54, fontWeight: FontWeight.w500, fontSize: 13),
                                                )
                                              ],
                                            ),
                                            SizedBox(width: 15),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Ionicons.chatbubble_outline, color: Colors.blueAccent, size: 14,),
                                                SizedBox(width: 5),
                                                Text(
                                                  '${data.comments.length.toString()}',
                                                  style: TextStyle(
                                                      color: Colors.blueAccent, fontWeight: FontWeight.w400, fontSize: 13),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                        );
                      }
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


