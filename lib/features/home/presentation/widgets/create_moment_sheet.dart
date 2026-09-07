import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/models/moment.dart';
import '../providers/feed_provider.dart';

class CreateMomentSheet extends ConsumerStatefulWidget {
  const CreateMomentSheet({
    super.key,
  });

  @override
  ConsumerState<CreateMomentSheet> createState() =>
      _CreateMomentSheetState();
}

class _CreateMomentSheetState
    extends ConsumerState<CreateMomentSheet> {
  final TextEditingController _controller =
      TextEditingController();

  final FocusNode _focusNode = FocusNode();

  bool _isPublishing = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get _canPublish {
    return _controller.text.trim().isNotEmpty &&
        !_isPublishing;
  }

  void _publish() {
    final content = _controller.text.trim();

    if (content.isEmpty || _isPublishing) {
      return;
    }

    setState(() {
      _isPublishing = true;
    });

    ref.read(feedControllerProvider.notifier).createMoment(
          content: content,
        );

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Ton Moment a été publié sur Nexora.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: MediaQuery.viewInsetsOf(context).bottom +
              AppSpacing.lg,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.primaryLight,
                    child: Text(
                      'P',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Publier un Moment',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Partage quelque chose avec Nexora',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary,
                  borderRadius: AppRadius.medium,
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  autofocus: true,
                  minLines: 5,
                  maxLines: 10,
                  maxLength: 500,
                  textCapitalization:
                      TextCapitalization.sentences,
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    hintText:
                        'Quoi de neuf sur Nexora ?',
                    hintStyle: TextStyle(
                      color: AppColors.textMuted,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.all(AppSpacing.lg),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const _ComposerOptions(),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  onPressed:
                      _canPublish ? _publish : null,
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        AppColors.primary,
                    disabledBackgroundColor:
                        AppColors.surfaceSecondary,
                    disabledForegroundColor:
                        AppColors.textMuted,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          AppRadius.medium,
                    ),
                  ),
                  icon: const Icon(
                    Icons.send_rounded,
                  ),
                  label: Text(
                    _isPublishing
                        ? 'Publication...'
                        : 'Publier le Moment',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ComposerOptions extends StatelessWidget {
  const _ComposerOptions();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: const [
        _ComposerOption(
          icon: Icons.photo_camera_outlined,
          label: 'Photo',
          color: Color(0xFF5B21B6),
        ),
        _ComposerOption(
          icon: Icons.videocam_outlined,
          label: 'Vidéo',
          color: Color(0xFFDC2626),
        ),
        _ComposerOption(
          icon: Icons.sentiment_satisfied_alt_outlined,
          label: 'Humeur',
          color: Color(0xFFF59E0B),
        ),
        _ComposerOption(
          icon: Icons.location_on_outlined,
          label: 'Lieu',
          color: Color(0xFF16A34A),
        ),
        _ComposerOption(
          icon: Icons.music_note_outlined,
          label: 'Musique',
          color: Color(0xFF5B21B6),
        ),
      ],
    );
  }
}

class _ComposerOption extends StatelessWidget {
  const _ComposerOption({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: AppRadius.small,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 19,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

void showCreateMomentSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    showDragHandle: true,
    builder: (_) => const CreateMomentSheet(),
  );
}
