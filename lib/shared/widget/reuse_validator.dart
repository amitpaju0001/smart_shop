
import 'package:smart_shop/shared/string_const.dart';

class ReuseValidator {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return StringConst.signValidUser;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return StringConst.signValidEmail;
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return StringConst.signValidPhone;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return StringConst.signValidPass;
    }
    return null;
  }
}
