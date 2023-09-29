import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//! numbers
extension AppNumberExtension on num {
  //* BorderRadius
  BorderRadius get radius => BorderRadius.circular(toDouble().r);
  BorderRadius get circular => BorderRadius.all(Radius.circular(toDouble().r));

  //* Padding
  EdgeInsets get allPadding => EdgeInsets.all(toDouble().w);
  EdgeInsets get vPadding => EdgeInsets.symmetric(vertical: toDouble().h);
  EdgeInsets get hPadding => EdgeInsets.symmetric(horizontal: toDouble().r);

//* Divider
  Divider get divider => Divider(height: toDouble());
  VerticalDivider get vDivider => VerticalDivider(width: toDouble());
}

//! ContextExtension
extension ContextExtension on BuildContext {
  TextStyle get displayLargeH1 => Theme.of(this).textTheme.displayLarge!;
  TextStyle get displayMediumH2 => Theme.of(this).textTheme.displayMedium!;
  TextStyle get titleMediumS1 =>  Theme.of(this).textTheme.titleMedium!;

 
}

//! WidgetExtension
extension WidgetExtension on Widget {
  Widget hPadding(double padding) => Padding(padding: EdgeInsets.symmetric(horizontal: padding.w), child: this);
  Widget vPadding(double padding) => Padding(padding: EdgeInsets.symmetric(vertical: padding.h), child: this);
  Widget allPadding(double padding) => Padding(padding: EdgeInsets.all(padding.r), child: this);
  Widget center() => Center(child: this);
}

//! StringExtension
extension StringExtension on String {
  bool hasMatch(String pattern) {
    return RegExp(pattern).hasMatch(this);
  }

  bool isEmail() {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }

  /*
      https://stackoverflow.com/questions/5142103/regex-to-validate-password-strength

       ^                         Start anchor
      (?=.*[A-Z].*[A-Z])        Ensure string has two uppercase letters.
      (?=.*[!@#$&*])            Ensure string has one special case letter.
      (?=.*[0-9].*[0-9])        Ensure string has two digits.
      (?=.*[a-z].*[a-z].*[a-z]) Ensure string has three lowercase letters.
      .{8}                      Ensure string is of length 8.
      $                         End anchor.
   */
  bool isValidPassword() {
    return RegExp(r"^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$").hasMatch(this);
  }
}
