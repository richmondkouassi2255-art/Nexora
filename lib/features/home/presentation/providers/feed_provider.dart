import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/local_feed_repository.dart';
import '../../domain/models/moment.dart';

final localFeedRepositoryProvider = Provider<LocalFeedRepository>((ref) {
  return LocalFeedRepository();
});

final feedControllerProvider =
    NotifierProvider<FeedController, FeedState>(
  FeedController.new,
);

class FeedState {
  const FeedState({
    required this.moments,
    this.selectedFeed = MomentFeed.forYou,
  });

  final List<Moment> moments;
  final MomentFeed selectedFeed;

  List<Moment> get visibleMoments {
    return moments
        .where(
          (moment) => moment.feedTypes.contains(selectedFeed),
        )
        .toList();
  }

  FeedState copyWith({
    List<Moment>? moments,
    MomentFeed? selectedFeed,
  }) {
    return FeedState(
      moments: moments ?? this.moments,
      selectedFeed: selectedFeed ?? this.selectedFeed,
    );
  }
}

class FeedController extends Notifier<FeedState> {
  @override
  FeedState build() {
    final repository = ref.read(localFeedRepositoryProvider);

    return FeedState(
      moments: repository.getMoments(),
    );
  }

  void selectFeed(MomentFeed feed) {
    state = state.copyWith(
      selectedFeed: feed,
    );
  }

  void createMoment({
    required String content,
  }) {
    final trimmedContent = content.trim();

    if (trimmedContent.isEmpty) {
      return;
    }

    final moment = Moment(
      id: 'moment-${DateTime.now().microsecondsSinceEpoch}',
      authorName: 'Pierre',
      username: 'pierre',
      avatarInitials: 'P',
      content: trimmedContent,
      timeAgo: 'À l’instant',
      reactions: 0,
      comments: 0,
      shares: 0,
      feedTypes: const [
        MomentFeed.forYou,
        MomentFeed.following,
        MomentFeed.friends,
      ],
    );

    state = state.copyWith(
      moments: [
        moment,
        ...state.moments,
      ],
    );
  }

  void toggleLike(String momentId) {
    final moments = state.moments.map((moment) {
      if (moment.id != momentId) {
        return moment;
      }

      final liked = !moment.isLiked;

      return moment.copyWith(
        isLiked: liked,
        reactions: liked
            ? moment.reactions + 1
            : moment.reactions - 1,
      );
    }).toList();

    state = state.copyWith(
      moments: moments,
    );
  }

  void addComment(String momentId) {
    final moments = state.moments.map((moment) {
      if (moment.id != momentId) {
        return moment;
      }

      return moment.copyWith(
        comments: moment.comments + 1,
      );
    }).toList();

    state = state.copyWith(
      moments: moments,
    );
  }

  void share(String momentId) {
    final moments = state.moments.map((moment) {
      if (moment.id != momentId) {
        return moment;
      }

      return moment.copyWith(
        shares: moment.shares + 1,
      );
    }).toList();

    state = state.copyWith(
      moments: moments,
    );
  }

  void hideMoment(String momentId) {
    final moments = state.moments
        .where((moment) => moment.id != momentId)
        .toList();

    state = state.copyWith(
      moments: moments,
    );
  }
}
