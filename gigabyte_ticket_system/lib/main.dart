import 'package:flutter/material.dart';
import 'package:gigabyte_ticket_system/features/login/presentation/pages/loginPage.dart';
import 'package:gigabyte_ticket_system/features/registration/presentation/pages/registrationPage.dart';
import 'package:gigabyte_ticket_system/features/task/presentation/pages/task_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GigaByte ticket system',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/registration': (context) => RegistrationPage(),
        '/login': (context) => LoginPage(),
        '/taskScreen': (context) => TaskScreen(null),
      },
    );
  }
}
