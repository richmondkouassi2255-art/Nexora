import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/models/moment.dart';

class FeedFilterBar extends StatelessWidget {
  const FeedFilterBar({
    super.key,
    required this.selectedFeed,
    required this.onChanged,
  });

  final MomentFeed selectedFeed;
  final ValueChanged<MomentFeed> onChanged;

  static const List<_FeedFilter> _filters = [
    _FeedFilter(feed: MomentFeed.forYou, label: 'Pour vous'),
    _FeedFilter(feed: MomentFeed.following, label: 'Abonnements'),
    _FeedFilter(feed: MomentFeed.friends, label: 'Amis'),
    _FeedFilter(feed: MomentFeed.trending, label: 'Tendances'),
    _FeedFilter(
      feed: MomentFeed.discover,
      label: 'Découvrir',
      icon: Icons.explore_outlined,
      highlighted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: _filters.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: AppSpacing.sm);
        },
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = filter.feed == selectedFeed;

          return _FeedFilterButton(
            filter: filter,
            isSelected: isSelected,
            onTap: () => onChanged(filter.feed),
          );
        },
      ),
    );
  }
}

class _FeedFilterButton extends StatelessWidget {
  const _FeedFilterButton({
    required this.filter,
    required this.isSelected,
    required this.onTap,
  });

  final _FeedFilter filter;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDiscover = filter.highlighted;

    return Material(
      color: Colors.transparent,
      borderRadius: AppRadius.medium,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.medium,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            gradient: isDiscover
                ? const LinearGradient(
                    colors: [Color(0xFFEC4899), Color(0xFF7C3AED)],
                  )
                : null,
            color: isDiscover
                ? null
                : isSelected
                ? AppColors.primary
                : AppColors.surface,
            borderRadius: AppRadius.medium,
            border: isDiscover || isSelected
                ? null
                : Border.all(color: AppColors.border),
            boxShadow: isDiscover
                ? [
                    BoxShadow(
                      color: const Color(0xFF7C3AED).withValues(alpha: 0.22),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (filter.icon != null) ...[
                Icon(filter.icon, size: 18, color: Colors.white),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(
                filter.label,
                style: TextStyle(
                  color: isSelected || isDiscover
                      ? Colors.white
                      : AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isDiscover) ...[
                const SizedBox(width: AppSpacing.xs),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: Colors.white,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedFilter {
  const _FeedFilter({
    required this.feed,
    required this.label,
    this.icon,
    this.highlighted = false,
  });

  final MomentFeed feed;
  final String label;
  final IconData? icon;
  final bool highlighted;
}
