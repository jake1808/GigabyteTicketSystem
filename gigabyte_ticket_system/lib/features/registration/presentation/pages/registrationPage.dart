import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigabyte_ticket_system/features/registration/presentation/bloc/registration_bloc.dart';
import 'package:gigabyte_ticket_system/features/registration/presentation/widgets/widgets.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => RegistrationBloc(),
        child: MyForm(),
      ),
    );
  }
}
