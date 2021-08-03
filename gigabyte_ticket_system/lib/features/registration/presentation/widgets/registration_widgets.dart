import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigabyte_ticket_system/features/registration/presentation/bloc/registration_bloc.dart';
import 'package:formz/formz.dart';

class MyForm extends StatefulWidget {
  MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<RegistrationBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<RegistrationBloc>().add(PasswordUnfocused());
      }
    });
    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) {
        context.read<RegistrationBloc>().add(PhoneUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog(
            context: context,
            builder: (_) => SuccessDialog(),
          );
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
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmailInput(focusNode: _emailFocusNode),
            PasswordInput(focusNode: _passwordFocusNode),
            PhoneInput(focusNode: _phoneFocusNode),
            SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.focusNode}) : super(key: key);
  final focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
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
            context.read<RegistrationBloc>().add(EmailChanged(email: value));
          },
        );
      },
    );
  }
}

class PhoneInput extends StatelessWidget {
  const PhoneInput({Key? key, required this.focusNode}) : super(key: key);
  final focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.phone.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.phone),
            labelText: 'Phone Number',
            helperText: 'Enter a valid turkish number.',
            errorText:
                state.password.invalid ? 'Please use a turkish number' : null,
          ),
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            context.read<RegistrationBloc>().add(PhoneChanged(phone: value));
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
    return BlocBuilder<RegistrationBloc, RegistrationState>(
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
            context
                .read<RegistrationBloc>()
                .add(PasswordChanged(password: value));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValid
              ? () => context.read<RegistrationBloc>().add(FormSubmitted())
              : null,
          child: const Text('Submit'),
        );
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
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
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Null,
            ),
          ],
        ),
      ),
    );
  }
}
