import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/layout/app_page.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  static const List<_VideoItem> _videos = [
    _VideoItem(
      title: 'Les nouveautés de Flutter',
      creator: 'Maya Johnson',
      initials: 'MJ',
      duration: '02:48',
      color: Color(0xFF4C1D95),
      views: '12,4 k vues',
    ),
    _VideoItem(
      title: 'Construire avec l’IA',
      creator: 'Kevin Martin',
      initials: 'KM',
      duration: '04:12',
      color: Color(0xFF0369A1),
      views: '8,7 k vues',
    ),
    _VideoItem(
      title: 'Mon workflow de développeur',
      creator: 'Ava Williams',
      initials: 'AW',
      duration: '03:26',
      color: Color(0xFF9D174D),
      views: '5,2 k vues',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: ListView(
        children: [
          const SizedBox(height: AppSpacing.lg),
          const Text(
            'Vidéo',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Découvre les vidéos qui correspondent à tes intérêts.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                _CategoryChip(
                  label: 'Pour toi',
                  selected: true,
                ),
                _CategoryChip(label: 'Tendances'),
                _CategoryChip(label: 'Flutter'),
                _CategoryChip(label: 'IA'),
                _CategoryChip(label: 'Design'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          ..._videos.map(
            (video) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: _VideoCard(video: video),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    this.selected = false,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) {},
        selectedColor: AppColors.primary,
        backgroundColor: AppColors.surface,
        side: const BorderSide(
          color: AppColors.border,
        ),
        labelStyle: TextStyle(
          color: selected ? Colors.white : AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  const _VideoCard({
    required this.video,
  });

  final _VideoItem video;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.large,
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: video.color,
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.play_circle_fill_rounded,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),
                  Positioned(
                    right: AppSpacing.md,
                    bottom: AppSpacing.md,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: AppRadius.small,
                      ),
                      child: Text(
                        video.duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: video.color,
                  child: Text(
                    video.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        video.creator,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        video.views,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz_rounded,
                    color: AppColors.textSecondary,
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

class _VideoItem {
  const _VideoItem({
    required this.title,
    required this.creator,
    required this.initials,
    required this.duration,
    required this.color,
    required this.views,
  });

  final String title;
  final String creator;
  final String initials;
  final String duration;
  final Color color;
  final String views;
}
