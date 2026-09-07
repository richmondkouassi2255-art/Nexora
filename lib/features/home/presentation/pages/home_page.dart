import 'package:flutter/material.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/widgets/layout/app_page.dart';
import '../widgets/create_moment_card.dart';
import '../widgets/feed_filter_bar.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/moment_card.dart';
import '../widgets/stories_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeAppBar(
          onNotificationsTap: () {},
          onSpacesTap: () {},
          onMenuTap: () {},
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
      return _DesktopHomeContent();
    }

    return _MobileHomeContent();
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
        const FeedFilterBar(),
        const SizedBox(height: AppSpacing.xl),
        const MomentCard(
          authorName: 'Maya Johnson',
          username: 'maya',
          avatarInitials: 'MJ',
          timeAgo: 'Il y a 2 h',
          content:
              'Je viens de terminer mon nouveau projet Flutter. '
              'Hâte de partager ce que j’ai appris avec la communauté Nexora !',
          reactions: 124,
          comments: 24,
          shares: 8,
          mediaColor: Color(0xFF4C1D95),
        ),
        const SizedBox(height: AppSpacing.lg),
        const MomentCard(
          authorName: 'Kevin Martin',
          username: 'kevin',
          avatarInitials: 'KM',
          timeAgo: 'Il y a 4 h',
          content:
              'Quelle technologie aimeriez-vous apprendre cette semaine ? '
              'Partagez vos objectifs avec la communauté.',
          reactions: 86,
          comments: 17,
          shares: 4,
        ),
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
        Expanded(
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
        const FeedFilterBar(),
        const SizedBox(height: AppSpacing.xl),
        const MomentCard(
          authorName: 'Maya Johnson',
          username: 'maya',
          avatarInitials: 'MJ',
          timeAgo: 'Il y a 2 h',
          content:
              'Je viens de terminer mon nouveau projet Flutter. '
              'Hâte de partager ce que j’ai appris avec la communauté Nexora !',
          reactions: 124,
          comments: 24,
          shares: 8,
          mediaColor: Color(0xFF4C1D95),
        ),
        const SizedBox(height: AppSpacing.lg),
        const MomentCard(
          authorName: 'Kevin Martin',
          username: 'kevin',
          avatarInitials: 'KM',
          timeAgo: 'Il y a 4 h',
          content:
              'Quelle technologie aimeriez-vous apprendre cette semaine ? '
              'Partagez vos objectifs avec la communauté.',
          reactions: 86,
          comments: 17,
          shares: 4,
        ),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
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
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
