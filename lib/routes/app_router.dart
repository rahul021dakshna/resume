import 'package:go_router/go_router.dart';
import '../presentation/screens/dashboard_screen.dart';
import '../presentation/screens/onboarding_screen.dart';
import '../presentation/screens/resume_builder_screen.dart';
import '../presentation/screens/resume_preview_screen.dart';
import '../presentation/screens/settings_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/builder/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ResumeBuilderScreen(resumeId: id);
        },
      ),
      GoRoute(
        path: '/preview/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ResumePreviewScreen(resumeId: id);
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
