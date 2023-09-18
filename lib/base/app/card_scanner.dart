// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:widget_toolkit/language_picker.dart';

import '../../l10n/l10n.dart';
import '../../lib_change_language/bloc/change_language_bloc.dart';
import '../../lib_router/router.dart';
import '../data_sources/remote/http_clients/api_http_client.dart';
import '../data_sources/remote/http_clients/plain_http_client.dart';
import '../di/card_scanner_with_dependencies.dart';
import '../theme/card_scanner_theme.dart';
import '../theme/design_system.dart';
import 'config/environment_config.dart';

/// This widget is the root of your application.
class CardScanner extends StatelessWidget {
  const CardScanner({
    this.config = EnvironmentConfig.production,
    Key? key,
  }) : super(key: key);

  final EnvironmentConfig config;

  @override
  Widget build(BuildContext context) => CardScannerWithDependencies(
        config: config,
        child: const _MyMaterialApp(),
      );
}

/// Wrapper around the MaterialApp widget to provide additional functionality
/// accessible throughout the app (such as App-level dependencies, Firebase
/// services, etc).
class _MyMaterialApp extends StatefulWidget {
  const _MyMaterialApp();

  @override
  __MyMaterialAppState createState() => __MyMaterialAppState();
}

class __MyMaterialAppState extends State<_MyMaterialApp> {
  Locale? _locale;

  late StreamSubscription<LanguageModel> _languageSubscription;

  @override
  void initState() {
    _updateLocale();
    _configureInterceptors();
    super.initState();
  }

  void _updateLocale() {
    _languageSubscription = context
        .read<ChangeLanguageBlocType>()
        .states
        .currentLanguage
        .listen((language) {
      setState(
        () => _locale = Locale(language.locale),
      );
    });
  }

  @override
  void dispose() {
    _languageSubscription.cancel();
    super.dispose();
  }

  void _configureInterceptors() {
    context.read<PlainHttpClient>().configureInterceptors();

    context.read<ApiHttpClient>().configureInterceptors();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Card Scanner',
        theme: CardScannerTheme.buildTheme(DesignSystem.light()),
        darkTheme: CardScannerTheme.buildTheme(DesignSystem.dark()),
        localizationsDelegates: const [
          I18n.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: I18n.supportedLocales,
        locale: _locale,
        routerConfig: context.read<AppRouter>().router,
        debugShowCheckedModeBanner: false,
      );
}
