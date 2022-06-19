// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
// image from https://icons8.com/illustrations/author/zD2oqC8lLBBA"

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/constants.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<ToDo> todos = [];
  static final taskController = TextEditingController();
  static final dueDateController = TextEditingController();
  static DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // Modified AppBar
              CustomAppBar(),
              SizedBox(height: 10),
              // Content of Home
              if (todos.isNotEmpty)
                SizedBox(
                  height: todos.length * 90,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: todos.length,
                      itemBuilder: (BuildContext context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Task deleted. Good job!'),
                                backgroundColor: Colors.red[800],
                              ));
                              setState(() {
                                todos.removeAt(index);
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: (!todos[index].completed)
                                    ? Text('Task completed. Hooray!')
                                    : Text('Task uncompleted. It\'s okay, just don\'t forget about it!'),
                                backgroundColor: (!todos[index].completed)
                                    ? Colors.green[800]
                                    : kPrimaryColor,
                              ));
                              setState(() {
                                todos[index].completed =
                                    !todos[index].completed;
                              });
                            }
                          },
                          child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: (todos[index].completed)
                                      ? Icon(Icons.check_circle_outline_rounded,
                                          color: Colors.white)
                                      : Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                  backgroundColor: (todos[index].completed)
                                      ? Colors.green[800]
                                      : Colors.yellow[800],
                                ),
                                title: Text(todos[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        decorationColor: kPrimaryColor,
                                        decorationThickness: 3,
                                        decoration: (todos[index].completed)
                                            ? TextDecoration.lineThrough
                                            : null)),
                                subtitle: Text(todos[index].dueDate,
                                    style: TextStyle(
                                        decorationColor: kPrimaryColor,
                                        decorationThickness: 3,
                                        decoration: (todos[index].completed)
                                            ? TextDecoration.lineThrough
                                            : null)),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          background: (todos[index].completed)
                              ? Container(
                                  color: kPrimaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.undo_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                )
                              : Container(
                                  color: Colors.green[800],
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                          secondaryBackground: Container(
                            color: Colors.red[700],
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            alignment: Alignment.centerRight,
                          ),
                        );
                      }),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 170),
                  child: Column(
                    children: [
                      Image.asset(
                          'images/business-3d-man-lying-with-laptop.png',
                          width: 300),
                      SizedBox(height: 10),
                      Text('Start organizing your life.',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w800)),
                      SizedBox(height: 10),
                      Text('Click the add button to add a task!',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 5),
                      Text('P.S. To delete a task, swipe the card to the left.',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      Text('To complete or undo a task, swipe the card to the right.',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomSheet(context);
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
        tooltip: 'Add a task!',
      ),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SizedBox(
              height: 250,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 25),
                      TaskInput(taskController: taskController),
                      SizedBox(height: 20),
                      DueDateInput(dueDateController: dueDateController),
                      SizedBox(height: 20),
                      addTaskButton(context)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  InkWell addTaskButton(BuildContext context) {
    return InkWell(
      onTap: () {
        if (taskController.text != '' && dueDateController.text != '') {
          setState(() {
            _HomeState.todos.add(ToDo(
                title: taskController.text,
                dueDate: dueDateController.text,
                completed: false));
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: kPrimaryColor,
              content: Text("Task added. Don't forget to do it!")));
          taskController.text = '';
          dueDateController.text = '';
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('Your inputs must be valid!'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('GOT IT!',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w500)))
                  ],
                );
              });
        }
      },
      child: Container(
        height: 40,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text('Add Task',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      ),
    );
  }
}

class DueDateInput extends StatelessWidget {
  const DueDateInput({
    Key? key,
    required this.dueDateController,
  }) : super(key: key);

  final TextEditingController dueDateController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          selectDate(context);
        },
        child: IgnorePointer(
          child: TextField(
            cursorColor: kPrimaryColor,
            controller: dueDateController,
            decoration: InputDecoration(
              labelText: 'Due Date',
              labelStyle:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(width: 2, color: kPrimaryColor)),
            ),
          ),
        ),
      ),
    );
  }
}

class TaskInput extends StatelessWidget {
  const TaskInput({
    Key? key,
    required this.taskController,
  }) : super(key: key);

  final TextEditingController taskController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        autofocus: true,
        cursorColor: kPrimaryColor,
        controller: taskController,
        decoration: InputDecoration(
          labelText: 'Your Task',
          labelStyle:
              TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(width: 2, color: kPrimaryColor)),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: CircleAvatar(
                child: ClipOval(
                  child: Image.asset('images/profile-picture.jpg',
                      width: 32, height: 32, fit: BoxFit.cover),
                ),
              ),
              color: kPrimaryColor,
              iconSize: 30,
            ),
          ),
          Center(
            child: Text(
              'You Haven\'t...',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

void selectDate(BuildContext context) async {
  final DateTime? selected = await showDatePicker(
    context: context,
    initialDate: _HomeState.selectedDate,
    firstDate: DateTime(2022),
    lastDate: DateTime(2025),
    builder: (context, child) {
      return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: kPrimaryColor),
          ),
          child: child!);
    },
  );
  if (selected != null) {
    _HomeState.dueDateController.text =
        "${DateFormat('MMM').format(DateTime(0, selected.month))} ${selected.day}";
  }
}
