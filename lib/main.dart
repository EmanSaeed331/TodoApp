import 'package:flutter/material.dart';

import 'layout/home_layout.dart';

void main(){
  runApp(TodoApp());

}
class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomeLayout(),
    );
  }

}