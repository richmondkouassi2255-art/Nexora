import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';

enum AppButtonVariant {
  primary,
  secondary,
  ghost,
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    final Widget child = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.white,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(label),
            ],
          );

    final ButtonStyle style;

    switch (variant) {
      case AppButtonVariant.primary:
        style = FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.45),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.medium,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
        );

      case AppButtonVariant.secondary:
        style = OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.medium,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
        );

      case AppButtonVariant.ghost:
        style = TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.medium,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
        );
    }

    final Widget button = switch (variant) {
      AppButtonVariant.primary => FilledButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: child,
        ),
      AppButtonVariant.secondary => OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: child,
        ),
      AppButtonVariant.ghost => TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: child,
        ),
    };

    if (!expand) {
      return button;
    }

    return SizedBox(
      width: double.infinity,
      child: button,
    );
  }
}
