// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../blocs/scanner_bloc.dart';
import '../services/card_validation_service.dart';
import '../views/scanner_page.dart';

class ScannerPageWithDependencies extends StatelessWidget {
  const ScannerPageWithDependencies({
    Key? key,
  }) : super(key: key);

  List<RxBlocProvider> get _blocs => [
        RxBlocProvider<ScannerBlocType>(
          create: (context) => ScannerBloc(
            context.read(),
            context.read(),
            context.read(),
            context.read(),
          ),
        ),
      ];

  List<SingleChildWidget> get _services => [
        Provider<CardValidationService>(
          create: (context) => const CardValidationService(),
        ),
      ];

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ..._services,
          ..._blocs,
        ],
        child: const ScannerPage(),
      );
}
