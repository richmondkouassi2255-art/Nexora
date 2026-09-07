import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection({
    super.key,
    this.onSeeAllTap,
    this.onAddStoryTap,
  });

  final VoidCallback? onSeeAllTap;
  final VoidCallback? onAddStoryTap;

  static const _stories = [
    _StoryData(name: 'Maya', initials: 'M'),
    _StoryData(name: 'Kevin', initials: 'K'),
    _StoryData(name: 'Ava', initials: 'A'),
    _StoryData(name: 'Alex', initials: 'A'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Stories',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: onSeeAllTap,
              child: const Text(
                'Voir tout',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 205,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: _stories.length + 1,
            separatorBuilder: (_, __) =>
                const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _AddStoryCard(
                  onTap: onAddStoryTap,
                );
              }

              final story = _stories[index - 1];

              return _StoryCard(
                story: story,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AddStoryCard extends StatelessWidget {
  const _AddStoryCard({
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.large,
      child: Container(
        width: 122,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.large,
          border: Border.all(
            color: AppColors.border,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Ajouter',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'une Story',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    required this.story,
  });

  final _StoryData story;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 122,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2E1065),
            Color(0xFF111827),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: AppRadius.large,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: AppRadius.large,
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.75),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: AppSpacing.sm,
            left: AppSpacing.sm,
            right: AppSpacing.sm,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFA855F7),
                    Color(0xFF6D28D9),
                    Color(0xFFEC4899),
                  ],
                ),
              ),
              child: CircleAvatar(
                radius: 32,
                backgroundColor: const Color(0xFF312E81),
                child: Text(
                  story.initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: AppSpacing.md,
            bottom: AppSpacing.md,
            child: Row(
              children: [
                Text(
                  story.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF22C55E),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryData {
  const _StoryData({
    required this.name,
    required this.initials,
  });

  final String name;
  final String initials;
}
