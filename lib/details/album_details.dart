import 'package:flutter/material.dart';
import 'package:svms_screening/models/album.dart';
import 'package:svms_screening/models/photo.dart';
import 'package:svms_screening/services/db.dart';

class AlbumDetails extends StatefulWidget {
  final Album album;

  const AlbumDetails({Key? key, required this.album}) : super(key: key);
  @override
  _AlbumDetailsState createState() => _AlbumDetailsState();
}

class _AlbumDetailsState extends State<AlbumDetails> {
  DBhelper dbhelper = DBhelper();
  late List<Photo> photos;
  @override
  void initState() {
    super.initState();
    dbhelper = DBhelper();
    getPhotos();
  }

  Future<List<Photo>> getPhotos() async {
    photos = await dbhelper.getPhotos(widget.album);
    return photos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Album Details"),
      ),
      body: FutureBuilder(
        future: getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GridView.builder(
                itemCount: photos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return Hero(
                    tag: "${photos[index].url}",
                    child: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.purple.shade200,
                          ),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        photos[index].thumbnailUrl)),
                              ),
                            ),
                          ),
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
