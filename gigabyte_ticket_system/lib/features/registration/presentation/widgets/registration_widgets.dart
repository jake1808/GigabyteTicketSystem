import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gigabyte_ticket_system/features/login/presentation/pages/loginPage.dart';
import 'package:gigabyte_ticket_system/features/registration/presentation/registrationBloc/registration_bloc.dart';
import 'package:gigabyte_ticket_system/features/task/presentation/pages/task_screen.dart';

class MyForm extends StatefulWidget {
  MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _surNameFocusNode = FocusNode();
  final _companyNameFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _regionFocusNode = FocusNode();
  final _userNameFocusNode = FocusNode();

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
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        context.read<RegistrationBloc>().add(NameUnfocused());
      }
    });
    _surNameFocusNode.addListener(() {
      if (!_surNameFocusNode.hasFocus) {
        context.read<RegistrationBloc>().add(SurNameUnfocused());
      }
    });
    _companyNameFocusNode.addListener(() {
      if (!_companyNameFocusNode.hasFocus) {
        context.read<RegistrationBloc>().add(CompanyNameUnfocused());
      }
    });
    _addressFocusNode.addListener(() {
      if (!_addressFocusNode.hasFocus) {
        context.read<RegistrationBloc>().add(AddressUnfocused());
      }
    });
    _cityFocusNode.addListener(() {
      if (!_cityFocusNode.hasFocus) {
        context.read()<RegistrationBloc>().add(CityUnfocused());
      }
    });
    _regionFocusNode.addListener(() {
      if (!_regionFocusNode.hasFocus) {
        context.read()<RegistrationBloc>().add(RegionUnfocused());
      }
    });
    _userNameFocusNode.addListener(() {
      if (!_userNameFocusNode.hasFocus) {
        context.read()<RegistrationBloc>().add(UserNameUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();
    _nameFocusNode.dispose();
    _surNameFocusNode.dispose();
    _companyNameFocusNode.dispose();
    _addressFocusNode.dispose();
    _cityFocusNode.dispose();
    _regionFocusNode.dispose();
    _userNameFocusNode.dispose();
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
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog(context: context, builder: (_) => FailureDialog());
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NameInput(focusNode: _nameFocusNode),
                SurNameInput(focusNode: _surNameFocusNode),
                UserNameInput(focusNode: _userNameFocusNode),
                EmailInput(focusNode: _emailFocusNode),
                PasswordInput(focusNode: _passwordFocusNode),
                CompanyInput(focusNode: _companyNameFocusNode),
                AddressInput(focusNode: _addressFocusNode),
                CityInput(focusNode: _cityFocusNode),
                RegionInput(focusNode: _regionFocusNode),
                PhoneInput(focusNode: _phoneFocusNode),
                SubmitButton(),
                LoginButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CityInput extends StatelessWidget {
  const CityInput({Key? key, required this.focusNode}) : super(key: key);
  final focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.city.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.location_city),
            labelText: 'City',
            helperText: 'Please enter your city',
            errorText: state.city.invalid
                ? 'Make sure it is 4-10 characters long and does not contain special characters'
                : null,
          ),
          onChanged: (value) {
            context.read<RegistrationBloc>().add(CityChanged(city: value));
          },
        );
      },
    );
  }
}

class RegionInput extends StatelessWidget {
  const RegionInput({Key? key, required this.focusNode}) : super(key: key);
  final focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.region.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.location_city),
            labelText: 'Region',
            helperText: 'Please enter your region',
            errorText: state.city.invalid
                ? 'Make sure it is 4-10 characters long and does not contain special characters'
                : null,
          ),
          onChanged: (value) {
            context.read<RegistrationBloc>().add(RegionChanged(region: value));
          },
        );
      },
    );
  }
}

class SurNameInput extends StatelessWidget {
  const SurNameInput({Key? key, required this.focusNode}) : super(key: key);
  final focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.surName.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            labelText: 'Surname',
            helperText: 'Please enter your Surname',
            errorText: state.surName.invalid
                ? 'Make sure it is 4-10 characters long and does not contain special characters'
                : null,
          ),
          onChanged: (value) {
            context
                .read<RegistrationBloc>()
                .add(SurNameChanged(surName: value));
          },
        );
      },
    );
  }
}

class UserNameInput extends StatelessWidget {
  const UserNameInput({Key? key, required this.focusNode}) : super(key: key);
  final focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.userName.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            labelText: 'User Name',
            helperText: 'Please enter your UserName',
            errorText: state.userName.invalid
                ? 'Make sure it is 4-10 characters long and does not contain special characters'
                : null,
          ),
          onChanged: (value) {
            context
                .read<RegistrationBloc>()
                .add(UserNameChanged(userName: value));
          },
        );
      },
    );
  }
}

class CompanyInput extends StatelessWidget {
  const CompanyInput({Key? key, required this.focusNode}) : super(key: key);
  final focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.company.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.add_business_outlined),
            labelText: 'company',
            helperText: 'Please enter your company',
            errorText: state.company.invalid
                ? 'Make sure it is 4-10 characters long and does not contain special characters'
                : null,
          ),
          onChanged: (value) {
            context
                .read<RegistrationBloc>()
                .add(CompanyNameChanged(compayName: value));
          },
        );
      },
    );
  }
}

class AddressInput extends StatelessWidget {
  const AddressInput({Key? key, required this.focusNode}) : super(key: key);
  final focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.address.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.alternate_email),
            labelText: 'Address',
            helperText: 'Please enter your Address',
            errorText: state.company.invalid
                ? 'Make sure it is a valid address'
                : null,
          ),
          onChanged: (value) {
            context
                .read<RegistrationBloc>()
                .add(AddressChanged(address: value));
          },
        );
      },
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({Key? key, required this.focusNode}) : super(key: key);
  final focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.name.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            labelText: 'Name',
            helperText: 'Please enter your name',
            errorText: state.name.invalid
                ? 'Make sure it is 4-10 characters long and does not contain special characters'
                : null,
          ),
          onChanged: (value) {
            context.read<RegistrationBloc>().add(NameChanged(name: value));
          },
        );
      },
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
          // maxLength: 11,
          initialValue: '${state.phone.value}',
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.phone),
            labelText: 'Phone Number',
            helperText: 'Enter a valid turkish number starting with 09.',
            errorText:
                state.phone.invalid ? 'Please use a turkish number' : null,
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
          onPressed: () {
            context.read<RegistrationBloc>().add(FormSubmitted());
          },
          child: const Text('Submit'),
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: const Text('Login'),
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
                      'new user made',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            BlocProvider(
              create: (context) => RegistrationBloc(),
              child: BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (context, state) {
                  return ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskScreen(state.user)));
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
