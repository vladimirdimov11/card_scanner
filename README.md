# Overview

This project is a huge overkill for as simple functionality as card scanning and editing. 
It's meant for demonstration purpose on working with RxBloc and my former company architecture. Sorry for making you check so much code, but there were so many examples on how to do this task, that I choose to make some unique implementation.
The base structure were generated with rx_bloc_cli pub. 

## Getting started

For Development environment we can use physical device because no server is required (API calls are mocked in the service layer).
If you decide to check how the mock server works with the data source and repository layer, feel free to run it on Staging or Production (Only for emulator/simulator usage). 

*NOTE* You can start the server from the configuration list and choose "Start Server"

## Project structure

| Path                                         | Contains                                                                                                                                              |
|----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| `lib/main.dart`                              | The production flavour of the app.                                                                                                                    |
| `lib/main_dev.dart`                          | The development flavour of the app.                                                                                                                   |
| `lib/main_staging.dart`                      | The staging flavour of the app.                                                                                                                       |
| `lib/base/`                                  | Common code used on more than one **feature** in the project.                                                                                         |
| `lib/base/app/`                              | The root of the application and Environment configuration.                                                                                            |
| `lib/base/common_blocs/`                     | Generally available [BLoCs][rx_bloc_info_lnk]                                                                                                         |
| `lib/base/common_mappers/`                   | Generally available Mappers                                                                                                                           |
| `lib/base/common_services/`                  | Generally available Services                                                                                                                          |
| `lib/base/common_ui_components/`             | Generally available Reusable widgets (buttons, controls etc)                                                                                          |
| `lib/base/data_sources/local/`               | Generally available local data sources, such as shared preferences, secured storage etc.                                                              |
| `lib/base/data_sources/remote/`              | Generally available remote data sources such as APIs. Here is placed all [retrofit][retrofit_lnk] code.                                               |
| `lib/base/data_sources/remote/interceptors/` | Custom interceptors that can monitor, rewrite, and retry calls.                                                                                       |
| `lib/base/data_sources/remote/http_clinets/` | Generally available http clients                                                                                                                      |
| `lib/base/di/`                               | Application dependencies, available in the whole app                                                                                                  |
| `lib/base/extensions/`                       | Generally available [extension methods][extension_methods_lnk]                                                                                        |
| `lib/base/models/`                           | The business models used in the application                                                                                                           |
| `lib/base/repositories/`                     | Generally available repositories used to fetch and persist models                                                                                     |
| `lib/base/theme/`                            | The custom theme of the app                                                                                                                           |
| `lib/base/utils/`                            | Generally available utils                                                                                                                             |
| `lib/feature_X/`                             | Feature related classes                                                                                                                               |
| `lib/feature_X/blocs`                        | Feature related [BLoCs][rx_bloc_info_lnk]                                                                                                             |
| `lib/feature_X/di`                           | Feature related dependencies                                                                                                                          |
| `lib/feature_X/services/`                    | Feature related Services                                                                                                                              |
| `lib/feature_X/ui_components/`               | Feature related custom widgets                                                                                                                        |
| `lib/feature_X/views/`                       | Feature related pages and forms                                                                                                                       |
| `lib/lib_auth/`                              | The OAuth2 (JWT) based authentication and token management library                                                                                    |
| `lib/lib_permissions/`                       | The ACL based library that handles all the in-app routes and custom actions as well.                                                                  |
| `lib/lib_router/`                            | Generally available [router][gorouter_lnk] related classes. The main [router][gorouter_usage_lnk] of the app is `lib/lib_router/routers/router.dart`. |
| `lib/lib_router/routes`                      | Declarations of all nested pages in the application are located here                                                                                  |

## Architecture

For in-depth review of the following architecture watch [this][architecture_overview] presentation.

<img src="https://raw.githubusercontent.com/Prime-Holding/rx_bloc/develop/packages/rx_bloc_cli/mason_templates/bricks/rx_bloc_base/__brick__/docs/app_architecture.jpg" alt="Rx Bloc Architecture"></img>

## Routing

The routing throughout the app is handled by [GoRouter][gorouter_lnk].


You can use the [IntelliJ RxBloC Plugin][intellij_plugin], which automatically does all steps instead of you, or to manualy add your route to the `lib/lib_router/routes/routes.dart`. Once the route is added one of the following shell scripts `bin/build_runner_build.sh`(or `bin/build_runner_watch.sh`) needs to be executed.


The navigation is handled by the business layer `lib/lib_router/bloc/router_bloc` so that every route can be protected if needed.
You can [push][go_router_push], [pop][go_router_pop], [goToLocation][go_to_location] or [go][go_router_go] as follows

```
context.read<RouterBlocType>().events.push(MyNewRoute())
```

```
context.read<RouterBlocType>().events.pop(Object())
```

```
context.read<RouterBlocType>().events.goToLocation('Location')
```

or

```
context.read<RouterBlocType>().events.go(MyNewRoute())
```

### Access Control List

Your app supports ACL out of the box, which means that the access to every page can be controlled remotely by the corresponding API endpoint `/api/permissions`

Expected API Response structure/data for anonymous users.

**Note**: The anonymous users have access to the splash route, but not to the **profile** route.
```
{
    'SplashRoute': true,
    'ProfileRoute': false,
    ...
}
```

Expected structure/data for authenticated users.

**Note**: The authenticated users have access to the splash and profile route.
```
{
    'SplashRoute': true,
    'ProfileRoute': true,
    ...
}
```


You can use the [IntelliJ RxBloC Plugin][intellij_plugin], which automatically does all steps instead of you, or to manualy add the permission for your route to the `lib/lib_permissions/models/route_permissions.dart`.

## Adding a new feature

You can manually create new features as described above, but to speed up the product development you can use the [IntelliJ RxBloC Plugin][intellij_plugin], which not just creates the feature structure but also integrates it to the prefered routing solution (auto_route, [go_router][gorouter_lnk] or none)

If you decide to create your feature manually without using the plugin here is all necessary steps you should do to register this feature and to be able to use it in the application:
1. Add your feature path in the `RoutesPath` class which resides under  `lib/lib_router/models/routes_path.dart`:
```
   class RoutesPath {
      static const myNewFeature = ‘my-new-feature’;
      ...
   }
```

2. Add you feature permission name in the `RoutePermissions` class which resides under `lib/lib_permissions/models/route_permissions.dart`:
```
   class RoutePermissions {
       static const myNewFeature = MyNewFeatureRoute’;
       ...
   }
```

3. Next step is to declare the new features as part of the `RouteModel` enumeration which resides under `lib/lib_router/models/route_model.dart`:
```
   enum RouteModel {
       myNewFeature(
           pathName: RoutesPath.myNewFeature
           fullPath: '/my-new-feature',
           permissionName: RoutePermissions.myNewFeature,
       ),
       ...
   }
```

4. As a final step the route itself should be created. All routes are situated under `lib/lib_router/routes/` folder which contains different route files organised by the application flow. If the new route doesn’t fit the existing application flows it can be added to the `routes.dart` file which is the default file used by the IntelliJ plugin.
```
   @TypedGoRoute<MyFeatureRoute>(path: RoutesPath.myNewFeature)
   @immutable
   class MyFeatureRoute extends GoRouteData implements RouteDataModel {
       const MyFeatureRoute();
   
       @override
       Page<Function> buildPage(BuildContext context, GoRouterState state) =>
           MaterialPage(
             key: state.pageKey,
             child: const MyFeaturePage(),
           );
   
       @override
       String get permissionName => RouteModel.myNewFeature.permissionName;
   
       @override
       String get routeLocation => location;
   }
```

Now the new route can be navigated by calling one of the `RouterBloc` events (`go(...)`, `push(...)`).
Example:
```
context.read<RouterBlocType>().go(const MyFeatureRoute())
```

For more information you can refer to the official [GoRouter][gorouter_lnk] and [GoRouterBuilder][gorouter_builder_lnk] documentation.

## Localization

Your app supports [localization][localization_lnk] out of the box.

You define localizations by adding a translation file in the `lib/l10n/arb/[language_code].arb` directory. The `language_code` represents the code of the language you want to support (`en`, `zh`,`de`, ...). Inside that file, in JSON format, you define key-value pairs for your strings. **Make sure that all your translation files contain the same keys!**

If there are new keys added to the main translation file they can be propagated to the others by running the `bin/sync_translations.py` script. This script depends on the `pyyaml` library. If your python distribution does not include it you can install it by running `pip3 install pyyaml`.

Upon rebuild, your translations are auto-generated inside `lib/assets.dart`. In order to use them, you need to import the `l10n.dart` file from `lib/l10n/l10n.dart` and then access the translations from your BuildContext via `context.l10n.someTranslationKey` or `context.l10n.featureName.someTranslationKey`.

## Design system

A [design system][design_system_lnk] is a centralized place where you can define your app`s design.  This includes typography, colors, icons, images and other assets. It also defines the light and dark themes of your app. By using a design system we ensure that a design change in one place is reflected across the whole app.

To access the design system from your app, you have to import it from the following location`lib/app/base/theme/design_system.dart'`. After that, you can access different parts of the design system by using the BuildContext (for example: `context.designSystem.typography.headline1` or `context.designSystem.icons.someIcon`).

<div id="goldenTests"/>

## Golden tests

A [golden test][golden_test_lnk] lets you generate golden master images of a widget or screen, and compare against them so you know your design is always pixel-perfect and there have been no subtle or breaking changes in UI between builds. To make this easier, we employ the use of the [golden_toolkit][golden_toolkit_lnk] package.

To get started, you just need to generate a list of `LabeledDeviceBuilder` and pass it to the `runGoldenTests` function. That's done by calling `generateDeviceBuilder` with a label, the widget/screen to be tested, as well as a `Scenario`. They provide an optional `onCreate` function which lets us execute arbitrary behavior upon testing. Each `DeviceBuilder` will have two generated golden master files, one for each theme.

Due to the way fonts are loaded in tests, any custom fonts you intend to golden test should be included in `pubspec.yaml`

In order for the goldens to be generated, we have provided VS Code and IDEA run configurations, as well as an executable `bin/generate_goldens.sh`. The golden masters will be located in `goldens/light_theme` and `goldens/dark_theme`. The `failures` folder is used in case of any mismatched tests.

<div id="server"/>

## Server

Your app comes with a small preconfigured local server (written in Dart) that you can use for testing purposes or even expand it. It is built using [shelf][shelf_lnk], [shelf_router][shelf_router_lnk] and [shelf_static][shelf_static_lnk]. The server comes with several out-of-the-box APIs that work with the generated app.

In order to run the server locally, make sure to run `bin/start_server.sh`. The server should be running on `http://0.0.0.0:8080`, if not configured otherwise.

Some of the important paths are:

| Path | Contains |
| :------------ | :------------ |
| `bin/server/` | The root directory of the server |
| `bin/server/start_server.dart` | The main entry point of the server app |
| `bin/server/config.dart` | All server-related configurations and secrets are located here |
| `bin/server/controllers/` | All controllers are located here |
| `bin/server/models/` | Data models are placed here |
| `bin/server/repositories/` | Repositories that are used by the controllers reside here |

*Note:* When creating a new controller, make sure you also register it inside the `_registerControllers()` method in `start_server.dart`.

[rx_bloc_cli]: https://pub.dev/packages/rx_bloc_cli
[rx_bloc_lnk]: https://pub.dev/packages/rx_bloc
[rx_bloc_info_lnk]: https://pub.dev/packages/rx_bloc#what-is-rx_bloc-
[extension_methods_lnk]: https://dart.dev/guides/language/extension-methods
[gorouter_lnk]: https://pub.dev/packages/go_router
[gorouter_builder_lnk]: https://pub.dev/packages/go_router_builder
[gorouter_usage_lnk]: https://pub.dev/packages/go_router#documentation
[localization_lnk]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[firebase_analytics_lnk]: https://pub.dev/packages/firebase_analytics
[firebase_configs_lnk]: https://support.google.com/firebase/answer/7015592
[design_system_lnk]: https://uxdesign.cc/everything-you-need-to-know-about-design-systems-54b109851969
[golden_test_lnk]: https://medium.com/flutter-community/flutter-golden-tests-compare-widgets-with-snapshots-27f83f266cea
[golden_toolkit_lnk]: https://pub.dev/packages/golden_toolkit
[retrofit_lnk]: https://pub.dev/packages/retrofit
[dio_lnk]: https://pub.dev/packages/dio
[json_annotation_lnk]: https://pub.dev/packages/json_annotation
[json_serializable_lnk]: https://pub.dev/packages/json_serializable
[fcm_lnk]: https://firebase.flutter.dev/docs/messaging/overview
[fcm_web_config_ref]: https://github.com/FirebaseExtended/flutterfire/blob/4c9b5d28de9eeb5ce76c856fbd0c7b3ec8615e45/docs/messaging/usage.mdx#web-tokens
[flutter_local_notifications_lnk]: https://pub.dev/packages/flutter_local_notifications
[shelf_lnk]: https://pub.dev/packages/shelf
[shelf_router_lnk]: https://pub.dev/packages/shelf_router
[shelf_static_lnk]: https://pub.dev/packages/shelf_static
[deep_linking_lnk]: https://docs.flutter.dev/development/ui/navigation/deep-linking
[gorouter_deep_linking_lnk]: https://pub.dev/documentation/go_router/latest/topics/Deep%20linking-topic.html
[architecture_overview]: https://www.youtube.com/watch?v=nVX4AzeuVu8
[intellij_plugin]: https://plugins.jetbrains.com/plugin/16165-rxbloc
[go_router_push]: https://pub.dev/documentation/go_router/latest/go_router/GoRouter/push.html
[go_router_go]: https://pub.dev/documentation/go_router/latest/go_router/GoRouterHelper/go.html
[go_to_location]: https://pub.dev/documentation/go_router/latest/go_router/GoRouterHelper/go.html
[go_router_pop]: https://pub.dev/documentation/go_router/latest/go_router/GoRouterHelper/pop.html