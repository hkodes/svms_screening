import 'package:flutter/material.dart';
import 'package:svms_screening/details/post_details.dart';
import 'package:svms_screening/models/post.dart';
import 'package:svms_screening/models/user.dart';
import 'package:svms_screening/services/db.dart';

class PostsPage extends StatefulWidget {
  final User user;

  const PostsPage({Key? key, required this.user}) : super(key: key);
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  DBhelper dbhelper = DBhelper();

  late List<Post> posts;
  @override
  void initState() {
    super.initState();
    dbhelper = DBhelper();
    getPosts();
  }

  Future<List<Post>> getPosts() async {
    posts = await dbhelper.getPosts(widget.user);
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Post"),
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: getPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(2),
                      height: 100,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PostDetails(
                                    post: posts[index],
                                    user: widget.user,
                                  )));
                        },
                        child: Card(
                          color: Colors.grey.shade300,
                          elevation: 10,
                          shadowColor: Colors.black,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: CircleAvatar(
                                    child: Text(
                                      '${widget.user.id}',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    radius: 50,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    posts[index].title,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right,
                                    size: 50,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
