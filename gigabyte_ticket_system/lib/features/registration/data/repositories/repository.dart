import 'package:gigabyte_ticket_system/features/registration/data/datasources/datalink.dart';
import 'package:gigabyte_ticket_system/features/registration/data/models/users.dart';

class RegistrationRepository extends DataLinkRegistration {
  Future<bool> insetUser(User user) async {
    bool confirm = true;
    try {
      await DataLinkRegistration.registerUser(user);
      return confirm;
    } catch (e) {
      confirm = false;
      print(e);
      return confirm;
    }
  }
}
