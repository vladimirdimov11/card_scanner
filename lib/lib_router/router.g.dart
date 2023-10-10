// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $scannerStatefulShellRoute,
    ];

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/splash',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location(
        '/splash',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $scannerStatefulShellRoute => StatefulShellRouteData.$route(
      factory: $ScannerStatefulShellRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/scanner',
              factory: $ScannerRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'success',
                  factory: $SuccessRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $ScannerStatefulShellRouteExtension on ScannerStatefulShellRoute {
  static ScannerStatefulShellRoute _fromState(GoRouterState state) =>
      const ScannerStatefulShellRoute();
}

extension $ScannerRouteExtension on ScannerRoute {
  static ScannerRoute _fromState(GoRouterState state) => const ScannerRoute();

  String get location => GoRouteData.$location(
        '/scanner',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SuccessRouteExtension on SuccessRoute {
  static SuccessRoute _fromState(GoRouterState state) => const SuccessRoute();

  String get location => GoRouteData.$location(
        '/scanner/success',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
