import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigabyte_ticket_system/features/login/presentation/bloc/login_bloc.dart';
import 'package:gigabyte_ticket_system/features/login/presentation/widgets/login_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (_) => LoginBloc(),
      child: MyLoginForm(),
    ));
  }
}
