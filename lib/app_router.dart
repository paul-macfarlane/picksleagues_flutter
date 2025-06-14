import 'package:go_router/go_router.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/create_league_page.dart';
import 'pages/join_league_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/create-league',
        builder: (context, state) => const CreateLeaguePage(),
      ),
      GoRoute(
        path: '/join-league',
        builder: (context, state) => const JoinLeaguePage(),
      ),
    ],
    redirect: (context, state) {
      // For now, always allow navigation. Add auth logic later.
      return null;
    },
  );
}
