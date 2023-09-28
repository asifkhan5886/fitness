import 'package:flutter/services.dart';

class AppValidation {
  static String? checkEmailValidation(String? text) {
    if (text == null) {
      return 'Please enter your email.';
    } else if (text.isEmpty || text.trim().isEmpty) {
      return 'Please enter your email.';
    } else if (emailValidationPattern(value: text)) {
      return 'Please enter valid email.';
    } else {
      return null;
    }
  }

  static emailValidationPattern({required String value}) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return !regExp.hasMatch(value);
  }

  static String? checkPhoneNumberValidation(String? text) {
    if (text == null) {
      return 'Please enter your phone number.';
    } else if (text.isEmpty || text.trim().isEmpty) {
      return 'Please enter your phone number.';
    } else {
      return null;
    }
  }

  static String? nameValidator(String? text) {
    if (text == null) {
      return 'Please enter your name.';
    } else if (text.trim().isEmpty) {
      return 'Please enter your name.';
    }
    // else if(nameValidationPattern(text)){
    //   return 'space, number & special character are not allowed';
    // }
    else {
      return null;
    }
  }

  static String? ageValidator(String? value) {
    if (value != null && value.isEmpty) {
      return 'Please enter your age.';
    }
    int? age = int.tryParse(value!);
    if (age == null || age < 0 || age > 120) {
      return 'Please enter a valid age.';
    }
    return null;
  }

  static String? heightValidator(String? value) {
    if (value != null && value.isEmpty) {
      return 'Please enter your height';
    }
    try {
      double height = double.parse(value!);
      if (height <= 0 || height > 300) {
        return 'Please enter a valid height';
      }
    } catch (e) {
      return 'Please enter a valid number';
    }
    return null;
  }

  static final RegExp _weightRegex = RegExp(
      r'^\d{0,3}(\.\d{0,2})?$'); // Allows up to 3 digits and optional 2 decimal places

  static String? weightValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a weight';
    }
    if (!_weightRegex.hasMatch(value)) {
      return 'Please enter a valid weight';
    }
    return null;
  }

  static List<TextInputFormatter> nameFormatters() {
    return [
      FilteringTextInputFormatter.allow(
        RegExp("[a-zA-Z]"),
      ),
      LengthLimitingTextInputFormatter(20),
    ];
  }

  static List<TextInputFormatter> fullNameFormatters() {
    return [
      FilteringTextInputFormatter.allow(
        RegExp("[a-z A-Z]"),
      ),
      LengthLimitingTextInputFormatter(30),
    ];
  }

  static bool nameValidationPattern(String text) {
    String pattern = r'^[0-9_\-=@,\.;]$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(text);
  }

  static List<TextInputFormatter> phoneNumberFormatters() {
    return [
      FilteringTextInputFormatter.allow(
        RegExp("[0-9]"),
      ),
      LengthLimitingTextInputFormatter(10),
    ];
  }

  static List<TextInputFormatter> numberFormatters() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(3),
    ];
  }
}
