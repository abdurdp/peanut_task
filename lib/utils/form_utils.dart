import 'package:form_field_validator/form_field_validator.dart';

class FormUtils {
  // global validation
  static final globalValidator = MultiValidator([
    RequiredValidator(
        errorText:
            'FIELD REQUIRED'),
  ]);

  // password validation
  static final passwordValidator = MultiValidator([
    RequiredValidator(
        errorText: 'PASSWORD_FIELD_REQUIRED'),
  ]);

  static final loginNumberValidator = MultiValidator([
    RequiredValidator(
        errorText:
            'ENTER LOGIN NUMBER'),
  ]);
}
