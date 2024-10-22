import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final invalidTokenProvider = ChangeNotifierProvider<TokenNotifier>((ref) => TokenNotifier());

class TokenNotifier extends ChangeNotifier {
  bool invalidToken = false;

  void toggle(bool value) {
    invalidToken = value;
    notifyListeners();
  }
}
