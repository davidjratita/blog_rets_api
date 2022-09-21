import 'package:flutter_rest_apis/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_apis/services/user_service.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';


class CommentsPage extends StatelessWidget {

  CommentsPage({Key key,  this.data}) : super(key: key);
  PostModel data;
  int index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff061829),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Comments"),
          backgroundColor: Color(0xff061829),
          elevation: 0,
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: data.comments.length,
          itemBuilder: (context, index) {
            // print(data);
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              leading: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Center(
                      child: Icon(Ionicons.person_circle_outline, color: Colors.white),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage('${data.comments[index].author.authorAvatar}'),
                  )
                ],
              ),
              title: Text(data.comments[index].author.authorName,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500
              ),
              ),
              subtitle: Text(data.comments[index].comment,
              style: TextStyle(
                  color: Colors.white54, fontWeight: FontWeight.w400
              ),
              ),
            );
          },
        )
      ),
    );
  }
}
