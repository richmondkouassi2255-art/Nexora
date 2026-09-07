import 'package:flutter/material.dart';

import 'app_breakpoints.dart';

extension ResponsiveExtensions on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  bool get isMobile {
    return screenWidth < AppBreakpoints.mobile;
  }

  bool get isTablet {
    return screenWidth >= AppBreakpoints.mobile &&
        screenWidth < AppBreakpoints.tablet;
  }

  bool get isDesktop {
    return screenWidth >= AppBreakpoints.tablet;
  }

  bool get isLargeDesktop {
    return screenWidth >= AppBreakpoints.desktop;
  }
}
