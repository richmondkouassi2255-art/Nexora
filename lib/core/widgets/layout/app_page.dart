import 'package:flutter/material.dart';

import '../../../app/theme/app_spacing.dart';
import '../../constants/app_layout.dart';
import '../../responsive/responsive_extensions.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.child,
    this.padding,
    this.scrollable = true,
    this.maxWidth = AppLayout.contentMaxWidth,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool scrollable;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        context.isDesktop ? AppSpacing.xxxl : AppSpacing.lg;

    final content = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      child: child,
    );

    final paddedContent = Padding(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: AppSpacing.xxl,
          ),
      child: Align(
        alignment: Alignment.topCenter,
        child: content,
      ),
    );

    if (!scrollable) {
      return SafeArea(
        child: paddedContent,
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: paddedContent,
      ),
    );
  }
}
