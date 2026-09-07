import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/layout/app_page.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  static const List<_Friend> _friends = [
    _Friend(
      name: 'Maya Johnson',
      username: '@maya',
      initials: 'MJ',
      mutualFriends: 12,
      color: Color(0xFF6C3BFF),
    ),
    _Friend(
      name: 'Kevin Martin',
      username: '@kevin',
      initials: 'KM',
      mutualFriends: 8,
      color: Color(0xFF0EA5E9),
    ),
    _Friend(
      name: 'Ava Williams',
      username: '@ava',
      initials: 'AW',
      mutualFriends: 5,
      color: Color(0xFFEC4899),
    ),
    _Friend(
      name: 'Alex Morgan',
      username: '@alex',
      initials: 'AM',
      mutualFriends: 3,
      color: Color(0xFF22C55E),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: ListView(
        children: [
          const SizedBox(height: AppSpacing.lg),
          const Text(
            'Amis',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Découvre les personnes avec qui partager tes passions.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          TextField(
            decoration: InputDecoration(
              hintText: 'Rechercher des amis',
              prefixIcon: const Icon(Icons.search_rounded),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: AppRadius.large,
                borderSide: const BorderSide(
                  color: AppColors.border,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppRadius.large,
                borderSide: const BorderSide(
                  color: AppColors.border,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          const Text(
            'Suggestions pour toi',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ..._friends.map(
            (friend) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _FriendCard(friend: friend),
            ),
          ),
        ],
      ),
    );
  }
}

class _FriendCard extends StatelessWidget {
  const _FriendCard({
    required this.friend,
  });

  final _Friend friend;

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
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: friend.color,
            child: Text(
              friend.initials,
              style: const TextStyle(
                color: Colors.white,
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
                  friend.name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  friend.username,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${friend.mutualFriends} amis en commun',
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.medium,
              ),
            ),
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }
}

class _Friend {
  const _Friend({
    required this.name,
    required this.username,
    required this.initials,
    required this.mutualFriends,
    required this.color,
  });

  final String name;
  final String username;
  final String initials;
  final int mutualFriends;
  final Color color;
}
