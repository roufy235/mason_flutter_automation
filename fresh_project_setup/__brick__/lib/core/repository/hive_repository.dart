import 'package:{{package_name}}/common/providers/common_providers.dart';
import 'package:{{package_name}}/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveRepository {
  final Ref _ref;

  HiveRepository(this._ref);
  final String _isDarkModeEnabled = 'isDarkModeEnabled';
  final String _userAccountToken = 'userAccountToken';
  final String _isUserLoggedIn = 'isUserLoggedIn';
  final Box _box = Hive.box(AppStrings.kBoxName);


  Future<void> signOut() async {
    await _box.delete(_isUserLoggedIn);
    await _box.delete(_userAccountToken);
    _ref.read(isUserLoggedInProvider.notifier).state = false;
    _ref.read(userAuthTokenProvider.notifier).state = '';
  }

  bool get getIsDarkModeEnabled => (_box.get(_isDarkModeEnabled) ?? false);
  Future<void> setIsDarkModeEnabled(bool value) async {
    await _box.put(_isDarkModeEnabled, value);
  }

  bool get getIsUserLoggedIn => (_box.get(_isUserLoggedIn)  ?? false);
  Future<void> setIsUserLoggedIn(bool value) async {
    await _box.put(_isUserLoggedIn, value);
    _ref.read(isUserLoggedInProvider.notifier).state = value;
  }

  String get getUserAccountToken => (_box.get(_userAccountToken) ?? '');
  Future<void> setUserAccountToken(String value) async {
    await _box.put(_userAccountToken, value);
    _ref.read(userAuthTokenProvider.notifier).state = value;
  }

}
