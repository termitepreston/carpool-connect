import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/providers/auth_provider.dart';
import '../features/authentication/screens/splash_screen.dart';
import '../features/authentication/screens/sign_in_screen.dart';
import '../features/authentication/screens/phone_verification_screen.dart';
import '../features/authentication/screens/profile_setup_screen.dart';
import '../features/authentication/screens/tos_screen.dart';
import '../features/authentication/screens/privacy_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/home/screens/main_shell_screen.dart';
import '../features/home/screens/about_screen.dart';
import '../features/activities/screens/activities_screen.dart';
import '../features/wallet/screens/wallet_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../features/chat/screens/chat_screen.dart';
import '../features/safety/screens/safety_screen.dart';
import '../features/driver/screens/offer_ride_screen.dart';
import '../features/driver/screens/manage_requests_screen.dart';
import '../features/activities/screens/rate_ride_screen.dart';
import '../features/activities/screens/active_trip_screen.dart';
import '../features/profile/screens/document_verification_screen.dart';
import '../features/profile/screens/deactivate_account_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/sign-in',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignInScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeInOut))),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/verify-otp',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: PhoneVerificationScreen(
            phone: state.uri.queryParameters['phone'] ?? '',
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeInOut))),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/setup-profile',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ProfileSetupScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/tos',
        builder: (context, state) => const TermsOfServiceScreen(),
      ),
      GoRoute(
        path: '/privacy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShellScreen(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/activities',
            builder: (context, state) => const ActivitiesScreen(),
          ),
          GoRoute(
            path: '/wallet',
            builder: (context, state) => const WalletScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => ChatScreen(recipientName: state.uri.queryParameters['name'] ?? 'User'),
      ),
      GoRoute(
        path: '/safety',
        builder: (context, state) => const SafetyScreen(),
      ),
      GoRoute(
        path: '/offer-ride',
        builder: (context, state) => const OfferRideScreen(),
      ),
      GoRoute(
        path: '/manage-requests',
        builder: (context, state) => const ManageRequestsScreen(),
      ),
      GoRoute(
        path: '/rate-ride',
        builder: (context, state) => const RateRideScreen(),
      ),
      GoRoute(
        path: '/verification',
        builder: (context, state) => const DocumentVerificationScreen(),
      ),
      GoRoute(
        path: '/deactivate',
        builder: (context, state) => const DeactivateAccountScreen(),
      ),
      GoRoute(
        path: '/active-trip',
        builder: (context, state) => const ActiveTripScreen(),
      ),
    ],
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      if (authState is AsyncLoading) return null;
      final isAuthenticated = authState.value != null;

      final isSplash = state.uri.toString() == '/splash';
      final isSignIn = state.uri.toString() == '/sign-in';
      final isVerify = state.uri.toString().startsWith('/verify-otp');
      final isSetup = state.uri.toString() == '/setup-profile';
      final isLegal = state.uri.toString() == '/tos' || state.uri.toString() == '/privacy';

      if (isSplash) {
        return isAuthenticated ? '/home' : '/sign-in';
      }

      if (!isAuthenticated && !isSignIn && !isVerify && !isLegal) {
        return '/sign-in';
      }

      if (isAuthenticated && (isSignIn || isVerify || isSplash || isSetup)) {
        if (authState.value?.name == 'New User') {
          if (!isSetup) return '/setup-profile';
          return null; // Stay on setup profile
        }
        // If they are authenticated and have a name, go to home
        return '/home';
      }

      return null;
    },
  );

  ref.listen(authProvider, (previous, next) {
    router.refresh();
  });

  return router;
}
