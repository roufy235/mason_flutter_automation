import 'dart:io';

import 'package:{{package_name}}/config/config.dart';
import 'package:{{package_name}}/generated/assets.dart';
import 'package:intl/intl.dart';

extension StringExt on String {

  String get toCapitalized => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized).join(' ');

  
  String getFileExtensionFromUrl(String url) {
    // Extract the path part from the URL
    String path = Uri.parse(url).path;

    // Get the file extension from the path
    List<String> parts = path.split(".");
    if (parts.length > 1) {
      return parts.last;
    }

    // Default to empty string if no extension found
    return "";
  }
  
  String ensureDialCode() {
    const dialCode = "+234";
    // Check if the phone number starts with the dial code
    if (!startsWith(dialCode)) {
      // If it doesn't, add the dial code to the phone number
      return dialCode + this;
    }
    return this;
  }

  String getCurrencySymbol({required String currency}) {
    if (currency.toLowerCase() == 'ngn' && Platform.isAndroid) {
      return 'NGN';
    }
    return this;
  }

  bool isValidEmail() {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  // 8 Digit Characters, Contains Lowercase, Uppercase, & Number
  bool isValidPassword() {
    return RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$').hasMatch(this);
  }

  bool isNoSpecialCharacters() {
    return RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(this);
  }

  bool isNoSpecialCharactersOrNumber() {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(this);
  }


  bool isURL() {
    // Regular expression for a simple URL pattern
    RegExp urlRegExp = RegExp(
      r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
      multiLine: false,
    );

    return urlRegExp.hasMatch(this);
  }

  String addCurrency({required String addCurrency, String sign = ''}) {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: addCurrency);
    return sign + format.currencySymbol + this;
  }


  String removeWhitespaceExtension() {
    if (contains('+234')) {
      return replaceAll(RegExp(r"\s+"), "").replaceAll('+234', '0');
    }
    return replaceAll(RegExp(r"\s+"), "");
  }

  String formatLaravelDate() {
    try {
      final date = DateFormat("yyyy-MM-dd HH:mm:ss");
      final dateFormatted = date.parse(this);
      return DateFormat('EEE, MMM d, yyyy h:mm a').format(dateFormatted);
    } catch (_) {
      return this;
    }
  }

  String formatLaravelDateOnly() {
    try {
      final date = DateFormat("yyyy-MM-dd HH:mm:ss");
      final dateFormatted = date.parse(this);
      return DateFormat('EEE, MMM d, yyyy').format(dateFormatted);
    } catch (_) {
      return this;
    }
  }

  String transactionKey() {
    try {
      final date = DateFormat("yyyy-MM-dd");
      final dateFormatted = date.parse(this);
      return DateFormat('dd-MM-yyyy').format(dateFormatted);
    } catch (_) {
      return this;
    }
  }

  String formatLaravelTimeOnly() {
    try {
      final date = DateFormat("yyyy-MM-dd HH:mm:ss");
      final dateFormatted = date.parse(this);
      return DateFormat('hh:mm a').format(dateFormatted);
    } catch (_) {
      return this;
    }
  }

  String formatTimeOnly() {
    try {
      final date = DateFormat("HH:mm:ss");
      final dateFormatted = date.parse(this);
      return DateFormat('h:mm a').format(dateFormatted);
    } catch (_) {
      return this;
    }
  }

  // String getTimeAgo() {
  //   try {
  //     final dateFormatted = DateTime.parse(this);
  //     return timeago.format(dateFormatted);
  //   } catch (_) {
  //     return this;
  //   }
  // }

  int get toInt => int.parse(this);

  String formatCurrency({String addCurrency = ''}) {
    String cur = '';
    final NumberFormat f = NumberFormat('#,##0', 'en_US');
    if (addCurrency.isNotEmpty) {
      final format = NumberFormat.simpleCurrency(
          locale: Platform.localeName,
          name: addCurrency
      );
      cur = format.currencySymbol;
      if (Platform.isAndroid && addCurrency.toLowerCase() == 'NGN'.toLowerCase()) {
        cur = 'NGN';
      }
    }
    try {
      return cur + f.format(int.parse(this));
    } catch(e) {
      try {
        final data = double.parse(this).toStringAsFixed(0).toString();
        return cur + f.format(int.parse(data));
      } catch(_) {}
      return cur + this;
    }
  }



  String addPlusToDialCode() {
    String dialCode = this;
    if (!dialCode.contains("+")) {
      dialCode = "+234$this"; // Add "+" if it's not already present
    }
    if (dialCode.length == 15) {
      dialCode = '+234${substring(1, length)}';
    }
    return dialCode;
  }

}