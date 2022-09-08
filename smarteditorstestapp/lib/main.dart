import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarteditorstestapp/models/fakeapiresponsepostmodel.dart';
import 'package:smarteditorstestapp/viewmodels/userviewmodel.dart';
import 'package:smarteditorstestapp/views/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => UserViewModel())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SmartEDi-tors',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
        ));
  }
}
