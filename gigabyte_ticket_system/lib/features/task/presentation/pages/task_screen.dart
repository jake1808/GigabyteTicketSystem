import 'package:flutter/material.dart';
import 'package:gigabyte_ticket_system/data/datasources/DataBase.dart';
import 'package:gigabyte_ticket_system/data/models/users.dart';
import 'package:gigabyte_ticket_system/features/task/presentation/pages/addTask.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen(this.user, {Key? key}) : super(key: key);
  final User? user;
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            logger.w(widget.user);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddTask(
                          user: widget.user,
                        )));
          },
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 80.0),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tasks',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Welcome ' + widget.user!.username.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }
            //task widget
            return Task(
              index: index,
            );
          },
          itemCount: 10,
        ));
  }
}

class Task extends StatelessWidget {
  const Task({
    required this.index,
    Key? key,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          ListTile(
            title: Text('Task Title'),
            subtitle: Text('High - pending'),
            trailing: Checkbox(
              value: true,
              onChanged: (value) {
                print(value);
              },
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
