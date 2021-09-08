import 'package:flutter/material.dart';
import 'package:flutterprojects/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:flutterprojects/modules/done_tasks/done_tasks_screen.dart';
import 'package:flutterprojects/modules/new_tasks/new_tasks_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex=0;
  List <Widget> Screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),

  ];
  List <String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      title:
        Text(
          titles[currentIndex],
        ),
      ),
      body:Screens[currentIndex],
      floatingActionButton :FloatingActionButton(
        onPressed: (){},
        child:
        Icon(Icons.add
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex:currentIndex,
        onTap:(index){
          setState(() {
            currentIndex=index;

          });
          print(index);

        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu,
              ),

            label:'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline_outlined,
            ),
            label:'Done',
          ),
          BottomNavigationBarItem(
            icon:Icon(
              Icons.archive_outlined
            ),
            label:'Archived'
          ),

        ],
      ),
    );
  }
}
