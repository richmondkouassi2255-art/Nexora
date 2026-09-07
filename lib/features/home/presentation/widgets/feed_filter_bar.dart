import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';

class FeedFilterBar extends StatefulWidget {
  const FeedFilterBar({
    super.key,
    this.initialIndex = 0,
    this.onChanged,
  });

  final int initialIndex;
  final ValueChanged<int>? onChanged;

  @override
  State<FeedFilterBar> createState() => _FeedFilterBarState();
}

class _FeedFilterBarState extends State<FeedFilterBar> {
  static const _filters = [
    _FeedFilter(
      label: 'Pour vous',
    ),
    _FeedFilter(
      label: 'Abonnements',
    ),
    _FeedFilter(
      label: 'Amis',
    ),
    _FeedFilter(
      label: 'Tendances',
    ),
    _FeedFilter(
      label: 'Découvrir',
      icon: Icons.explore_outlined,
      highlighted: true,
    ),
  ];

  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex.clamp(0, _filters.length - 1);
  }

  void _selectFilter(int index) {
    if (_selectedIndex == index) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    widget.onChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: _filters.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = index == _selectedIndex;

          return _FeedFilterButton(
            filter: filter,
            isSelected: isSelected,
            onTap: () => _selectFilter(index),
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
                    colors: [
                      Color(0xFFEC4899),
                      Color(0xFF7C3AED),
                    ],
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
                : Border.all(
                    color: AppColors.border,
                  ),
            boxShadow: isDiscover
                ? [
                    BoxShadow(
                      color: const Color(0xFF7C3AED)
                          .withValues(alpha: 0.22),
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
                Icon(
                  filter.icon,
                  size: 18,
                  color: Colors.white,
                ),
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
    required this.label,
    this.icon,
    this.highlighted = false,
  });

  final String label;
  final IconData? icon;
  final bool highlighted;
}
