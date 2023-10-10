// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:card_scanner/base/models/errors/error_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/golden_helper.dart';
import '../../helpers/models/scenario.dart';
import 'factories/scanner_page_factory.dart';

void main() {
  group(
    'CounterPage golden tests',
    () => runGoldenTests(
      [
        generateDeviceBuilder(
          scenario: Scenario(name: 'normal'),
          widget: scannerPageFactory(
            isLoading: false,
          ),
        ),
        generateDeviceBuilder(
          scenario: Scenario(name: 'error'),
          widget: scannerPageFactory(
            error: NetworkErrorModel(),
          ),
        ),
        generateDeviceBuilder(
          scenario: Scenario(name: 'loading'),
          widget: scannerPageFactory(
            isLoading: true,
          ),
        ),
      ],
    ),
  );
}
