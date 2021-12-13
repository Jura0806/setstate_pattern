import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:setstate_pattern/models/post_model.dart';
import 'package:setstate_pattern/pages/create_post_page.dart';
import 'package:setstate_pattern/pages/update_page.dart';
import 'package:setstate_pattern/services/http_service.dart';

class HomePage extends StatefulWidget {
  static String id = "home_page";


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> items = [];
  bool isLoading = false;

  void _apiPostList() async {
    var response = await Network.GET(Network.API_List, Network.paramsEmpty());
    print(response);
    setState(() {
      isLoading = true;
    });
    setState(() {
      if (response != null) {
        items = Network.parsePostList(response);
      } else {
        items = [];
      }
      isLoading = false;
    });
    print("++++++++");
    //print(items);
  }

  void _deletePostList(Post post) async {
    var response = await Network.Del(Network.API_Delete + post.id.toString(), Network.paramsEmpty());
    print("DeletePost => ${response.toString()}");
    setState(() {
      isLoading = false;
    });
    setState(() {
      if(response != null){
        _apiPostList();
      }
      isLoading = true;
    });
  }
  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("setState"),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, i) {
              return _itemOfList(items[i]);
            },
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePost()));
        },
      ),
    );
  }

  Widget _itemOfList(Post post) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(post.body),
          ],
        ),
      ),
      actions: [
        IconSlideAction(
          caption: "Update",
          color: Colors.indigo,
          icon: Icons.edit,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(title: post.title,body: post.body,id: post.id,)));
          },
        ),
      ],
      secondaryActions: [
        IconSlideAction(
          caption: "Delete",
          color: Colors.red,
          icon: Icons.delete,
          onTap: (){
            _deletePostList(post);
          },
        )
      ],
    );
  }
}
