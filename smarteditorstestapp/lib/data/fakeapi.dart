import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/fakeapiresponsecommentmodel.dart';
import '../models/fakeapiresponseusermodel.dart';
import '../models/fakeapiresponsepostmodel.dart';

List<FakeAPIResponsePostModel> parsePosts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<FakeAPIResponsePostModel>(
          (json) => FakeAPIResponsePostModel.fromJson(json))
      .toList();
}

List<FakeAPIResponseUserModel> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<FakeAPIResponseUserModel>(
          (json) => FakeAPIResponseUserModel.fromJson(json))
      .toList();
}

List<FakeAPIResponseCommentModel> parseComments(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<FakeAPIResponseCommentModel>(
          (json) => FakeAPIResponseCommentModel.fromJson(json))
      .toList();
}

Future<List<FakeAPIResponsePostModel>> getPostListItem() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    return parsePosts(response.body);
  } else {
    throw Exception('Failed to load posts');
  }
}

Future<List<FakeAPIResponseUserModel>> getUserListItem() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  if (response.statusCode == 200) {
    return parseUsers(response.body);
  } else {
    throw Exception('Failed to load users');
  }
}

Future<List<FakeAPIResponseCommentModel>> getCommentListItem(
    String postID) async {
  final response = await http.get(Uri.parse(
      'https://jsonplaceholder.typicode.com/posts/' + postID + '/comments'));
  if (response.statusCode == 200) {
    return parseComments(response.body);
  } else {
    throw Exception('Failed to load comments of post ' + postID);
  }
}

Future<FakeAPIResponseUserModel> getUserModalWithUserID(String userID) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users/' + userID));
  if (response.statusCode == 200) {
    return FakeAPIResponseUserModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

Future<FakeAPIResponsePostModel> getPostWithPostID(String postID) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/' + postID));
  if (response.statusCode == 200) {
    return FakeAPIResponsePostModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}
