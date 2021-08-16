part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  final Name name;
  final Email email;
  final Password password;
  final TelePhone phone;
  final SurName surName;
  final User user;
  final Address address;
  final CompanyName company;
  final CityName city;
  final RegionName region;
  final UserName userName;
  final FormzStatus status;

  RegistrationState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.user = const User(),
    this.phone = const TelePhone.pure(),
    this.surName = const SurName.pure(),
    this.company = const CompanyName.pure(),
    this.address = const Address.pure(),
    this.city = const CityName.pure(),
    this.region = const RegionName.pure(),
    this.userName = const UserName.pure(),
  });
  RegistrationState copywith({
    Name? name,
    Email? email,
    Password? password,
    FormzStatus? status,
    User? user,
    TelePhone? phone,
    SurName? surName,
    CompanyName? company,
    Address? address,
    CityName? city,
    RegionName? region,
    UserName? userName,
  }) {
    return RegistrationState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      user: user ?? this.user,
      surName: surName ?? this.surName,
      company: company ?? this.company,
      address: address ?? this.address,
      city: city ?? this.city,
      region: region ?? this.region,
      userName: userName ?? this.userName,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        status,
        user,
        name,
        phone,
        surName,
        company,
        address,
        city,
        region,
        userName,
      ];
}
