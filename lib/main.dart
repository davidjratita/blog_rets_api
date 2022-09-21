// import 'package:flutter_rest_apis/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_apis/screens/paginated.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Blog App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirstScreen());
  }
}

class PhotoItem {
  final String image;

  PhotoItem(this.image);
}

class FirstScreen extends StatelessWidget {
  FirstScreen({Key key}) : super(key: key);

  final List<PhotoItem> _items = [
    PhotoItem("assets/images/president.webp"),
    PhotoItem("assets/images/war.jpg"),
    PhotoItem("assets/images/globalwarming.jpg"),
    PhotoItem("assets/images/celebrity.jpg"),
    PhotoItem("assets/images/kampala.jpg"),
    PhotoItem("assets/images/arsenal.webp"),
    PhotoItem("assets/images/food.jpg"),
    PhotoItem("assets/images/football.jpg"),
    PhotoItem("assets/images/art.jpg"),
    PhotoItem("assets/images/animal.jpg"),
    PhotoItem("assets/images/globalwarming.jpg"),
    PhotoItem("assets/images/war.jpg"),
    PhotoItem("assets/images/kampala.jpg"),
    PhotoItem("assets/images/president.webp"),
    PhotoItem("assets/images/war.jpg"),
    PhotoItem("assets/images/globalwarming.jpg"),
    PhotoItem("assets/images/art.jpg"),
    PhotoItem("assets/images/animal.jpg"),
    PhotoItem("assets/images/globalwarming.jpg"),
    PhotoItem("assets/images/war.jpg"),
    PhotoItem("assets/images/food.jpg"),
    PhotoItem("assets/images/football.jpg"),
    PhotoItem("assets/images/art.jpg"),
    PhotoItem("assets/images/animal.jpg"),
    PhotoItem("assets/images/globalwarming.jpg"),
    PhotoItem("assets/images/president.webp"),
    PhotoItem("assets/images/war.jpg"),
    PhotoItem("assets/images/globalwarming.jpg"),
    PhotoItem("assets/images/celebrity.jpg"),
    PhotoItem("assets/images/kampala.jpg"),
    PhotoItem("assets/images/arsenal.webp"),
    PhotoItem("assets/images/food.jpg"),
    PhotoItem("assets/images/football.jpg"),
    PhotoItem("assets/images/art.jpg"),
    PhotoItem("assets/images/animal.jpg"),
    PhotoItem("assets/images/globalwarming.jpg"),
    PhotoItem("assets/images/war.jpg"),
    PhotoItem("assets/images/kampala.jpg"),
    PhotoItem("assets/images/president.webp"),
    PhotoItem("assets/images/war.jpg"),
    PhotoItem("assets/images/globalwarming.jpg"),
    PhotoItem("assets/images/art.jpg"),
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff061829),
          body: Stack(
            children: [
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1/1,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  crossAxisCount: 4,
                ),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(_items[index].image),
                      ),
                    ),
                  );
                },
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(00),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [
                      0.2,
                      0.4,
                      0.6,
                      0.8,
                      1.0
                    ],
                    colors: [
                      Color(0xff061829).withOpacity(1.0),
                      Color(0xff061829).withOpacity(1.0),
                      Color(0xff061829).withOpacity(0.6),
                      Color(0xff061829).withOpacity(0.6),
                      Color(0xff061829).withOpacity(0.6)
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'Discover and share the stories that matter to you',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'Created with curated content on thousands of topics from world-renowned publishers, local outlets and the community.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>  Paginated(),
                                fullscreenDialog: true
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(50),
                                // border: Border.all(
                                //     color: Colors.white70,
                                //     width: 2
                                // )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'CONTINUE TO NEWS',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                                )
                              ],
                            ),
                          )
                        )
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              )
            ],
          )

      ),
    );
  }
}