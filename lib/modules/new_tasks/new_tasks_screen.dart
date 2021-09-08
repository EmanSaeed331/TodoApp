import 'package:flutter/material.dart';
class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Text(
        'New Tasks',
        style:TextStyle(
          fontSize:30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
