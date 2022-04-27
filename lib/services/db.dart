import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/album.dart';
import '../models/comment.dart';
import '../models/photo.dart';
import '../models/post.dart';
import '../models/todo.dart';
import '../models/user.dart';

class DBhelper {
  final baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<User>> getAllUsers() async {
    var response = await http.get(Uri.parse(baseUrl + "/users/"));
    if (response.statusCode == 200) {
      var getUsersData = json.decode(response.body) as List;
      var listUsers = getUsersData.map((i) => User.fromJSON(i)).toList();
      return listUsers;
    } else {
      throw Exception("User_Decode : " + response.statusCode.toString());
    }
  }

  Future<List<User>> getUsers(String userId) async {
    var response = await http.get(Uri.parse(baseUrl + "/users/" + userId));
    debugPrint('users: ${response.body}');
    if (response.statusCode == 200) {
      var getUsersData = json.decode(response.body) as List;
      var listUsers = getUsersData.map((i) => User.fromJSON(i)).toList();
      return listUsers;
    } else {
      throw Exception("User_Decode : " + response.statusCode.toString());
    }
  }

  Future<List<Post>> getPosts(User user) async {
    var response = await http
        .get(Uri.parse(baseUrl + "/posts/?userId=" + user.id.toString()));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((map) => Post.fromJson(map))
          .toList();
    } else {
      throw Exception("Post_Decode : " + response.statusCode.toString());
    }
  }

  Future<List<Comment>> getComments(Post post) async {
    var response = await http
        .get(Uri.parse(baseUrl + "/comments/?postId=" + post.id.toString()));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((map) => Comment.fromJson(map))
          .toList();
    } else {
      throw Exception("Comments_Decode : " + response.statusCode.toString());
    }
  }

  Future<List<Album>> getAlbums(User user) async {
    var response = await http
        .get(Uri.parse(baseUrl + "/albums/?userId=" + user.id.toString()));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((map) => Album.fromJson(map))
          .toList();
    } else {
      throw Exception("Albums_Decode : " + response.statusCode.toString());
    }
  }

  Future<List<Todo>> getTodos(User user) async {
    var response = await http
        .get(Uri.parse(baseUrl + "/todos/?userId=" + user.id.toString()));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((map) => Todo.fromJson(map))
          .toList();
    } else {
      throw Exception("Todo_Decode : " + response.statusCode.toString());
    }
  }

  Future<List<Photo>> getPhotos(Album album) async {
    var response = await http
        .get(Uri.parse(baseUrl + "/photos/?albumId=" + album.id.toString()));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((map) => Photo.fromJson(map))
          .toList();
    } else {
      throw Exception("Photo_decode : " + response.statusCode.toString());
    }
  }
}
