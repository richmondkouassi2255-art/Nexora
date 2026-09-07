import 'package:flutter/material.dart';

abstract final class AppRadius {
  AppRadius._();

  static const double xs = 6;
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 24;
  static const double pill = 999;

  static const BorderRadius small = BorderRadius.all(
    Radius.circular(sm),
  );

  static const BorderRadius medium = BorderRadius.all(
    Radius.circular(md),
  );

  static const BorderRadius large = BorderRadius.all(
    Radius.circular(lg),
  );

  static const BorderRadius extraLarge = BorderRadius.all(
    Radius.circular(xl),
  );
}
