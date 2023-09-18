part of '../router.dart';

@TypedGoRoute<SplashRoute>(path: RoutesPath.splash)
@immutable
class SplashRoute extends GoRouteData implements RouteDataModel {
  const SplashRoute();

  @override
  Page<Function> buildPage(BuildContext context, GoRouterState state) =>
      MaterialPage(
        key: state.pageKey,
        child: SplashPageWithDependencies(
          redirectToLocation: state.uri.queryParameters['from'],
        ),
      );

  @override
  String get permissionName => RouteModel.splash.permissionName;

  @override
  String get routeLocation => location;
}

@TypedStatefulShellRoute<ScannerStatefulShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<ScannerBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ScannerRoute>(path: RoutesPath.scanner, routes: [
          TypedGoRoute<SuccessRoute>(
            path: RoutesPath.success,
          ),
        ]),
      ],
    ),
  ],
)
@immutable
class ScannerStatefulShellRoute extends StatefulShellRouteData {
  const ScannerStatefulShellRoute();

  @override
  Page<void> pageBuilder(BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) =>
      MaterialPage(
        key: state.pageKey,
        child: navigationShell,
      );
}
