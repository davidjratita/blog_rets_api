import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rest_apis/model/user_model.dart';
import 'package:flutter_rest_apis/screens/detail_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Category2 extends StatefulWidget {
  const Category2({Key key}) : super(key: key);

  @override
  State<Category2> createState() => _Category2State();
}

class _Category2State extends State<Category2> {
  final _numberOfPostsPerRequest =10;
  final PagingController<int, PostModel> _pagingController = PagingController(firstPageKey: 1);
  bool _showBackToTopButton = false;
  ScrollController _scrollController;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
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
          "https://alvin.nugsoftdemos.net/api/categories/2/posts?page=$pageKey&limit=$_numberOfPostsPerRequest"));
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
        'Selected Category',
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
                                              data.category.category,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.teal, fontWeight: FontWeight.w400, fontSize: 17),
                                            )
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                                            child: Text(
                                              data.postTitle,
                                              maxLines: 2,
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


