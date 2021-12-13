

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:setstate_pattern/models/post_model.dart';
import 'package:setstate_pattern/services/http_service.dart';

import 'home_page.dart';

class UpdatePage extends StatefulWidget {
  final  String title;
  final String  body;
  final int? id;
  const UpdatePage({Key? key, required this.title, required this.body, required this.id}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  bool isLoading = false;
  Random random = new Random();


  void _updatePostList() async {
    Post post = Post(title: titleController.text, body: bodyController.text, userId: random.nextInt(10));
    setState(() {
      isLoading = true;
    });
    var response =
    await Network.PUT(Network.API_Update + widget.id.toString(), Network.paramsUpdate(post));
    print(response);
    setState(() {
      if(response != null){
        Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
      }
      isLoading = false;
    });
    print("CreatePost => $response");
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    bodyController.text = widget.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Post",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(child: texField(labelText: "Title", controller: titleController)),
            SizedBox(
              height: 30,
            ),
            Container(child: texField(labelText: "Body", controller: bodyController)),
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
                _updatePostList();
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
  Widget texField({labelText, controller}) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        border: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.always
      ),
    );
  }
}
