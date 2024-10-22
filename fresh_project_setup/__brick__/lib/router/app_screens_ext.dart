import 'package:{{package_name}}/router/app_screens.dart';

extension AppScreensExtension on AppScreens {
  String get toPath {
    switch (this) {
      case AppScreens.onboarding:return 'onboarding';
    }
  }

  String get toName {
    switch (this) {
      case AppScreens.onboarding:return 'Onboarding';
    }
  }
}
