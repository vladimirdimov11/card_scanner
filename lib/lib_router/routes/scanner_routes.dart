part of '../router.dart';

@immutable
class ScannerBranchData extends StatefulShellBranchData {
  const ScannerBranchData();
}

@immutable
class ScannerRoute extends GoRouteData implements RouteDataModel {
  const ScannerRoute();

  @override
  Page<Function> buildPage(BuildContext context, GoRouterState state) =>
      MaterialPage(
        key: state.pageKey,
        child: const ScannerPageWithDependencies(),
      );

  @override
  String get permissionName => RouteModel.scanner.permissionName;

  @override
  String get routeLocation => location;
}

@immutable
class SuccessRoute extends GoRouteData implements RouteDataModel {
  const SuccessRoute();

  @override
  Page<Function> buildPage(BuildContext context, GoRouterState state) =>
      MaterialPage(
        key: state.pageKey,
        child: const SuccessPageWithDependencies(),
      );

  @override
  String get permissionName => RouteModel.success.permissionName;

  @override
  String get routeLocation => location;
}
