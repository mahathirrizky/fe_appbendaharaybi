import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/pages.dart';


part 'route_name.dart';

// GoRouter configuration
final router = GoRouter(
  redirect: (context, state) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      return "/login";
    } else {
      return null;
    }
  },
  // errorBuilder: (context, state) => const Page404(),
  routes: [
    GoRoute(
      path: '/',
      name: Routes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/export',
      name: Routes.export,
      builder: (context, state) => const ExportPage(),
    ),
    GoRoute(
      path: '/login',
      name: Routes.login,
      builder: (context, state) => LoginPage(),
    ),
  ],
);
