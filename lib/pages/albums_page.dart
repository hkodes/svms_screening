import 'package:flutter/material.dart';
import 'package:svms_screening/details/album_details.dart';
import 'package:svms_screening/models/album.dart';
import 'package:svms_screening/models/user.dart';
import 'package:svms_screening/services/db.dart';

class AlbumsPage extends StatefulWidget {
  final User user;

  const AlbumsPage({Key? key, required this.user}) : super(key: key);
  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  DBhelper dbhelper = DBhelper();
  late List<Album> albums;
  @override
  void initState() {
    super.initState();
    dbhelper = DBhelper();
    getAlbums();
  }

  Future<List<Album>> getAlbums() async {
    albums = await dbhelper.getAlbums(widget.user);
    return albums;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Album"),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getAlbums(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AlbumDetails(album: albums[index]),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                      child: Card(
                        color: Colors.purple.shade100,
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
                                  radius: 30,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  albums[index].title,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
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
      ),
    );
  }
}
