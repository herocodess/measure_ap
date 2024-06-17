import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle w500Style(
    double size,
    Color color, {
    TextDecoration? decoration,
    double? height,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
      fontStyle: fontStyle,
      height: height ?? 1.02,
      decoration: decoration,
    );
  }

  static TextStyle w600Style(
    double size,
    Color color, {
    TextDecoration? decoration,
    double? height,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w600,
      fontStyle: fontStyle,
      height: height ?? 1.02,
      decoration: decoration,
    );
  }

  static TextStyle w700Style(
    double size,
    Color color, {
    TextDecoration? decoration,
    double? height,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w700,
      fontStyle: fontStyle,
      height: height ?? 1.02,
      decoration: decoration,
    );
  }

  static TextStyle w800Style(
    double size,
    Color color, {
    TextDecoration? decoration,
    double? height,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w800,
      fontStyle: fontStyle,
      height: height ?? 1.02,
      decoration: decoration,
    );
  }
}
