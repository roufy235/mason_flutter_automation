import 'package:{{package_name}}/common/widgets/app_input_widget.dart';
import 'package:{{package_name}}/common/widgets/btn_text.dart';
import 'package:{{package_name}}/common/widgets/text_widget.dart';
import 'package:{{package_name}}/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AuthenticateUserWidget extends StatefulWidget {
  final Future Function(bool, String) action;
  const AuthenticateUserWidget({super.key, required this.action});

  @override
  State<AuthenticateUserWidget> createState() => _AuthenticateUserWidgetState();
}

class _AuthenticateUserWidgetState extends State<AuthenticateUserWidget> {

  final TextEditingController _pin1Controller = TextEditingController();
  final TextEditingController _pin2Controller = TextEditingController();
  final TextEditingController _pin3Controller = TextEditingController();
  final TextEditingController _pin4Controller = TextEditingController();

  @override
  void dispose() {
    _pin1Controller.dispose();
    _pin2Controller.dispose();
    _pin3Controller.dispose();
    _pin4Controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final double width = 50.h;
    final double height = 70.h;
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50.w,
                height: 4.h,
                decoration: const BoxDecoration(
                    color: AppColors.kReferEarn
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const FaIcon(FontAwesomeIcons.xmark)
              ),
            ),
            const TextWidget(text: 'Enter pin', fontWeight: FontWeight.w700, fontSize: 20),
            SizedBox(height: 5.h),
            const TextWidget(text: 'Enter your 4-digit pin to confirm this transaction'),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: AppInputWidget(
                    autoFocus: true,
                    text: '',
                    textController: _pin1Controller,
                    textAlign: TextAlign.center,
                    onChanged: (String? value) {
                      if (value?.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    maxCharacter: 1,
                    textInputType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: height,
                  width: width,
                  child: AppInputWidget(
                    autoFocus: true,
                    textController: _pin2Controller,
                    text: '',
                    textAlign: TextAlign.center,
                    onChanged: (String? value) {
                      if (value?.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    maxCharacter: 1,
                    textInputType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: height,
                  width: width,
                  child: AppInputWidget(
                    autoFocus: true,
                    textController: _pin3Controller,
                    text: '',
                    textAlign: TextAlign.center,
                    onChanged: (String? value) {
                      if (value?.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    maxCharacter: 1,
                    textInputType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: height,
                  width: width,
                  child: AppInputWidget(
                    autoFocus: true,
                    textController: _pin4Controller,
                    text: '',
                    textAlign: TextAlign.center,
                    onChanged: (String? value) {
                      if (value?.length == 1) {
                        String code = _pin1Controller.text + _pin2Controller.text + _pin3Controller.text + _pin4Controller.text;
                        FocusScope.of(context).nextFocus();
                        context.pop();
                        widget.action(true, code);
                      }
                    },
                    maxCharacter: 1,
                    textInputType: TextInputType.number,
                  ),
                )
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextWidget(text: 'Forgot pin?'),
                BtnText(
                    useFlexibleWith: true,
                    child: const Text('Reset now'),
                    onPressed: () {}
                )
              ],
            ),
            SizedBox(height: 20.h),
            IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.fingerprint,
                  color: AppColors.kPrimary,
                  size: 36.sp,
                )
            )
          ],
        ),
      ),
    );
  }
}
