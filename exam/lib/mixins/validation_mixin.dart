class ValidationMixin {
  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(value!)) {
      return null;
    }
    return "Email should have user@email.com format.";
  }

  String? validateName(String? value) {
    String pattern = "^[a-zA-Z]{3,10}\$";
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(value!)) return null;
    return "User a correct name.";
  }

  String? validateBirth(String? value) {
    dynamic input = "Enter date.";
    if (value!.length != 0) return null;

    return input;
  }

  String? validatePhone(String? value) {
    dynamic input = "Input a correct phone number.";
    if (value!.length == 11) {
      input = null;
    }

    return input;
  }

  String? validateAddress(String? value) {
    dynamic input = "Address must at least have 8 characters";
    if (value!.length >= 8) input = null;
    return input;
  }

  String? validateHome(String? value) {
    dynamic input = "Enter a correct address";
    if (value!.length > 7) input = null;

    return input;
  }

  String? validatePassword(String? value) {
    // String pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(value!)) {
      return null;
    }
    return "Password should have at least 1 uppercase, lowercase, digit, special char. and at least 8 chars.";
  }

  String? validateConfirmPassword(String? password) {
    if (this.validatePassword(password)!.length == 0) {
      return null;
    }
    return "Make sure confirm password is the same as password.";
  }
}
