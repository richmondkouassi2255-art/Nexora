import 'package:flutter/material.dart';

import 'app_breakpoints.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        if (width >= AppBreakpoints.tablet) {
          return desktop ?? tablet ?? mobile;
        }

        if (width >= AppBreakpoints.mobile) {
          return tablet ?? mobile;
        }

        return mobile;
      },
    );
  }
}
