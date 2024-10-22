import 'package:{{package_name}}/common/widgets/btn_text.dart';
import 'package:{{package_name}}/common/widgets/text_widget.dart';
import 'package:{{package_name}}/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListDataWidget extends StatelessWidget {
  final String title, content;
  final Widget? rightWidget;
  final bool showEditBtn;
  final VoidCallback? editBtnPressed;
  final int contentSize;
  final FontWeight? contentFontWeight;
  const ListDataWidget({super.key, required this.title, required this.content, this.contentFontWeight, this.contentSize = 12, this.showEditBtn = false, this.rightWidget, this.editBtnPressed});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: title, color: const Color(0xFF5D646A)),
              SizedBox(height: 5.h),
              TextWidget(text: content, color: AppColors.kDollarText, fontSize: contentSize, fontWeight: contentFontWeight),
            ],
          ),
        ),
        if (rightWidget != null && !showEditBtn)...[
          rightWidget!
        ],
        if (showEditBtn)...[
          BtnText(
              useFlexibleWith: true,
              onPressed: editBtnPressed,
              child: const Text('edit')
          )
        ]
      ],
    );
  }
}
