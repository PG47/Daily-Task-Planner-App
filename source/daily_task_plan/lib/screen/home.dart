import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var task_controller;
  var Tasks;

  void SaveData() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    Task task = Task.fromString(task_controller.text);

    String task_name = data.getString('task') ?? "";
    List<Map<String, dynamic>> task_list = [];

    task_list = List<Map<String, dynamic>>.from(json.decode(task_name));

    final Map<String, dynamic> taskMap = task.getMap();
    task_list.add(taskMap);
    final updatedTaskList = json.encode(task_list);
    data.setString('task', updatedTaskList);
    task_controller.text = '';
    Navigator.of(context).pop();
  }

  void getTask() async {
    Tasks = [];
    SharedPreferences data = await SharedPreferences.getInstance();

    String task_name = data.getString('task') ?? "";
    List<Map<String, dynamic>> task_list = [];
    task_list = List<Map<String, dynamic>>.from(json.decode(task_name));

    for (Map<String, dynamic> d in task_list) {
      Tasks.add(Task.fromMap(d));
    }

    print(Tasks);
  }

  @override
  void initState() {
    super.initState();
    task_controller = TextEditingController();

    getTask();
  }

  @override
  void dispose() {
    task_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Manager',
          //style: GoogleFonts.montserrat(),
        ),
      ),
      body: Center(
        child: Text('No tasks added yet!'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.green,
        ),
        backgroundColor: Colors.red,
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(10.0),
                  height: 200,
                  color: Colors.blue[200],
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ADD TASK',
                            /*style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),*/
                          ),
                          GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Icon(
                                Icons.close,
                              ))
                        ],
                      ),
                      Divider(
                        height: 1.5,
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: 20.5,
                      ),
                      TextField(
                        controller: task_controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Task Name',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              child: Text('Reset'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () => task_controller.text = '',
                            ),
                            ElevatedButton(
                              child: Text('Add'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () => SaveData(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
