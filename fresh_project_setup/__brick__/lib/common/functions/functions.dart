import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:{{package_name}}/common/widgets/btn_text.dart';
import 'package:{{package_name}}/common/widgets/text_widget.dart';
import 'package:{{package_name}}/config/config.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


Future<Uint8List?> pickImageHandler({required ImageSource imageSource}) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: imageSource);
  if (file != null) {
    return await file.readAsBytes();
  }
  return null;
}

int? validateJsonInt{{package_name.pascalCase()}}(dynamic data) {
  try {
    return data != null ? int.parse(data.toString()) : null;
  } catch(_) {
    return null;
  }
}

double? validateJsonDouble{{package_name.pascalCase()}}(dynamic data) {
  try {
    return data != null ? double.parse(data.toString()) : null;
  } catch(_) {
    return null;
  }
}

bool? validateJsonBool{{package_name.pascalCase()}}(dynamic data) {
  try {
    return data != null ? bool.parse(data.toString()) : null;
  } catch(_) {
    try {
      return data != null ? int.parse(data.toString()) == 1 : null;
    } catch(_) {
      return null;
    }
  }
}

DateTime? validateJsonDate{{package_name.pascalCase()}}(dynamic data) {
  try {
    return data != null ? DateTime.parse(data.toString()) : null;
  } catch(_) {}
  return null;
}

bool isNumeric(String s) {
  return double.tryParse(s) != null;
}

FilteringTextInputFormatter get allowOnlyNum => FilteringTextInputFormatter.allow(RegExp(r"[0-9]"));
FilteringTextInputFormatter get allowCharNumAndSpace => FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9]+|\s"));
FilteringTextInputFormatter get allowAllExceptSpace => FilteringTextInputFormatter.allow(RegExp(r'[^ ]'));


String generateRandomString(int len) {
  var r = Random();
  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}


void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<XFile> convertBase64ToXFile({required String base64String, required String fileName}) async {
  // Decode the base64 string to bytes
  final bytes = base64Decode(base64String);

  // Get the temporary directory of the app
  final tempDir = await getTemporaryDirectory();

  // Create a temporary file in the temporary directory
  final tempFile = File('${tempDir.path}/$fileName');

  // Write the bytes to the file
  await tempFile.writeAsBytes(bytes);

  // Create an XFile from the temporary file
  final xfile = XFile(tempFile.path);

  return xfile;
}

void logError({required String message}) {
  FirebaseCrashlytics.instance.log(message);
}

void logException({required dynamic exception, StackTrace? stack}) {
  FirebaseCrashlytics.instance.recordError(exception, stack);
}

void launchStore({required PackageInfo packageInfo}) {
  String packageName = packageInfo.packageName;
  if (Platform.isAndroid || Platform.isIOS) {
    final appId = Platform.isAndroid ? packageName : packageName;
    final url = Uri.parse(
      Platform.isAndroid
          ? "market://details?id=$appId"
          : "https://apps.apple.com/app/id$appId",
    );
    launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}
