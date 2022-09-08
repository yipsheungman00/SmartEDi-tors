import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smarteditorstestapp/data/fakeapi.dart';
import 'package:smarteditorstestapp/models/fakeapiresponsecommentmodel.dart';
import 'package:smarteditorstestapp/models/fakeapiresponsepostmodel.dart';
import 'package:smarteditorstestapp/models/fakeapiresponseusermodel.dart';

enum Screen { PostList, UserModal, CommentList }

class UserViewModel extends ChangeNotifier {
  Screen _currentScreen = Screen.PostList;
  bool _loading = false;
  List<FakeAPIResponseUserModel> _userList = [];
  List<FakeAPIResponseCommentModel> _commentList = [];
  late FakeAPIResponsePostModel _post;
  late FakeAPIResponseUserModel _userModal;

  bool get loading => _loading;
  Screen get currentScreen => _currentScreen;
  List<FakeAPIResponseUserModel> get userList => _userList;
  List<FakeAPIResponseCommentModel> get commentList => _commentList;
  FakeAPIResponsePostModel get post => _post;
  FakeAPIResponseUserModel get userModal => _userModal;

  UserViewModel() {
    getUserList();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setCurrentScreen(Screen currentScreen) {
    _currentScreen = currentScreen;
  }

  setUserList(List<FakeAPIResponseUserModel> userList) {
    _userList = userList;
  }

  setCommentList(List<FakeAPIResponseCommentModel> commentList) {
    _commentList = commentList;
  }

  setUserModal(FakeAPIResponseUserModel userModal) {
    _userModal = userModal;
  }

  setPost(FakeAPIResponsePostModel post) {
    _post = post;
    getCommentList(post.id.toString());
  }

  getUserList() async {
    setLoading(true);
    var response = await getUserListItem();
    if (response.length > 0) {
      setUserList(response);
    }
    setCurrentScreen(Screen.PostList);
    setLoading(false);
  }

  getCommentList(String postID) async {
    setLoading(true);
    var response = await getCommentListItem(postID);
    if (response.length > 0) {
      setCommentList(response);
    }
    setCurrentScreen(Screen.CommentList);
    setLoading(false);
  }

  getUserModal(String userID) async {
    setLoading(true);
    var response = await getUserModalWithUserID(userID);
    if (response.id == userID) {
      setUserModal(response);
    }
    setCurrentScreen(Screen.UserModal);
    setLoading(false);
  }

  getPost(String postID) async {
    setLoading(true);
    var response = await getPostWithPostID(postID);
    if (response.id == postID) {
      setPost(response);
    }
  }
}
