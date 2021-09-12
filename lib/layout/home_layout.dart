import 'package:flutter/material.dart';
import 'package:flutterprojects/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:flutterprojects/modules/done_tasks/done_tasks_screen.dart';
import 'package:flutterprojects/modules/new_tasks/new_tasks_screen.dart';
import 'package:flutterprojects/shared/Components/Components.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>
{
  int currentIndex=0;
  IconData fabIcon = Icons.edit;

  List <Widget> Screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),

  ];
  var TextController = TextEditingController();
  var TimeController = TextEditingController();
  var DateController = TextEditingController();


  bool bottomsheetshown = false;
  List <String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  late Database database;
  var  scaffoldkey = GlobalKey <ScaffoldState>();
  var  formkey = GlobalKey <FormState>();
  @override
  void initState() {
    super.initState();
    CreateDatabase();
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold
      (key:scaffoldkey,
      appBar:AppBar(
      title:
        Text(
          titles[currentIndex],
        ),
      ),
      body:Screens[currentIndex],
      floatingActionButton :FloatingActionButton(
        onPressed: (){
          if(bottomsheetshown)
            InsertToDatabase(
              title:TextController.text,
              time :TimeController.text,
              Date :DateController.text,

            ).then((value) => {
            Navigator.pop(context),
                bottomsheetshown = false,
                setState((){
            fabIcon = Icons.edit;})

          });








          else
            {
              setState((){
                fabIcon = Icons.add;

              });
            scaffoldkey.currentState?.showBottomSheet (
              (context) => Container(
              color:Colors.white,

              padding:EdgeInsets.all(20.0),
              child: Form(
                key : formkey,
                child: Column(
                  mainAxisSize:MainAxisSize.min ,
                  children:
                  [ TextFormField(
                  controller: TextController,
                  keyboardType:TextInputType.text,
                  //onFieldSubmitted: onSubmit,
                  //onChanged: onchange,
                  onTap: ((){
                    print('TASK TAPPED');
                  }),
                  // validator: validate,
                  decoration: InputDecoration(
                    labelText: 'New Task',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),

                  ),
                  ),
                    SizedBox(
                      height:15,
                    ),
                    TextFormField(
                      controller: TimeController,
                      keyboardType:TextInputType.text,
                      //onFieldSubmitted: onSubmit,
                      //onChanged: onchange,
                        decoration: InputDecoration(
                          labelText: 'Time Task',
                          prefixIcon: Icon(Icons.watch_later_outlined),
                          border: OutlineInputBorder(),

                        ),

                      onTap: (){
                        showTimePicker(context: context,
                          initialTime: TimeOfDay.now(),).then((dynamic value)  {
                            print(value.format(context).toString());

                             TimeController.text = value.format(context).toString();



                        });
                        }
                      // validator: validate,

                    ),
                    SizedBox(
                      height:15,
                    ),
                    TextFormField(
                        controller: DateController,
                        keyboardType:TextInputType.text,
                        //onFieldSubmitted: onSubmit,
                        //onChanged: onchange,
                        decoration: InputDecoration(
                          labelText: 'Date Task',
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),

                        ),

                        onTap: (){

                              showDatePicker(context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2022-05-03')).
                                  then((value) {
                                    DateController.text = DateFormat.yMMMd().format(value!);

                              } );


                        }
                      // validator: validate,

                    ),

                  ],


                    ),
              ),

            ),
              elevation: 20.0,

            );
            bottomsheetshown = true;

            }


        },
        child:
        Icon(fabIcon
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


   CreateDatabase () async  {
      database = await openDatabase(
      'Todo.db',
      version :1,
      onCreate  :  (database,version)
      {
        print('database Created');
         database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,Date TEXT ,Time TEXT , Status TEXT )').then((Value){
           print('Table is created');
         }).catchError((error){
           print('Error ${error.toString()}');
         });
      },
      onOpen:(database){
        print('databse Opened');
      },
    ) as Database;
  }

  Future InsertToDatabase ({
    required String title,
    required String time,
    required String Date,
  }) async
  {
     await database.transaction(( txn)
    {
      return txn.rawInsert('INSERT INTO tasks (title,Date,Time,Status) VALUES ("$title" ,"$time","$Date","New")').then((value) {
          print('Inserted Successfully ${value}');
        }).catchError((error)
        {
          print('ERROR ${error.toString()}');

        });


    });


  }

}
