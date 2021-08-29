import 'dart:io';
import 'package:gigabyte_ticket_system/data/datasources/DataBase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:gigabyte_ticket_system/data/models/task.dart';
import 'package:gigabyte_ticket_system/data/models/users.dart';

class AddTask extends StatefulWidget {
  AddTask({this.task, this.user, key}) : super(key: key);
  final User? user;
  final Task? task;
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  File? _image;
  String status = '';

  String? base64Image;
  File? tmpFile;
  String errMessage = 'Error file to big';
  final _formkey = GlobalKey<FormState>();
  Task task = Task();
  final ImagePicker imagePicker = ImagePicker();
  var menuItems = ['HIGH', 'MEDIUM', 'LOW'];
  String current = 'HIGH';

  @override
  void initState() {
    if (widget.task != null) {
      task = widget.task!;
    } else {
      logger.w('hi');
    }

    super.initState();
  }

  // Future getImage() async {
  //   final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = (pickImage) as File?;
  //     Logger logger = Logger(printer: PrettyPrinter());
  //     logger.w('here+$_image');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    task.status == 'complete'
                        ? Text('')
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                DBhelper.db.deleteTask(task.id);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                    task.status == 'complete'
                        ? Text('')
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: null,
                              child: Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Icon(
                                  Icons.attach_file,
                                  size: 30,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  task.status == 'complete'
                      ? 'Task Complete'
                      : widget.task != null
                          ? 'Edit Task'
                          : 'Add Task',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Company name: ' +
                      widget.user!.companyname.toString() +
                      '\nBranch Location: ' +
                      widget.user!.city.toString() +
                      '\n Region: ' +
                      widget.user!.city.toString() +
                      '\n Address: ' +
                      widget.user!.address.toString() +
                      '\n Name: ' +
                      widget.user!.name.toString() +
                      '\n Surname: ' +
                      widget.user!.surname.toString() +
                      '\n Telephone: ' +
                      widget.user!.telephone.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Text(
                        'Priority',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      task.status == 'complete'
                          ? Text('${widget.task!.urgencyLevel}')
                          : DropdownButton(
                              icon: Icon(Icons.arrow_drop_down_circle),
                              iconSize: 22.0,
                              iconEnabledColor: Theme.of(context).primaryColor,
                              value: task.urgencyLevel,
                              items: menuItems.map((String item) {
                                return DropdownMenuItem(
                                  child: Text(item),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  current = value!;
                                  task.urgencyLevel = value;
                                });
                              },
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            labelText: 'Request',
                            labelStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          enabled: task.status == 'complete' ? false : true,
                          validator: (input) => input!.trim().isEmpty
                              ? 'Please enter a task title'
                              : null,
                          onChanged: (input) => task.request = input,
                          initialValue: task.request,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        child: TextFormField(
                          enabled: task.status == 'complete' ? false : true,
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 100),
                            labelText: 'Ticket Problem',
                            labelStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (input) => input!.trim().isEmpty
                              ? 'Please enter a problem description'
                              : null,
                          onChanged: (input) =>
                              task.ticketProblemDescription = input,
                          initialValue: task.ticketProblemDescription,
                        ),
                      ),
                      _image == null
                          ? Text('No image avilable')
                          : Image.file(
                              _image!,
                              fit: BoxFit.fill,
                            ),
                      task.status == "complete"
                          ? Text("")
                          : widget.task != null
                              ? ElevatedButton(
                                  onPressed: () {
                                    DBhelper.db.updateTask(task);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Update',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        task.branchCityName = widget.user!.city;
                                        task.company = widget.user!.companyname;
                                        task.companyAddress =
                                            widget.user!.address;
                                        task.email = widget.user!.email;
                                        task.name = widget.user!.name;
                                        task.region = widget.user!.region;
                                        task.surname = widget.user!.surname;
                                        task.telePhone = widget.user!.telephone;
                                        task.status = 'pending';
                                      });
                                      DBhelper.db.insertTask(task);
                                      Navigator.pop(context);
                                    }

                                    logger.w(task);
                                    logger.w(widget.user);
                                  },
                                  child: Text(
                                    'Add',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
