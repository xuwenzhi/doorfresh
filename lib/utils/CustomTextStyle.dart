import 'package:flutter/material.dart';

class CustomTextStyle {
  static var textFormFieldRegular = TextStyle(
      fontSize: 16,
      fontFamily: "BalsamiqSans",
      color: Colors.black,
      fontWeight: FontWeight.w400);

  static var textFormFieldLight =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w200);

  static var textFormFieldMedium =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w500);

  static var textFormFieldSemiBold =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w600);

  static var textFormFieldBold =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w700);

  static var textFormFieldBlack =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w900);

  static Color hexToColor(String code) {
    return new Color(int.parse(code, radix: 16) + 0xFF000000);
  }
}
