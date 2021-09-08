import 'package:flutter/material.dart';
class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Text(
        'Done tasks',
        style:TextStyle(
          fontSize:30.0,
          fontWeight:FontWeight.bold,
        ),
      ),
    );
  }
}
