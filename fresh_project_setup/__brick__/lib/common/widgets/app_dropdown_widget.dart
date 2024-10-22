import 'package:{{package_name}}/config/config.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropDownWidget extends StatelessWidget {
  final String text;
  final List<String> dataList;
  final Widget? dropdownWidget;
  final String? selectedText;
  final Function(String?)? onChange;
  final Color titleColor;
  final bool showInputTitle, isAdaptive, isSearchable;
  const AppDropDownWidget({super.key,
    required this.text,
    required this.dataList,
    this.selectedText,
    this.onChange,
    this.dropdownWidget,
    this.showInputTitle = true,
    this.isAdaptive = false,
    this.isSearchable = false,
    this.titleColor = AppColors.kPureBlack,
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
                            fontFamily: 'GeneralSans',
                            color: isAdaptive ? AdaptiveColor.kBlack(context: context) : titleColor,
                            //fontWeight: FontWeight.bold
                          )
                      ),
                      const TextSpan(text: ' *',
                          style: TextStyle(
                              color: AppColors.kSecondary,
                              fontWeight: FontWeight.bold
                          )
                      )
                    ]
                ),
              )
            ],
          ),
          SizedBox(height: 5.h),
        ],
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 3.h
          ),
          decoration: BoxDecoration(
            color: isAdaptive ? AdaptiveColor.kInputColor(context: context) : AppColors.kWhite,
            borderRadius: BorderRadius.circular(AppDimens.kDefaultBtnRadius.r),
            border: Border.all(color: AppColors.kGrey3, width: 1)
          ),
          child: dropdownWidget ?? DropdownButtonHideUnderline(
            child: isSearchable ? DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSearchBox: true,
                showSelectedItems: true,
                //disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: dataList,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  //labelText: "Menu mode",
                  border: InputBorder.none,
                  //hintText: "country in menu mode",
                ),
              ),
              onChanged: onChange ?? (_) {},
              selectedItem: selectedText ?? dataList[0],
            ) : DropdownButton<String>(
              isExpanded: true,
              items: dataList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                    style:  const TextStyle(
                      fontFamily: 'GeneralSans',
                    ),
                  ),
                );
              }).toList(),
              value: selectedText ?? dataList[0],
              onChanged: onChange ?? (_) {},
            ),
          ),
        ),
      ],
    );
  }
}
