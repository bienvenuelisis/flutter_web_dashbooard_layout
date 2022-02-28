import 'package:flutter/widgets.dart';

extension ResponiveUtil on BuildContext {
  Size get size => MediaQuery.of(this).size;

  double get width => size.width;

  double get height => size.height;

  bool get isXLarge => width > 1200;

  bool get isLarge => width > 600;

  bool get isMedium => width > 400 && width < 600;

  bool get isSmall => width < 400;

  bool get isXSmall => width < 800;

  bool get isPortrait => size.width < size.height;

  bool get isLandscape => size.width > size.height;

  T? getArgument<T>() {
    final modalRoute = ModalRoute.of(this);
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      if (args != null && args is T) {
        return args as T;
      }
    }
    return null;
  }
}
