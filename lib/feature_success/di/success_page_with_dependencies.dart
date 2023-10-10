// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../blocs/success_bloc.dart';
import '../views/success_page.dart';

class SuccessPageWithDependencies extends StatelessWidget {
  const SuccessPageWithDependencies({
    Key? key,
  }) : super(key: key);

  List<RxBlocProvider> get _blocs => [
        RxBlocProvider<SuccessBlocType>(
          create: (context) => SuccessBloc(
            context.read(),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ..._blocs,
        ],
        child: const SuccessPage(),
      );
}
