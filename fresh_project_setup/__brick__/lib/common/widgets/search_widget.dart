import "package:eva_icons_flutter/eva_icons_flutter.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:{{package_name}}/config/config.dart";

class SearchWidget extends StatelessWidget {
  final Function(String?)? onChanged;
  final String hintText;
  final bool isLeftSearch;
  final Color? color;
  const SearchWidget({super.key, this.onChanged, this.color, this.hintText = 'Search', this.isLeftSearch = false});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final Color newColor = color ?? AdaptiveColor.kInputBg(context: context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
      decoration: BoxDecoration(
          color: newColor,
          borderRadius: BorderRadius.circular(15.r)
      ),
      child: Row(
        children: [
          if (isLeftSearch)...[
            const Icon(
                EvaIcons.search,
                color: AppColors.kSearchIcon
            ),
            SizedBox(width: 2.w),
          ],
          Expanded(
            child: TextFormField(
                style: TextStyle(
                    fontFamily: 'GeneralSansRegular',
                    color: AdaptiveColor.kInputTextColor(context: context)
                ),
                controller: null,
                onChanged: onChanged,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w
                  ),
                  hintText: hintText,
                )
            ),
          ),
          if (!isLeftSearch)...[
            SizedBox(width: 10.w),
            const Icon(
                EvaIcons.search,
                color: AppColors.kSearchIcon
            )
          ],
        ],
      ),
    );
  }
}