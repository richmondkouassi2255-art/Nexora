import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/responsive/responsive_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    this.onSearchTap,
    this.onNotificationsTap,
    this.onMessagesTap,
  });

  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onMessagesTap;

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop) {
      return _DesktopHomeHeader(
        onSearchTap: onSearchTap,
        onNotificationsTap: onNotificationsTap,
        onMessagesTap: onMessagesTap,
      );
    }

    return _MobileHomeHeader(
      onSearchTap: onSearchTap,
      onNotificationsTap: onNotificationsTap,
      onMessagesTap: onMessagesTap,
    );
  }
}

class _MobileHomeHeader extends StatelessWidget {
  const _MobileHomeHeader({
    this.onSearchTap,
    this.onNotificationsTap,
    this.onMessagesTap,
  });

  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onMessagesTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'NEXORA',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ),
          _HeaderIconButton(icon: Icons.search_rounded, onTap: onSearchTap),
          const SizedBox(width: AppSpacing.sm),
          _HeaderIconButton(
            icon: Icons.notifications_none_rounded,
            onTap: onNotificationsTap,
          ),
          const SizedBox(width: AppSpacing.sm),
          _HeaderIconButton(
            icon: Icons.chat_bubble_outline_rounded,
            onTap: onMessagesTap,
          ),
        ],
      ),
    );
  }
}

class _DesktopHomeHeader extends StatelessWidget {
  const _DesktopHomeHeader({
    this.onSearchTap,
    this.onNotificationsTap,
    this.onMessagesTap,
  });

  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onMessagesTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onSearchTap,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 42,
                constraints: const BoxConstraints(maxWidth: 520),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search_rounded, color: AppColors.textSecondary),
                    SizedBox(width: AppSpacing.sm),
                    Text(
                      'Rechercher sur Nexora',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _HeaderIconButton(
            icon: Icons.notifications_none_rounded,
            onTap: onNotificationsTap,
          ),
          const SizedBox(width: AppSpacing.sm),
          _HeaderIconButton(
            icon: Icons.chat_bubble_outline_rounded,
            onTap: onMessagesTap,
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceSecondary,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
