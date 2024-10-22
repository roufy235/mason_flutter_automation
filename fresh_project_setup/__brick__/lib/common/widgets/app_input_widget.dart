import 'package:{{package_name}}/common/widgets/text_widget.dart';
import 'package:{{package_name}}/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInputWidget extends StatelessWidget {
  final TextEditingController? textController;
  final String text, showForgotPasswordText;
  final TextAlign textAlign;
  final Widget? suffixIcon, prefixIcon;
  final String? hintText;
  final double? inputHeight;
  final int? maxCharacter, maxLines;
  final Key? widgetKey;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Color titleColor;
  final bool showInputTitle, validatorStatus, obscureText, isPhoneNumber, isAdaptive, autoFocus, readOnly, showForgotPassword;
  final TextInputType textInputType;
  final VoidCallback? forgotPasswordPressed;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  const AppInputWidget({super.key,
    required this.text,
    required this.textInputType,
    this.showInputTitle = true,
    this.validatorStatus = true,
    this.obscureText = false,
    this.readOnly = false,
    this.showForgotPassword = false,
    this.isAdaptive = false,
    this.autoFocus = false,
    this.maxLines = 1,
    this.forgotPasswordPressed,
    this.textController,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.widgetKey,
    this.focusNode,
    this.inputHeight,
    this.onChanged,
    this.showForgotPasswordText = 'Forgot password?',
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.hintText,
    this.titleColor = AppColors.kPureBlack,
    this.isPhoneNumber = false,
    this.maxCharacter
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(showInputTitle) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                    children: [
                      TextSpan(text: text,
                          style: TextStyle(
                            fontFamily: 'Aeonik',
                            color: isAdaptive ? AdaptiveColor.kBlack(context: context) : titleColor,
                            //fontWeight: FontWeight.bold
                          )
                      ),
                      TextSpan(text: text.isNotEmpty && validatorStatus ? ' *' : '',
                          style: const TextStyle(
                              color: AppColors.kSecondary,
                              fontFamily: 'Aeonik',
                              fontWeight: FontWeight.bold
                          )
                      )
                    ]
                ),
              ),
              showForgotPassword ? InkWell(
                onTap: forgotPasswordPressed,
                child: TextWidget(text: showForgotPasswordText, fontWeight: FontWeight.bold),
              ) : const SizedBox.shrink()
            ],
          ),
          SizedBox(height: 5.h),
        ],
        Container(
          height: inputHeight,
          decoration: BoxDecoration(
            color: isAdaptive ? AdaptiveColor.kInputColor(context: context) : AppColors.kWhite,
            borderRadius: BorderRadius.circular(AppDimens.kDefaultBtnRadius.r),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if(isPhoneNumber)...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                        color: isAdaptive ? AdaptiveColor.kBlack(context: context).withOpacity(0.2) : AppColors.kGrey1,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppDimens.kDefaultBtnRadius.r),
                            bottomLeft: Radius.circular(AppDimens.kDefaultBtnRadius.r)
                        )
                    ),
                    child: const Center(child: TextWidget(text: '+234', fontWeight: FontWeight.bold)),
                  )
                ],
                Expanded(
                  child: TextFormField(
                    focusNode: focusNode,
                    readOnly: readOnly,
                    autofocus: autoFocus,
                    inputFormatters: inputFormatters,
                    key: widgetKey,
                    maxLength: maxCharacter,
                    style: TextStyle(
                        color: isAdaptive ? AdaptiveColor.kInputTextColor(context: context) : AppColors.kPureBlack
                    ),
                    maxLines: maxLines,
                    textAlign: textAlign,
                    controller: textController,
                    onChanged: onChanged,
                    keyboardType: textInputType,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.kGrey3, width: 1),
                          borderRadius: BorderRadius.circular(10.r)
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r)
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h
                        ),
                        suffixIcon: suffixIcon,
                        prefixIcon: prefixIcon,
                        //labelText: 'First name',
                        hintText: hintText,
                        // errorBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(color: Colors.red),
                        //   borderRadius: BorderRadius.circular(AppDimens.kDefaultBtnRadius.r),
                        // ),
                        errorStyle: const TextStyle(
                            fontStyle: FontStyle.italic
                        )
                    ),
                    // The validator receives the text that the user has entered.
                    validator: validatorStatus ? validator ?? (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter $text';
                      }
                      return null;
                    } : null,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
