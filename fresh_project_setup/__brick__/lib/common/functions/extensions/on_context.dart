import 'package:flutter/material.dart';
import 'package:{{package_name}}/common/functions/extensions/on_num.dart';
import 'package:{{package_name}}/common/widgets/pop_up_modal_widget.dart';
import 'package:{{package_name}}/common/widgets/btn_text.dart';
import 'package:{{package_name}}/common/widgets/text_widget.dart';
import 'package:{{package_name}}/config/config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

extension ContextExt on BuildContext {

  void customSnackBar({required String text, int seconds = 4}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(text),
      duration:  Duration(seconds: seconds),
    ));
  }

  void popModal({String? image, required String title, required String content, required String btnText, required VoidCallback onPressed, int imageSize = 150}) {
  ScreenUtil.init(this);
  showDialog(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
            backgroundColor: AppColors.kPrimary,
            content: PopUpModalWidget(title: title, content: content, btnText: btnText, onPressed: onPressed, image: image, imageSize: imageSize)
        );
      });
}


  void showToast({required String title, String? content, ToastificationType type = ToastificationType.success, int seconds = 4, bool showProgressBar = true}) {
    toastification.show(
      context: this,
      type: type,
      style: ToastificationStyle.flatColored,
      title: TextWidget(text: title, maxLines: 3),
      description: content != null ? TextWidget(text: content) : null,
      alignment: Alignment.topCenter,
      //showProgressBar: showProgressBar,
      showProgressBar: false,
      autoCloseDuration: seconds.seconds,
      animationBuilder: (BuildContext context, animation, Alignment alignment, Widget child) {
        return ScaleTransition(scale: animation, child: child);
      },
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: highModeShadow,
    );
  }

  void showConfirmationDialog({
    String title = '',
    String content = 'are you sure?',
    String positiveBtnText = 'Ok',
    String? negativeBtnText,
    VoidCallback? positiveBtnOnPressed,
    VoidCallback? negativeBtnOnPressed,
    Color? positiveBtnTextColor,
    bool showTitle = true,
    bool barrierDismissible = false,
    Color? negativeBtnTextColor
  }) {
    showDialog(
        context: this,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext ctx) {
          return AlertDialog.adaptive(
            //icon: const Icon(Icons.refresh),
            title: showTitle ? Text(
              title,
              style: TextStyle(fontSize: 20, color: AdaptiveColor.kBlack(context: this)),
            ) : const SizedBox.shrink(),
            content: Text(
              content,
              style: TextStyle(color: AdaptiveColor.kBlack(context: this)),
            ),
            actions: [
              negativeBtnText != null ? BtnText(
                  useFlexibleWith: true,
                  onPressed:
                  negativeBtnOnPressed ?? () => Navigator.pop(this),
                  child: Text(negativeBtnText,
                    style: TextStyle(
                        color: negativeBtnTextColor ?? AdaptiveColor.kPrimaryDark(context: this)
                    ),
                  )
              ) : const SizedBox.shrink(),
              BtnText(
                  useFlexibleWith: true,
                  onPressed: positiveBtnOnPressed ?? () => Navigator.pop(this),
                  child: Text(positiveBtnText,
                    style: TextStyle(
                        color: positiveBtnTextColor ?? AdaptiveColor.kPrimaryDark(context: this)
                    ),
                  )
              )
            ],
          );
        });
  }

}