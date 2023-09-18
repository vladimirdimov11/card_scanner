// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../feature_splash/services/splash_service.dart';
import '../../lib_card_scanner/card_scanner_service.dart';
import '../../lib_change_language/bloc/change_language_bloc.dart';
import '../../lib_change_language/data_sources/language_local_data_source.dart';
import '../../lib_change_language/repositories/language_repository.dart';
import '../../lib_change_language/services/app_language_service.dart';
import '../../lib_permissions/data_sources/remote/permissions_remote_data_source.dart';
import '../../lib_permissions/repositories/permissions_repository.dart';
import '../../lib_permissions/services/permissions_service.dart';
import '../../lib_router/blocs/router_bloc.dart';
import '../../lib_router/router.dart';
import '../app/config/environment_config.dart';
import '../common_blocs/coordinator_bloc.dart';
import '../common_mappers/error_mappers/error_mapper.dart';
import '../common_services/card_service.dart';
import '../data_sources/local/shared_preferences_instance.dart';
import '../data_sources/remote/card_data_source.dart';
import '../data_sources/remote/http_clients/api_http_client.dart';
import '../data_sources/remote/http_clients/plain_http_client.dart';
import '../repositories/card_repository.dart';

class CardScannerWithDependencies extends StatefulWidget {
  const CardScannerWithDependencies({
    required this.config,
    required this.child,
    Key? key,
  }) : super(key: key);

  final EnvironmentConfig config;
  final Widget child;

  @override
  State<CardScannerWithDependencies> createState() =>
      _CardScannerWithDependenciesState();
}

class _CardScannerWithDependenciesState
    extends State<CardScannerWithDependencies> {
  late GlobalKey<NavigatorState> rootNavigatorKey;

  @override
  void initState() {
    super.initState();
    rootNavigatorKey = GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        /// List of all providers used throughout the app
        providers: [
          ..._coordinator,
          _appRouter,
          ..._environment,
          ..._mappers,
          ..._httpClients,
          ..._dataStorages,
          ..._dataSources,
          ..._repositories,
          ..._services,
          ..._blocs,
        ],
        child: widget.child,
      );

  List<SingleChildWidget> get _coordinator => [
        RxBlocProvider<CoordinatorBlocType>(
          create: (context) => CoordinatorBloc(),
        ),
      ];

  SingleChildWidget get _appRouter => Provider<AppRouter>(
        create: (context) => AppRouter(
          coordinatorBloc: context.read(),
          rootNavigatorKey: rootNavigatorKey,
        ),
      );

  List<Provider> get _environment => [
        Provider<EnvironmentConfig>.value(value: widget.config),
      ];

  List<Provider> get _mappers => [
        Provider<ErrorMapper>(
          create: (context) => ErrorMapper(context.read()),
        ),
      ];

  List<Provider> get _httpClients => [
        Provider<PlainHttpClient>(
          create: (context) {
            return PlainHttpClient();
          },
        ),
        Provider<ApiHttpClient>(
          create: (context) {
            final client = ApiHttpClient()
              ..options.baseUrl = widget.config.baseUrl;
            return client;
          },
        ),
      ];

  List<SingleChildWidget> get _dataStorages => [
        Provider<SharedPreferencesInstance>(
            create: (context) => SharedPreferencesInstance()),
        Provider<FlutterSecureStorage>(
            create: (context) => const FlutterSecureStorage()),
      ];

  List<Provider> get _dataSources => [
        Provider<PermissionsRemoteDataSource>(
          create: (context) => PermissionsRemoteDataSource(
            context.read<ApiHttpClient>(),
          ),
        ),
        Provider<CardDataSource>(
          create: (context) => CardDataSource(
            context.read<ApiHttpClient>(),
          ),
        ),
        Provider<LanguageLocalDataSource>(
          create: (context) => LanguageLocalDataSource(
              context.read<SharedPreferencesInstance>()),
        ),
      ];

  List<Provider> get _repositories => [
        Provider<PermissionsRepository>(
          create: (context) => PermissionsRepository(
            context.read(),
            context.read(),
          ),
        ),
        Provider<LanguageRepository>(
          create: (context) => LanguageRepository(
            context.read<ErrorMapper>(),
            context.read<LanguageLocalDataSource>(),
          ),
        ),
        Provider<CardRepository>(
          create: (context) => CardRepository(
            context.read<ErrorMapper>(),
            context.read<CardDataSource>(),
          ),
        ),
      ];

  List<Provider> get _services => [
        Provider<PermissionsService>(
          create: (context) => PermissionsService(
            context.read(),
            context.read(),
          ),
        ),
        Provider<SplashService>(
          create: (context) => SplashService(
            context.read(),
          ),
        ),
        Provider<AppLanguageService>(
          create: (context) => AppLanguageService(
            languageRepository: context.read<LanguageRepository>(),
          ),
        ),
        Provider<CardService>(
          create: (context) => CardService(
            context.read(),
            context.read(),
          ),
        ),
        Provider<CardScannerService>(
          create: (context) => CardScannerService(),
        ),
      ];

  List<SingleChildWidget> get _blocs => [
        Provider<RouterBlocType>(
          create: (context) => RouterBloc(
            router: context.read<AppRouter>().router,
            permissionsService: context.read(),
          ),
        ),
        RxBlocProvider<ChangeLanguageBlocType>(
          create: (context) => ChangeLanguageBloc(
            languageService: context.read<AppLanguageService>(),
          ),
        ),
      ];
}
