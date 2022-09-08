import 'package:flutter/material.dart';
import 'package:smarteditorstestapp/data/fakeapi.dart';

class ListItemWidget extends StatelessWidget {
  final String postID;
  final String title;
  final String body;
  final String author;
  final Function(String) getCommentList;

  const ListItemWidget(
      {Key? key,
      required this.postID,
      required this.title,
      required this.body,
      required this.author,
      required this.getCommentList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          height: 100,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                    child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                  backgroundColor: Colors.transparent,
                )),
                SizedBox(width: 20),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          child: Text(title,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))),
                      SizedBox(
                          child: Text(body,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 10))),
                      SizedBox(
                          child: Text('Author: ${author}',
                              textAlign: TextAlign.end,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 8))),
                    ])
              ])),
      onTap: () => getCommentList(postID),
    );
  }
}
