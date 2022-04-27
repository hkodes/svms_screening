import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:svms_screening/pages/albums_page.dart';
import 'package:svms_screening/pages/post_page.dart';
import 'package:svms_screening/services/db.dart';

import '../models/user.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<User>> listUsers;
  final DBhelper _db = new DBhelper();

  @override
  void initState() {
    super.initState();
    listUsers = _db.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: listUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.9),
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var user = (snapshot.data as List<User>)[index];
                  return FocusedMenuHolder(
                      menuWidth: MediaQuery.of(context).size.width * 0.50,
                      blurSize: 5.0,
                      menuItemExtent: 45,
                      menuBoxDecoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      duration: Duration(milliseconds: 100),
                      animateMenuItems: true,
                      blurBackgroundColor: Colors.black54,
                      openWithTap: true,
                      menuOffset: 10.0,
                      onPressed: () {},
                      menuItems: <FocusedMenuItem>[
                        FocusedMenuItem(
                            backgroundColor: Colors.grey.shade300,
                            title: const Text('Posts',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                            trailingIcon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 15,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => PostsPage(
                                        user: user,
                                      )));
                            }),
                        FocusedMenuItem(
                            backgroundColor: Colors.grey.shade400,
                            title: const Text('Albums',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                            trailingIcon: const Icon(Icons.arrow_forward_ios,
                                color: Colors.black, size: 15),
                            onPressed: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => AlbumsPage(
                                        user: user,
                                      )));
                            }),
                        FocusedMenuItem(
                          backgroundColor: Colors.grey.shade300,
                          title: const Text(
                            "ToDos",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          trailingIcon: const Icon(Icons.arrow_forward_ios,
                              color: Colors.black, size: 15),
                          onPressed: () async {
                            SystemChannels.platform
                                .invokeMethod('SystemNavigator.pop');
                          },
                        ),
                      ],
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade300),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              user.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            SizedBox(height: 10),
                            Text(user.email),
                            SizedBox(height: 10),
                            Text(user.address.street +
                                " " +
                                user.address.suite +
                                " " +
                                user.address.city +
                                " " +
                                user.address.zipcode),
                          ],
                        ),
                      ));
                },
                itemCount: (snapshot.data as List<User>).length);
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.cyanAccent,
            ),
          );
        },
      ),
    );
  }
}

Widget _buildProfile(BuildContext context) {
  return FocusedMenuHolder(
    menuWidth: MediaQuery.of(context).size.width * 0.50,
    blurSize: 5.0,
    menuItemExtent: 45,
    menuBoxDecoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
    duration: Duration(milliseconds: 100),
    animateMenuItems: true,
    blurBackgroundColor: Colors.black54,
    openWithTap: true,
    menuOffset: 10.0,
    onPressed: () {},
    bottomOffsetHeight: 80.0,
    menuItems: <FocusedMenuItem>[
      FocusedMenuItem(
          backgroundColor: Colors.blue,
          title: Text(
            'hi',
          ),
          onPressed: () {}),
      FocusedMenuItem(
          backgroundColor: Colors.blue, title: Text('hello'), onPressed: () {}),
      FocusedMenuItem(
        backgroundColor: Colors.redAccent,
        title: Text(
          "Sign Out",
          style: TextStyle(color: Colors.white),
        ),
        trailingIcon: Icon(
          Icons.logout,
          color: Colors.white,
        ),
        onPressed: () async {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
      ),
    ],
    child: CircleAvatar(
      radius: 50,
      child: Text(
        'Bi',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
