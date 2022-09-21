//declare packages
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_apis/model/user_model.dart';
import 'package:flutter_rest_apis/screens/detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';



class CategoryPage extends StatefulWidget {
  CategoryPage() : super();

  @override
  CategoryPageState createState() => CategoryPageState();
}

class Debouncer {
  int milliseconds;
  VoidCallback action;
  Timer timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}


class CategoryPageState extends State<CategoryPage> {

  bool _Loading = false;

  final _debouncer = Debouncer();

  List<PostModel> ulist = [];
  List<PostModel> userLists = [];

  String url = 'https://alvin.nugsoftdemos.net/api/posts';

  Future<List<PostModel>> getAllulistList() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.body);
        List<PostModel> list = parseAgents(response.body);
        return list;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<PostModel> parseAgents(String responseBody) {
    final parsed = json.decode(responseBody)['data'].cast<Map<String, dynamic>>();
    return parsed.map<PostModel>((json) => PostModel.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _initialize();
    });
    getAllulistList().then((subjectFromServer) {
      setState(() {
        ulist = subjectFromServer;
        userLists = ulist;
      });
    });
  }

  void _initialize() {
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) { // Check that the widget is still mounted
        setState(() {
          _Loading = true;
        });
      }
    });
  }

  //Main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff061829),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff061829),
        automaticallyImplyLeading: true,
        title: Text('Search', style: TextStyle(
            color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 15
        )),
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              textInputAction: TextInputAction.search,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusColor: Colors.teal,
                focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                filled: true,
                fillColor: Colors.white12,
                suffixIcon: InkWell(
                  child: Icon(Ionicons.search, color: Colors.teal),
                ),
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Search based on category',
                hintStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17
                ),
              ),
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    userLists = ulist
                        .where(
                          (u) => (
                          u.category.category.contains(string.toLowerCase())
                      ),
                    ).toList();
                  });
                });
              },
            ),
          ),
          Expanded(
            child: !_Loading ? Center(
                child: const CircularProgressIndicator()
            ) :
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.all(5),
              itemCount: userLists.length,
              itemBuilder: (BuildContext context, int index) {
                var data = userLists[index];
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
                                      image: NetworkImage('${userLists[index].images[index].imgUrl}'),
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
                                    userLists[index].postTitle,
                                    maxLines: 1,
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
                                        userLists[index].updatedAt,
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
                                      Icon(Ionicons.chatbubble_outline, color: Colors.white54, size: 14,),
                                      SizedBox(width: 5),
                                      Text(
                                        '${userLists[index].comments.length.toString()}',
                                        style: TextStyle(
                                            color: Colors.white54, fontWeight: FontWeight.w400, fontSize: 13),
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}


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
