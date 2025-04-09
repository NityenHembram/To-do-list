import 'package:flutter/material.dart';

extension AppTextStyles on BuildContext {
  TextStyle get title => Theme.of(this).textTheme.titleLarge!;
  TextStyle get body => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get subtle => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get lableMedium => Theme.of(this).textTheme.labelMedium!;
  TextStyle get lableSmall => Theme.of(this).textTheme.labelSmall!;
}