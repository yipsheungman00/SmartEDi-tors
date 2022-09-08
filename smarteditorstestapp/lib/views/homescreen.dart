import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarteditorstestapp/data/fakeapi.dart';
import 'package:smarteditorstestapp/models/fakeapiresponsepostmodel.dart';
import 'package:smarteditorstestapp/models/fakeapiresponseusermodel.dart';
import 'package:smarteditorstestapp/viewmodels/userviewmodel.dart';

import '../widgets/listitem.dart';

String searchValue = '';
late List<FakeAPIResponseUserModel> userList = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    var list = await getUserListItem();
    setState(() {
      userList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel usersViewModel = context.watch<UserViewModel>();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (usersViewModel.currentScreen == Screen.UserModal) {
              usersViewModel.getCommentList(
                  usersViewModel.commentList[0].postId.toString());
            } else {
              usersViewModel.getUserList();
            }
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.arrow_back),
        ),
        appBar: EasySearchBar(
            title: Text('SmartEDi-tors Test App'),
            onSearch: (value) => setState(() => searchValue = value)),
        body: Container(child: _ui(usersViewModel)));
  }

  _ui(UserViewModel usersViewModel) {
    if (usersViewModel.loading) {
      return Center(child: Text("Loading"));
    }
    if (usersViewModel.currentScreen == Screen.PostList) {
      return FutureBuilder(
        future: getPostListItem(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  if (searchValue != "") {
                    if (snapshot.data![index].title.contains(searchValue) ||
                        snapshot.data![index].body.contains(searchValue) ||
                        userList
                            .firstWhere(
                                (e) => e.id == snapshot.data![index].userId)
                            .username
                            .contains(searchValue)) {
                      return ListItemWidget(
                          postID: snapshot.data![index].id.toString(),
                          title: snapshot.data![index].title,
                          body: snapshot.data![index].body,
                          author: (usersViewModel.userList.isNotEmpty
                              ? userList
                                  .firstWhere((e) =>
                                      e.id == snapshot.data![index].userId)
                                  .username
                              : snapshot.data![index].userId.toString()),
                          getCommentList: (String val) {
                            usersViewModel
                                .getPost(snapshot.data![index].id.toString());
                          });
                    } else {
                      return const SizedBox(width: 0);
                    }
                  } else {
                    return ListItemWidget(
                        postID: snapshot.data![index].id.toString(),
                        title: snapshot.data![index].title,
                        body: snapshot.data![index].body,
                        author: (usersViewModel.userList.isNotEmpty
                            ? userList
                                .firstWhere(
                                    (e) => e.id == snapshot.data![index].userId)
                                .username
                            : snapshot.data![index].userId.toString()),
                        getCommentList: (String val) {
                          usersViewModel.getCommentList(
                              snapshot.data![index].id.toString());
                        });
                  }
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    } else if (usersViewModel.currentScreen == Screen.CommentList) {
      return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: usersViewModel.commentList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                    height: 40,
                    child: Text(
                        "#${usersViewModel.commentList[index].id} ${usersViewModel.commentList[index].name}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.lightBlue))),
                Container(
                    height: 80,
                    child: Text(usersViewModel.commentList[index].body,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                Container(
                    height: 30,
                    child: Text(usersViewModel.commentList[index].email,
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.deepPurple))),
              ],
            );
          });
    } else if (usersViewModel.currentScreen == Screen.UserModal) {
      return Column(
        children: [
          const Center(
              child: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            backgroundColor: Colors.transparent,
          )),
          SizedBox(width: 20),
          Center(child: Text("Name: ${usersViewModel.userModal.name}")),
          Center(child: Text("Username: ${usersViewModel.userModal.username}")),
          Center(child: Text("Email: ${usersViewModel.userModal.email}")),
          Center(child: Text("Address:")),
          Center(
              child:
                  Text("Street: ${usersViewModel.userModal.address.street}")),
          Center(
              child: Text("Suite: ${usersViewModel.userModal.address.suite}")),
          Center(child: Text("City: ${usersViewModel.userModal.address.city}")),
          Center(
              child:
                  Text("Zipcode: ${usersViewModel.userModal.address.zipcode}")),
          Center(
              child: Text(
                  "Geo: ${usersViewModel.userModal.address.geo.lat}(lat) ${usersViewModel.userModal.address.geo.lng}(lng)")),
          Center(child: Text("Phone: ${usersViewModel.userModal.phone}")),
          Center(child: Text("Website: ${usersViewModel.userModal.website}")),
          Center(child: Text("Company:")),
          Center(child: Text("Name: ${usersViewModel.userModal.company.name}")),
          Center(
              child: Text(
                  "CatchPhase: ${usersViewModel.userModal.company.catchPhrase}")),
          Center(child: Text("bs: ${usersViewModel.userModal.company.bs}")),
        ],
      );
    } else {
      return Center(child: Text("Error"));
    }
  }
}
