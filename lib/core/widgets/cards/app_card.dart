import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: AppRadius.large,
        border: Border.all(
          color: borderColor ?? AppColors.border,
        ),
      ),
      child: child,
    );

    final interactiveCard = onTap == null
        ? card
        : Material(
            color: Colors.transparent,
            borderRadius: AppRadius.large,
            child: InkWell(
              onTap: onTap,
              borderRadius: AppRadius.large,
              child: card,
            ),
          );

    if (margin == null) {
      return interactiveCard;
    }

    return Padding(
      padding: margin!,
      child: interactiveCard,
    );
  }
}
