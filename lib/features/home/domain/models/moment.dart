import 'package:flutter/material.dart';

enum MomentFeed { forYou, following, friends, trending, discover }

class Moment {
  const Moment({
    required this.id,
    required this.authorName,
    required this.username,
    required this.avatarInitials,
    required this.content,
    required this.timeAgo,
    required this.reactions,
    required this.comments,
    required this.shares,
    required this.feedTypes,
    this.mediaColor,
    this.isLiked = false,
  });

  final String id;
  final String authorName;
  final String username;
  final String avatarInitials;
  final String content;
  final String timeAgo;
  final int reactions;
  final int comments;
  final int shares;
  final List<MomentFeed> feedTypes;
  final Color? mediaColor;
  final bool isLiked;

  Moment copyWith({
    String? id,
    String? authorName,
    String? username,
    String? avatarInitials,
    String? content,
    String? timeAgo,
    int? reactions,
    int? comments,
    int? shares,
    List<MomentFeed>? feedTypes,
    Color? mediaColor,
    bool? isLiked,
  }) {
    return Moment(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      username: username ?? this.username,
      avatarInitials: avatarInitials ?? this.avatarInitials,
      content: content ?? this.content,
      timeAgo: timeAgo ?? this.timeAgo,
      reactions: reactions ?? this.reactions,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      feedTypes: feedTypes ?? this.feedTypes,
      mediaColor: mediaColor ?? this.mediaColor,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
