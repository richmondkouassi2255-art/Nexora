import 'package:flutter/material.dart';

import '../../domain/models/moment.dart';

class LocalFeedRepository {
  List<Moment> getMoments() {
    return const [
      Moment(
        id: 'moment-001',
        authorName: 'Maya Johnson',
        username: 'maya',
        avatarInitials: 'MJ',
        timeAgo: 'Il y a 2 h',
        content:
            'Je viens de terminer mon nouveau projet Flutter. '
            'Hâte de partager ce que j’ai appris avec la communauté Nexora !',
        reactions: 124,
        comments: 24,
        shares: 8,
        mediaColor: Color(0xFF4C1D95),
        feedTypes: [
          MomentFeed.forYou,
          MomentFeed.following,
          MomentFeed.trending,
        ],
      ),
      Moment(
        id: 'moment-002',
        authorName: 'Kevin Martin',
        username: 'kevin',
        avatarInitials: 'KM',
        timeAgo: 'Il y a 4 h',
        content:
            'Quelle technologie aimeriez-vous apprendre cette semaine ? '
            'Partagez vos objectifs avec la communauté.',
        reactions: 86,
        comments: 17,
        shares: 4,
        feedTypes: [
          MomentFeed.forYou,
          MomentFeed.friends,
          MomentFeed.following,
        ],
      ),
      Moment(
        id: 'moment-003',
        authorName: 'Ava Williams',
        username: 'ava',
        avatarInitials: 'AW',
        timeAgo: 'Il y a 5 h',
        content:
            'L’IA ne remplace pas la créativité. Elle nous donne surtout '
            'de nouveaux outils pour transformer nos idées en projets.',
        reactions: 213,
        comments: 38,
        shares: 21,
        mediaColor: Color(0xFF7C2D12),
        feedTypes: [
          MomentFeed.forYou,
          MomentFeed.trending,
          MomentFeed.discover,
        ],
      ),
      Moment(
        id: 'moment-004',
        authorName: 'Alex Carter',
        username: 'alex',
        avatarInitials: 'AC',
        timeAgo: 'Il y a 7 h',
        content:
            'Petit défi du jour : construisez quelque chose que vous '
            'n’avez jamais essayé auparavant et partagez votre progression.',
        reactions: 61,
        comments: 12,
        shares: 6,
        feedTypes: [MomentFeed.friends, MomentFeed.discover],
      ),
      Moment(
        id: 'moment-005',
        authorName: 'Sofia Brown',
        username: 'sofia',
        avatarInitials: 'SB',
        timeAgo: 'Il y a 9 h',
        content:
            'Notre communauté Flutter vient de franchir une nouvelle étape. '
            'Merci à toutes les personnes qui partagent leurs connaissances.',
        reactions: 176,
        comments: 31,
        shares: 14,
        mediaColor: Color(0xFF155E75),
        feedTypes: [
          MomentFeed.following,
          MomentFeed.trending,
          MomentFeed.discover,
        ],
      ),
    ];
  }
}
