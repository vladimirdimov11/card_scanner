// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:card_scanner/base/models/errors/error_model.dart';
import 'package:card_scanner/feature_scanner/blocs/scanner_bloc.dart';
import 'package:card_scanner/feature_scanner/views/scanner_page.dart';
import 'package:card_scanner/lib_router/blocs/router_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../../../base/common_blocs/router_bloc_mock.dart';
import '../../mocks/scanner_bloc_mock.dart';

/// wraps a [CounterPage] in a [Provider] of type [CounterBlocType], creating
/// a mocked bloc depending on the values being tested
Widget scannerPageFactory({
  ErrorModel? error,
  bool? isLoading,
}) =>
    MultiProvider(
      providers: [
        RxBlocProvider<RouterBlocType>.value(
          value: routerBlocMockFactory(),
        ),
        RxBlocProvider<ScannerBlocType>.value(
          value: scannerBlocMockFactory(
            error: error,
            isLoading: isLoading,
          ),
        ),
      ],
      child: const ScannerPage(),
    );
