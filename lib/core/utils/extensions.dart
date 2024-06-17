import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

extension MediaQueryExtension on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
}

extension L10nExtensions on BuildContext {
  L10n get l10n => L10n.of(this);
}

extension WidgetUtilsX on Widget {
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget paddingSymmetric({double h = 0.0, double v = 0.0}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
        child: this,
      );

  Widget paddingOnly({double l = 0, double t = 0, double r = 0, double b = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: l, top: t, bottom: b, right: r),
      child: this,
    );
  }
}
