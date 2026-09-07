import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/widgets/layout/app_page.dart';
import '../widgets/create_moment_card.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_feed_section.dart';
import '../widgets/stories_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openSpaces(BuildContext context) {
    context.push(AppRoutes.spaces);
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      builder: (context) {
        return const _NotificationsSheet();
      },
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      builder: (context) {
        return const _HomeMenuSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeAppBar(
          onNotificationsTap: () => _showNotifications(context),
          onSpacesTap: () => _openSpaces(context),
          onMenuTap: () => _showMenu(context),
        ),
        Expanded(
          child: AppPage(
            padding: EdgeInsets.symmetric(
              horizontal: context.isDesktop
                  ? AppSpacing.xxxl
                  : AppSpacing.lg,
              vertical: AppSpacing.xxl,
            ),
            child: _HomeContent(
              isDesktop: context.isDesktop,
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.isDesktop,
  });

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      return const _DesktopHomeContent();
    }

    return const _MobileHomeContent();
  }
}

class _MobileHomeContent extends StatelessWidget {
  const _MobileHomeContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Accueil',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        CreateMomentCard(
          onCreateTap: () {},
          onPhotoTap: () {},
          onVideoTap: () {},
          onTextTap: () {},
          onMoodTap: () {},
          onLocationTap: () {},
          onMusicTap: () {},
        ),
        const SizedBox(height: AppSpacing.xxl),
        StoriesSection(
          onSeeAllTap: () {},
          onAddStoryTap: () {},
        ),
        const SizedBox(height: AppSpacing.xxl),
        const HomeFeedSection(),
      ],
    );
  }
}

class _DesktopHomeContent extends StatelessWidget {
  const _DesktopHomeContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: _DesktopMainColumn(),
        ),
        const SizedBox(width: AppSpacing.xxl),
        const SizedBox(
          width: 300,
          child: _DesktopSidePanel(),
        ),
      ],
    );
  }
}

class _DesktopMainColumn extends StatelessWidget {
  const _DesktopMainColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Accueil',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 34,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        CreateMomentCard(
          onCreateTap: () {},
          onPhotoTap: () {},
          onVideoTap: () {},
          onTextTap: () {},
          onMoodTap: () {},
          onLocationTap: () {},
          onMusicTap: () {},
        ),
        const SizedBox(height: AppSpacing.xxl),
        StoriesSection(
          onSeeAllTap: () {},
          onAddStoryTap: () {},
        ),
        const SizedBox(height: AppSpacing.xxl),
        const HomeFeedSection(),
      ],
    );
  }
}

class _DesktopSidePanel extends StatelessWidget {
  const _DesktopSidePanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SidePanelCard(
          title: 'Tendances',
          children: const [
            _TrendingItem(
              title: 'Flutter',
              subtitle: '12,4 k discussions',
            ),
            _TrendingItem(
              title: 'Intelligence artificielle',
              subtitle: '8,7 k discussions',
            ),
            _TrendingItem(
              title: 'Développement Web',
              subtitle: '5,2 k discussions',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _SidePanelCard(
          title: 'À découvrir',
          children: const [
            _TrendingItem(
              title: 'Flutter Developers',
              subtitle: 'Space · 24 k membres',
            ),
            _TrendingItem(
              title: 'AI Builders',
              subtitle: 'Space · 18 k membres',
            ),
          ],
        ),
      ],
    );
  }
}

class _SidePanelCard extends StatelessWidget {
  const _SidePanelCard({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...children,
        ],
      ),
    );
  }
}

class _TrendingItem extends StatelessWidget {
  const _TrendingItem({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationsSheet extends StatelessWidget {
  const _NotificationsSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.xxl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notifications',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const _NotificationItem(
              icon: Icons.favorite_rounded,
              iconColor: AppColors.error,
              title: 'Maya a réagi à ton Moment',
              subtitle: 'Il y a 8 min',
            ),
            const SizedBox(height: AppSpacing.md),
            const _NotificationItem(
              icon: Icons.people_rounded,
              iconColor: AppColors.primary,
              title: 'Kevin a commencé à te suivre',
              subtitle: 'Il y a 32 min',
            ),
            const SizedBox(height: AppSpacing.md),
            const _NotificationItem(
              icon: Icons.auto_awesome_rounded,
              iconColor: AppColors.warning,
              title: 'Nexora AI a une suggestion pour toi',
              subtitle: 'Il y a 1 h',
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 21,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeMenuSheet extends StatelessWidget {
  const _HomeMenuSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MenuItem(
              icon: Icons.search_rounded,
              title: 'Explorer',
              onTap: () {
                Navigator.of(context).pop();
                context.push(AppRoutes.explore);
              },
            ),
            _MenuItem(
              icon: Icons.groups_rounded,
              title: 'Spaces',
              onTap: () {
                Navigator.of(context).pop();
                context.push(AppRoutes.spaces);
              },
            ),
            _MenuItem(
              icon: Icons.settings_outlined,
              title: 'Paramètres',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            _MenuItem(
              icon: Icons.help_outline_rounded,
              title: 'Aide et support',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppSpacing.xs,
      ),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: AppRadius.medium,
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textMuted,
      ),
      onTap: onTap,
    );
  }
}
