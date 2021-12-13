import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:setstate_pattern/models/post_model.dart';
import 'package:setstate_pattern/pages/home_page.dart';
import 'package:setstate_pattern/services/http_service.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);
  static String id = "post_page";

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  Random random = new Random();
  bool isLoading = false ;
  late Post post;
  var titleController = TextEditingController();
  var bodyController = TextEditingController();

  void _createPostList() async {
    post = Post(title: titleController.text, body: bodyController.text, userId: random.nextInt(10));
    setState(() {
      isLoading = true;
    });
    var response =
    await Network.POST(Network.API_Create, Network.paramsCreate(post));
    setState(() {
      if(response != null){
        Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
      }
      isLoading = false;
    });
    print("CreatePost => $response");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Create new Post",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            texField(hintText: "Title", controller: titleController),
            SizedBox(
              height: 30,
            ),
            texField(hintText: "Body", controller: bodyController),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size.fromHeight(40)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ))),
              onPressed: () async {
                _createPostList();
              },
              child: Text(
                "Add",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget texField({hintText, controller}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
      ),
    );
  }
}
