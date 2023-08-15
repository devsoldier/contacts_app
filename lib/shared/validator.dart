import 'package:email_validator/email_validator.dart';

const kRequiredMessage = 'This is a required field.';

class Validator {
  static String? notBlank(String? value) {
    String? error;

    if (value == null || value.isEmpty) {
      error = kRequiredMessage;
    }

    return error;
  }

  static String? email(String? value) {
    String? error;

    if (value == null || value.isEmpty) {
      error = kRequiredMessage;
    } else if (!EmailValidator.validate(value)) {
      error = 'Please enter a valid email address.';
    }

    return error;
  }
}
