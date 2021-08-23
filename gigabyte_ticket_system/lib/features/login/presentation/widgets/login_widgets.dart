import 'package:flutter/material.dart';
import 'package:gigabyte_ticket_system/data/datasources/DataBase.dart';
import 'package:gigabyte_ticket_system/data/models/users.dart';
import 'package:gigabyte_ticket_system/features/login/presentation/bloc/login_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigabyte_ticket_system/features/registration/presentation/pages/registrationPage.dart';
import 'package:gigabyte_ticket_system/features/task/presentation/pages/task_screen.dart';
import 'package:logger/logger.dart';

class MyLoginForm extends StatefulWidget {
  MyLoginForm({Key? key}) : super(key: key);

  @override
  _MyLoginFormState createState() => _MyLoginFormState();
}

class _MyLoginFormState extends State<MyLoginForm> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<LoginBloc>().add(Emailunfocused());
        Focus.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<LoginBloc>().add(Passwordunfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          User user = state.user;

          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog(context: context, builder: (_) => SuccessDialog(user));
        }
        if (state.status.isSubmissionInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Submitting...'),
              ),
            );
        }
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog(context: context, builder: (_) => FailureDialog());
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmailInput(focusNode: _emailFocusNode),
              PasswordInput(focusNode: _passwordFocusNode),
              SubmitButton(),
              RegistrationButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationButton extends StatelessWidget {
  const RegistrationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RegistrationPage()));
      },
      child: const Text('Registration'),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.focusNode}) : super(key: key);
  final focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.email),
            labelText: 'Email',
            helperText: 'email@gmail.com',
            errorText: state.email.invalid ? 'please use a valid email' : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<LoginBloc>().add(Emailchanged(email: value));
          },
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.lock),
            helperText:
                'Password should be atleast 8 characters with atleast one number and one letter.',
            helperMaxLines: 2,
            labelText: 'Password',
            errorMaxLines: 2,
            errorText: state.password.invalid
                ? 'Password should be atleast 8 characters with atleast one number and one letter.'
                : null,
          ),
          obscureText: true,
          onChanged: (value) {
            context.read<LoginBloc>().add(Passwordchanged(password: value));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final User? user;

  SuccessDialog(this.user);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Icon(Icons.info),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            BlocProvider(
              create: (context) => LoginBloc(),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Logger logger = Logger(printer: PrettyPrinter());
                      logger.w(this.user);
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskScreen(this.user)));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FailureDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Icon(Icons.info),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'this users email exisits.',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context, FailureDialog());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () => context.read<LoginBloc>().add(Formsubmitted()),
          child: const Text('Submit'),
        );
      },
    );
  }
}
