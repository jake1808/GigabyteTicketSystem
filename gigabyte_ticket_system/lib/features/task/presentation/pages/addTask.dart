import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:gigabyte_ticket_system/data/models/task.dart';
import 'package:gigabyte_ticket_system/data/models/users.dart';
import 'package:logger/logger.dart';

class AddTask extends StatefulWidget {
  AddTask({this.user, key}) : super(key: key);
  final User? user;
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
  final Task task = Task();
  final ImagePicker imagePicker = ImagePicker();
  var menuItems = ['HIGH', 'MEDIUM', 'LOW'];
  String current = 'HIGH';

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
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
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //   child: GestureDetector(
                  //     onTap: null,
                  //     child: Padding(
                  //       padding: EdgeInsets.only(top: 50),
                  //       child: Icon(
                  //         Icons.attach_file,
                  //         size: 30,
                  //         color: Theme.of(context).primaryColor,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Add Task',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      DropdownButton(
                        hint: Text('Please select an urgency level'),
                        value: current,
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
                      Request(task: task),
                      TicketProblem(task: task),
                      _image == null
                          ? Text('No image avilable')
                          : Image.file(
                              _image!,
                              fit: BoxFit.fill,
                            )
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class Request extends StatelessWidget {
  const Request({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: TextFormField(
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          labelText: 'Request',
          labelStyle: TextStyle(fontSize: 18.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (input) =>
            input!.trim().isEmpty ? 'Please enter a task title' : null,
        onSaved: (input) => task.request = input,
        initialValue: task.request,
      ),
    );
  }
}

class TicketProblem extends StatelessWidget {
  const TicketProblem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: TextFormField(
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 100),
          labelText: 'Ticket Problem',
          labelStyle: TextStyle(fontSize: 18.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (input) =>
            input!.trim().isEmpty ? 'Please enter a problem description' : null,
        onSaved: (input) => task.ticketProblemDescription = input,
        initialValue: task.request,
      ),
    );
  }
}
