import 'package:flutter/material.dart';
import 'package:gigabyte_ticket_system/data/datasources/DataBase.dart';
import 'package:gigabyte_ticket_system/data/models/task.dart';
import 'package:gigabyte_ticket_system/data/models/users.dart';
import 'package:gigabyte_ticket_system/features/task/presentation/pages/addTask.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen(this.user, {Key? key}) : super(key: key);
  final User? user;
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late Future<List<Task>> _taskList;
  bool status = false;

  @override
  void initState() {
    super.initState();

    updateTaskList();
  }

  updateTaskList() async {
    setState(() {
      _taskList = DBhelper.db.getTaskList();
    });
    logger.w(_taskList);
  }

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
        body: FutureBuilder(
          future: _taskList,
          builder: (context, AsyncSnapshot<List<Task>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 80.0),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Tasks',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              child: Icon(Icons.refresh),
                              onTap: updateTaskList,
                            )
                          ],
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
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onLongPress: snapshot.data![index - 1].status ==
                                'complete'
                            ? null
                            : () {
                                logger.w('delete');
                                DBhelper.db
                                    .deleteTask(snapshot.data![index - 1].id);
                                updateTaskList();
                              },
                        child: ListTile(
                          title: Text(
                            snapshot.data![index - 1].request.toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          subtitle: Text(
                            '${snapshot.data![index - 1].urgencyLevel} - ${snapshot.data![index - 1].status}',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          onTap: () {
                            var temp = snapshot.data![index - 1];
                            logger.w(temp);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddTask(
                                  task: temp,
                                  user: widget.user,
                                ),
                              ),
                            );
                          },
                          trailing: snapshot.data![index - 1].status ==
                                  "pending"
                              ? Checkbox(
                                  value: status,
                                  onChanged: (value) {
                                    setState(() {
                                      status = value!;
                                      snapshot.data![index - 1].status =
                                          status ? "complete" : "pending";
                                    });

                                    DBhelper.db
                                        .updateTask(snapshot.data![index - 1]);
                                    updateTaskList();
                                  },
                                )
                              : null,
                        ),
                      ),
                      Divider()
                    ],
                  ),
                );
              },
              itemCount: 1 + snapshot.data!.length,
            );
          },
        ));
  }
}
