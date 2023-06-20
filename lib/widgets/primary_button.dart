import 'package:flutter/material.dart';

import '../Constants/custom_colors.dart';
import '../style/custom_dimensions.dart';
import '../style/custom_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      this.text = '',
      this.onPressed,
      this.color = CustomColors.mainBlueColor,
      this.textColor = Colors.white,
      this.borderColor = CustomColors.mainBlueColor,
      this.borderSize = 0,
      this.radius = 30.0,
      this.width = double.infinity,
      this.height = 48.0,
      this.titleBold = false,
      this.titleSize = CustomDimensions.buttonTextSize,
      this.font = 16,
      this.isLoading = false,
      this.childWidget = const SizedBox(),
      this.elevation = 0})
      : super(key: key);

  final String text;
  final Function()? onPressed;
  final Color? color;
  final Color textColor;
  final Color? borderColor;
  final double borderSize;
  final double radius;
  final double width;
  final double height;
  final double font;
  final bool isLoading;
  final double elevation;
  final bool titleBold;
  final double titleSize;
  final Widget? childWidget;

  Widget spinner(BuildContext context) {
    return const CircularProgressIndicator(
      strokeWidth: 2,
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation<Color>(CustomColors.mainBlueColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: width,
      height: height,
      child: MaterialButton(
        elevation: elevation,
        color: color,
        onPressed: onPressed,
        disabledTextColor: CustomColors.whiteColor,
        disabledColor: CustomColors.greyBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: borderSize > 0
              ? BorderSide(width: borderSize, color: borderColor!)
              : BorderSide.none,
        ),
        child: isLoading
            ? SizedBox(
                height: 30.0,
                width: 30.0,
                child: const CircularProgressIndicator.adaptive(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(CustomColors.mainBlueColor),
                  backgroundColor: CustomColors.whiteColor,
                  strokeWidth: 3,
                ))
            : text.isNotEmpty
                ? Text(
                    text,
                    style: CustomStyle.textStyleButton.copyWith(
                      fontWeight: titleBold ? FontWeight.w700 : FontWeight.w500,
                      fontSize: titleSize,
                      color: textColor,
                      // fontFamily: fontFamily,
                    ),
                  )
                : childWidget,
      ),
    );
  }
}
