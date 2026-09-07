import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/models/moment.dart';
import '../providers/feed_provider.dart';
import 'feed_filter_bar.dart';
import 'moment_card.dart';

class HomeFeedSection extends ConsumerWidget {
  const HomeFeedSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(feedControllerProvider);
    final controller = ref.read(feedControllerProvider.notifier);
    final moments = feedState.visibleMoments;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FeedFilterBar(
          selectedFeed: feedState.selectedFeed,
          onChanged: controller.selectFeed,
        ),
        const SizedBox(height: AppSpacing.xl),
        if (moments.isEmpty)
          const _EmptyFeed()
        else
          ..._buildMoments(
            context,
            ref,
            moments,
          ),
      ],
    );
  }

  List<Widget> _buildMoments(
    BuildContext context,
    WidgetRef ref,
    List<Moment> moments,
  ) {
    return [
      for (int index = 0; index < moments.length; index++) ...[
        MomentCard(
          authorName: moments[index].authorName,
          username: moments[index].username,
          avatarInitials: moments[index].avatarInitials,
          timeAgo: moments[index].timeAgo,
          content: moments[index].content,
          reactions: moments[index].reactions,
          comments: moments[index].comments,
          shares: moments[index].shares,
          mediaColor: moments[index].mediaColor,
          isLiked: moments[index].isLiked,
          onLikeTap: () {
            ref
                .read(feedControllerProvider.notifier)
                .toggleLike(moments[index].id);
          },
          onCommentTap: () {
            ref
                .read(feedControllerProvider.notifier)
                .addComment(moments[index].id);

            _showCommentFeedback(context);
          },
          onShareTap: () {
            ref
                .read(feedControllerProvider.notifier)
                .share(moments[index].id);

            _showShareFeedback(context);
          },
          onMoreTap: () {
            _showMomentMenu(context, moments[index]);
          },
        ),
        if (index < moments.length - 1)
          const SizedBox(height: AppSpacing.lg),
      ],
    ];
  }

  void _showCommentFeedback(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Commentaire ajouté à ton activité.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _showShareFeedback(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Moment partagé.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _showMomentMenu(
    BuildContext context,
    Moment moment,
  ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      builder: (context) {
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
                ListTile(
                  leading: const Icon(
                    Icons.bookmark_border_rounded,
                    color: AppColors.primary,
                  ),
                  title: const Text('Enregistrer'),
                  onTap: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Moment enregistré.',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    'Voir le profil de ${moment.authorName}',
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.visibility_off_outlined,
                    color: AppColors.textSecondary,
                  ),
                  title: const Text(
                    'Masquer ce Moment',
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Moment masqué.',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmptyFeed extends StatelessWidget {
  const _EmptyFeed();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.explore_outlined,
            size: 44,
            color: AppColors.primary,
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            'Rien à afficher pour le moment',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Découvre de nouvelles personnes et communautés.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
