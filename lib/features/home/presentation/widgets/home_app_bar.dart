import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    this.onNotificationsTap,
    this.onSpacesTap,
    this.onMenuTap,
  });

  final VoidCallback? onNotificationsTap;
  final VoidCallback? onSpacesTap;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          const _NexoraBrand(),
          const Spacer(),
          _AppBarAction(
            icon: Icons.notifications_none_rounded,
            badge: '1',
            onTap: onNotificationsTap,
          ),
          const SizedBox(width: AppSpacing.md),
          _AppBarAction(icon: Icons.grid_view_rounded, onTap: onSpacesTap),
          const SizedBox(width: AppSpacing.md),
          _SpacesAction(onTap: onSpacesTap),
          const SizedBox(width: AppSpacing.md),
          _AppBarAction(icon: Icons.menu_rounded, onTap: onMenuTap),
        ],
      ),
    );
  }
}

class _NexoraBrand extends StatelessWidget {
  const _NexoraBrand();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6D28D9), Color(0xFF2E0BAA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: AppRadius.medium,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'N',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        const Text(
          'Nexora',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _AppBarAction extends StatelessWidget {
  const _AppBarAction({required this.icon, this.badge, this.onTap});

  final IconData icon;
  final String? badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon, size: 30, color: AppColors.textPrimary),
        ),
        if (badge != null)
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              width: 19,
              height: 19,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _SpacesAction extends StatelessWidget {
  const _SpacesAction({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.medium,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.travel_explore_rounded,
            color: AppColors.primary,
            size: 28,
          ),
          SizedBox(height: 2),
          Text(
            'Spaces',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
