// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import '../../base/app/config/environment_config.dart';
import '../../base/common_mappers/error_mappers/error_mapper.dart';
import '../data_sources/remote/permissions_remote_data_source.dart';

class PermissionsRepository {
  PermissionsRepository(
    this._errorMapper,
    this._permissionsRemoteDataSource,
    this._environmentConfig,
  );

  final ErrorMapper _errorMapper;
  final PermissionsRemoteDataSource _permissionsRemoteDataSource;
  final EnvironmentConfig _environmentConfig;

  final _dummyData = {
    'ScannerRoute': true,
    'SuccessRote': true,
    'SplashRoute': true,
  };

  /// Returns a map of the permissions loaded from the remote data source.
  Future<Map<String, bool>> getPermissions() {
    // don't "fetch" the data on development env
    if (_environmentConfig == EnvironmentConfig.development) {
      return Future.value(_dummyData);
    }

    return _errorMapper
        .execute(() => _permissionsRemoteDataSource.getPermissions());
  }
}
