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
    return "Incorrect name format";
  }

  String? validatePassword(String? value) {
    // String pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(value!)) {
      return null;
    }
    return "Password should have at least 1 uppercase, lowercase, and digit and at least 8 chars.";
  }

  String? validateConfirmPassword(String? password) {
    if (this.validatePassword(password)!.length == 0) {
      return null;
    }
    return "Make sure confirm password is the same as password.";
  }
}
