class LoginStrings {
  LoginStrings._();
  static const String login = 'Login';
  static const String lowText1 = 'Not Yet Joined, ';
  static const String lowText2 = 'Sign Up Now';
  static const String authenticated = 'Authenticated';
  static const String wrongPass = 'Wrong PassWord';
  static const String noMatch = 'No match found';
}

class CommonStrings {
  CommonStrings._();
  static const String emptyString = '';
  static const String mailId = 'Mail Id';
  static const String password = 'PassWord';
  static const String submit = 'Submit';
  static const String update = 'Update';
  static const String upload = 'Upload';
  static const String cancel = 'Cancel';
  static const String books = 'books';
  static const String stationary = 'stationery';
  static const String getIt = 'Get It Now';
}

class ErrorText {
  ErrorText._();
  static const String reqField = 'This Field is required';
  static const String reqMail = 'Enter a valid email address';
  static const String reqPass = 'Password is required';
  static const String eightDigit = 'Password must be at least 8 digits long';
  static const String specialChar =
      'Passwords must have at least one special character';
}

class SignUpStrings {
  SignUpStrings._();
  static const String mailExist = 'This mail id already exist. Try Logining in';
  static const String signUp = 'Sign Up';
  static const String name = 'Name';
  static const String collegeName = 'College Name';
  static const String lowText1 = 'Already Joined, ';
  static const String lowText2 = 'Login Now';
}

class ProfileStrings {
  ProfileStrings._();
  static const String profile = 'Profile';
  static const String updateName = 'Update Your Name';
  static const String name = 'Your Name';
  static const String note = 'Changes will reflect after some time';
  static const String editPro = 'Edit Profile';
  static const String sendMail = 'Send a Mail';
  static const String emailSub = 'Came accross your profile';
}

class UploadStrings {
  UploadStrings._();
  static const String donateStr = 'Donate Something!!!';
  static const String catchyStr =
      'Get a chance to make a relationship with your juniors';
  static const String chooseImg = 'Choose an Image';
  static const String selectImg = 'Please Select an Image';
}

class SingleProductStrings {
  SingleProductStrings._();
  static const String title = 'Product';
}

class NotificationPageStrings {
  NotificationPageStrings._();
  static const String title = 'Notifications';
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
