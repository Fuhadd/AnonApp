import 'package:anon/screens/dashboard/dashboard_screen.dart';
import 'package:anon/screens/onboarding/onboarding_page_view.dart';
import 'package:anon/style/custom_theme.dart';
import 'package:anon/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'locator.dart';
import 'screens/startup/splash_screen.dart';
import 'utils/navigator_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();
  FlutterBranchSdk.validateSDKIntegration();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      navigatorKey: locator<NavigationHandler>().navigatorKey,
      title: 'Wisper',
      theme: AppTheme.defaultAppTheme,
      // home: const CommunityCreateScreen(),
      // home: const OnboardingPageViewScreen(),
      // home: const AuthScreen(
      //   authType: AuthType.signIn,
      // ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            } else if (snapshot.hasData) {
              return const DashboardScreen();
            } else {
              return const OnboardingPageViewScreen();
            }
          }),
    );
  }
}
