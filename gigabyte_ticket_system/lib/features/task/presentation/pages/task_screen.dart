import 'package:flutter/material.dart';
import 'package:gigabyte_ticket_system/data/models/users.dart';

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
          onPressed: () => print('add task screen'),
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
                      'My Task',
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
                      '1 of 10',
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
            return Container(
              margin: EdgeInsets.all(10.0),
              height: 100,
              width: double.infinity,
              color: Colors.red,
            );
          },
          itemCount: 1,
        ));
  }
}
