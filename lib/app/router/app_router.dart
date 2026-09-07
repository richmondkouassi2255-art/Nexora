import 'package:go_router/go_router.dart';

import '../../core/widgets/layout/app_shell.dart';
import '../../features/explore/presentation/pages/explore_page.dart';
import '../../features/friends/presentation/pages/friends_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/messages/presentation/pages/messages_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/spaces/presentation/pages/spaces_page.dart';
import '../../features/video/presentation/pages/video_page.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: AppRoutes.explore.substring(1),
                  builder: (context, state) => const ExplorePage(),
                ),
                GoRoute(
                  path: AppRoutes.spaces.substring(1),
                  builder: (context, state) => const SpacesPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.friends,
              builder: (context, state) => const FriendsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.video,
              builder: (context, state) => const VideoPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.messages,
              builder: (context, state) => const MessagesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
