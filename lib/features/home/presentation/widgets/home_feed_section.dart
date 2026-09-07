import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
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
            _showCommentsSheet(
              context,
              ref,
              moments[index],
            );
          },
          onShareTap: () {
            ref
                .read(feedControllerProvider.notifier)
                .share(moments[index].id);

            _showShareFeedback(context);
          },
          onMoreTap: () {
            _showMomentMenu(
              context,
              ref,
              moments[index],
            );
          },
        ),
        if (index < moments.length - 1)
          const SizedBox(height: AppSpacing.lg),
      ],
    ];
  }

  void _showCommentsSheet(
    BuildContext context,
    WidgetRef ref,
    Moment moment,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      builder: (_) {
        return _CommentsSheet(
          moment: moment,
          onCommentAdded: () {
            ref
                .read(feedControllerProvider.notifier)
                .addComment(moment.id);
          },
        );
      },
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
    WidgetRef ref,
    Moment moment,
  ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      builder: (sheetContext) {
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
                  title: const Text(
                    'Enregistrer',
                  ),
                  onTap: () {
                    Navigator.of(sheetContext).pop();

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
                    Navigator.of(sheetContext).pop();

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            'Profil de ${moment.authorName}.',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
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
                    Navigator.of(sheetContext).pop();

                    ref
                        .read(feedControllerProvider.notifier)
                        .hideMoment(moment.id);

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Moment masqué de ton fil.',
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

class _CommentsSheet extends StatefulWidget {
  const _CommentsSheet({
    required this.moment,
    required this.onCommentAdded,
  });

  final Moment moment;
  final VoidCallback onCommentAdded;

  @override
  State<_CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<_CommentsSheet> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<_LocalComment> _comments = [];

  @override
  void initState() {
    super.initState();

    for (int index = 0; index < widget.moment.comments; index++) {
      _comments.add(
        _LocalComment(
          authorName: _commentAuthor(index),
          initials: _commentInitials(index),
          text: _commentText(index),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _commentAuthor(int index) {
    const authors = [
      'Emma',
      'Lucas',
      'Sofia',
      'Noah',
      'Mia',
      'Léo',
    ];

    return authors[index % authors.length];
  }

  String _commentInitials(int index) {
    const initials = [
      'E',
      'L',
      'S',
      'N',
      'M',
      'L',
    ];

    return initials[index % initials.length];
  }

  String _commentText(int index) {
    const comments = [
      'Très intéressant !',
      'Merci pour ce partage.',
      'Je suis totalement d’accord.',
      'Super idée 👏',
      'Ça donne envie d’essayer.',
      'Belle publication !',
    ];

    return comments[index % comments.length];
  }

  void _submitComment() {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      _comments.add(
        _LocalComment(
          authorName: 'Pierre',
          initials: 'P',
          text: text,
          isCurrentUser: true,
        ),
      );
    });

    widget.onCommentAdded();

    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: bottomInset,
        ),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.78,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  0,
                  AppSpacing.lg,
                  AppSpacing.md,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: AppColors.primary,
                    ),
                    const SizedBox(
                      width: AppSpacing.sm,
                    ),
                    Expanded(
                      child: Text(
                        'Commentaires (${_comments.length})',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
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
              ),
              const Divider(
                height: 1,
                color: AppColors.border,
              ),
              Expanded(
                child: _comments.isEmpty
                    ? const _EmptyComments()
                    : ListView.separated(
                        padding: const EdgeInsets.all(
                          AppSpacing.lg,
                        ),
                        itemCount: _comments.length,
                        separatorBuilder: (_, __) {
                          return const SizedBox(
                            height: AppSpacing.lg,
                          );
                        },
                        itemBuilder: (context, index) {
                          return _CommentTile(
                            comment: _comments[index],
                          );
                        },
                      ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.sm,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    top: BorderSide(
                      color: AppColors.border,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const CircleAvatar(
                      radius: 19,
                      backgroundColor: AppColors.primaryLight,
                      child: Text(
                        'P',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: AppSpacing.sm,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        minLines: 1,
                        maxLines: 4,
                        textCapitalization:
                            TextCapitalization.sentences,
                        onSubmitted: (_) {
                          _submitComment();
                        },
                        decoration: InputDecoration(
                          hintText: 'Écrire un commentaire...',
                          filled: true,
                          fillColor:
                              AppColors.surfaceSecondary,
                          border: OutlineInputBorder(
                            borderRadius: AppRadius.large,
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: AppRadius.large,
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: AppRadius.large,
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: AppSpacing.sm,
                    ),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _controller,
                      builder: (context, value, _) {
                        final canSubmit =
                            value.text.trim().isNotEmpty;

                        return IconButton(
                          onPressed:
                              canSubmit ? _submitComment : null,
                          style: IconButton.styleFrom(
                            backgroundColor: canSubmit
                                ? AppColors.primary
                                : AppColors.surfaceSecondary,
                            foregroundColor: canSubmit
                                ? AppColors.white
                                : AppColors.textMuted,
                          ),
                          icon: const Icon(
                            Icons.send_rounded,
                            size: 19,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({
    required this.comment,
  });

  final _LocalComment comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: comment.isCurrentUser
              ? AppColors.primaryLight
              : AppColors.surfaceSecondary,
          child: Text(
            comment.initials,
            style: TextStyle(
              color: comment.isCurrentUser
                  ? AppColors.primary
                  : AppColors.textSecondary,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(
          width: AppSpacing.sm,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(
              AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: comment.isCurrentUser
                  ? AppColors.primaryLight
                  : AppColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.authorName,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.xs,
                ),
                Text(
                  comment.text,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.xs,
                ),
                const Text(
                  'À l’instant',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LocalComment {
  const _LocalComment({
    required this.authorName,
    required this.initials,
    required this.text,
    this.isCurrentUser = false,
  });

  final String authorName;
  final String initials;
  final String text;
  final bool isCurrentUser;
}

class _EmptyComments extends StatelessWidget {
  const _EmptyComments();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(
          AppSpacing.xxl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              size: 44,
              color: AppColors.primary,
            ),
            SizedBox(
              height: AppSpacing.md,
            ),
            Text(
              'Aucun commentaire',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: AppSpacing.xs,
            ),
            Text(
              'Sois la première personne à réagir à ce Moment.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyFeed extends StatelessWidget {
  const _EmptyFeed();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSpacing.xxl,
      ),
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
          SizedBox(
            height: AppSpacing.md,
          ),
          Text(
            'Rien à afficher pour le moment',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: AppSpacing.xs,
          ),
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
