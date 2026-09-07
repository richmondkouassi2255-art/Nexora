import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';

class CreateMomentCard extends StatelessWidget {
  const CreateMomentCard({
    super.key,
    this.onCreateTap,
    this.onPhotoTap,
    this.onVideoTap,
    this.onTextTap,
    this.onMoodTap,
    this.onLocationTap,
    this.onMusicTap,
  });

  final VoidCallback? onCreateTap;
  final VoidCallback? onPhotoTap;
  final VoidCallback? onVideoTap;
  final VoidCallback? onTextTap;
  final VoidCallback? onMoodTap;
  final VoidCallback? onLocationTap;
  final VoidCallback? onMusicTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
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
        children: [
          Row(
            children: [
              const _Avatar(),
              const SizedBox(width: AppSpacing.md),
              const Expanded(
                child: Text(
                  'Quoi de neuf sur Nexora ?',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _CreateButton(
                onTap: onCreateTap,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Divider(
            color: AppColors.border,
            height: 1,
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              _MomentAction(
                icon: Icons.photo_camera_outlined,
                label: 'Photo',
                color: const Color(0xFF5B21B6),
                onTap: onPhotoTap,
              ),
              _MomentAction(
                icon: Icons.videocam_outlined,
                label: 'Vidéo',
                color: const Color(0xFFDC2626),
                onTap: onVideoTap,
              ),
              _MomentAction(
                icon: Icons.edit_outlined,
                label: 'Texte',
                color: const Color(0xFFF59E0B),
                onTap: onTextTap,
              ),
              _MomentAction(
                icon: Icons.sentiment_satisfied_alt_outlined,
                label: 'Humeur',
                color: const Color(0xFFF59E0B),
                onTap: onMoodTap,
              ),
              _MomentAction(
                icon: Icons.location_on_outlined,
                label: 'Lieu',
                color: const Color(0xFF16A34A),
                onTap: onLocationTap,
              ),
              _MomentAction(
                icon: Icons.music_note_outlined,
                label: 'Musique',
                color: const Color(0xFF5B21B6),
                onTap: onMusicTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF6D28D9),
            Color(0xFF312E81),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Text(
        'P',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 52,
          height: 52,
          child: Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class _MomentAction extends StatelessWidget {
  const _MomentAction({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.small,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
