import 'package:anon/screens/dashboard/dashboard_screen.dart';

import '../screens/communities/communities_details_screen.dart';
import '../screens/onboarding/first_onboarding_page.dart';
import '../screens/onboarding/second_onboarding_page.dart';
import '../screens/onboarding/third_onboarding_page.dart';

var appRoutes = {
  FirstOnboardingPage.routeName: (context) => const FirstOnboardingPage(),
  SecondOnboardingPage.routeName: (context) => const SecondOnboardingPage(),
  ThirdOnboardingPage.routeName: (context) => const ThirdOnboardingPage(),
  DashboardScreen.routeName: (context) => const DashboardScreen(),
  CommunitiesDetailsScreen.routeName: (context) =>
      const CommunitiesDetailsScreen(),

  // AuthScreen.routeName: (context) => const AuthScreen(),
};
