import 'package:go_router/go_router.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ],
    redirect: (context, state) {
      // For now, always allow navigation. Add auth logic later.
      return null;
    },
  );
}
