import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';

class MomentCard extends StatelessWidget {
  const MomentCard({
    super.key,
    required this.authorName,
    required this.username,
    required this.content,
    required this.timeAgo,
    required this.avatarInitials,
    this.reactions = 0,
    this.comments = 0,
    this.shares = 0,
    this.mediaColor,
    this.onLikeTap,
    this.onCommentTap,
    this.onShareTap,
    this.onMoreTap,
  });

  final String authorName;
  final String username;
  final String content;
  final String timeAgo;
  final String avatarInitials;

  final int reactions;
  final int comments;
  final int shares;

  /// Temporaire : remplacé plus tard par une vraie image/media.
  final Color? mediaColor;

  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onMoreTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.large,
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: Row(
              children: [
                _MomentAvatar(
                  initials: avatarInitials,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authorName,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '@$username · $timeAgo',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onMoreTap,
                  icon: const Icon(
                    Icons.more_horiz_rounded,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: Text(
              content,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),

          if (mediaColor != null) ...[
            const SizedBox(height: AppSpacing.lg),
            Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                color: mediaColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(0),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.image_outlined,
                  color: Colors.white.withValues(alpha: 0.65),
                  size: 52,
                ),
              ),
            ),
          ],

          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                _MomentAction(
                  icon: Icons.favorite_border_rounded,
                  label: reactions.toString(),
                  onTap: onLikeTap,
                ),
                const SizedBox(width: AppSpacing.lg),
                _MomentAction(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: comments.toString(),
                  onTap: onCommentTap,
                ),
                const SizedBox(width: AppSpacing.lg),
                _MomentAction(
                  icon: Icons.ios_share_rounded,
                  label: shares > 0 ? shares.toString() : 'Partager',
                  onTap: onShareTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MomentAvatar extends StatelessWidget {
  const _MomentAvatar({
    required this.initials,
  });

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF8B5CF6),
            Color(0xFF4F46E5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _MomentAction extends StatelessWidget {
  const _MomentAction({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.medium,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
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
