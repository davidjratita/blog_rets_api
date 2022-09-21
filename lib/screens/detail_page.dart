import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rest_apis/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_apis/screens/comments_page.dart';
import 'package:ionicons/ionicons.dart';

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class DetailPage extends StatelessWidget {

  DetailPage({Key key,  this.data}) : super(key: key);
  PostModel data;
  int index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff061829),
          automaticallyImplyLeading: true,
          title: Text('Details'),
          centerTitle: true,
          actions: [
          ],
        ),
        backgroundColor: Color(0xff061829),
        body: Column(
          children: [
            Expanded(
                flex: 8,
                child: ListView(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Text(
                          data.postTitle,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.access_time_outlined, color: Colors.blueAccent),
                                ],
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${data.updatedAt}',
                              style: TextStyle(
                                  color: Colors.white54, fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: 10),
                    CarouselSlider.builder(
                      options: CarouselOptions(
                          height: 250.0,
                          scrollDirection: Axis.horizontal,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 2),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn
                      ),
                      itemCount: data.images.length,
                      itemBuilder: (BuildContext context, index, int pageViewIndex) =>
                          Container(
                            height: 250,
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage('${data.images[index].imgUrl}'),
                                  fit: BoxFit.cover,
                                )

                            ),
                          ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(
                          data.postBody,
                          style: TextStyle(
                              color: Colors.white60, fontWeight: FontWeight.w400, fontSize: 15),
                        )
                    ),
                    SizedBox(height: 10),
                  ],
                )
            ),
            Expanded(
                flex: 1,
                child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 15),
                    child: ListView.builder(
                      itemCount: data.tags.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 30,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              Text(
                                data.tags[index].tag,
                                style: TextStyle(
                                    color: Colors.teal, fontWeight: FontWeight.w400, fontSize: 15),
                              )
                            ],
                          ),
                        );
                      },
                    )
                )
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => CommentsPage(data: data),
                                    fullscreenDialog: true
                                ),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Ionicons.chatbox_ellipses_outline, color: Colors.blueAccent),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${data.comments.length.toString()} comments',
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontWeight: FontWeight.w500, fontSize: 15),
                                )

                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Category : ${data.category.category}',
                                style: TextStyle(
                                    color: Colors.white54, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 5),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: '${data.category.color}'.toColor(),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
            )
          ],
        )
      ),
    );
  }
}
