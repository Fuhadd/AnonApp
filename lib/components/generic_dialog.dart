import 'dart:async';

import 'package:anon/utils/spacers.dart';
import 'package:anon/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../Constants/custom_colors.dart';
import '../locator.dart';
import '../utils/enum.dart';
import '../utils/navigator_handler.dart';

BuildContext modalContext =
    locator<NavigationHandler>().navigatorKey.currentContext!;
late Timer timer;

class GenericDialog {
  Future<void> show(
      {String title = "",
      String content = "",
      String? yesButtonText,
      String? noButtonText,
      Widget? showContentIcon,
      TextAlign? contentTextAlign,
      Function()? onYesPressed,
      Function()? onNoPressed,
      Color? footerColor}) async {
    return showDialog<void>(
      context: modalContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            contentPadding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
            content: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    verticalSpacer(15),
                    showContentIcon != null
                        ? Column(
                            children: [
                              showContentIcon,
                              verticalSpacer(15),
                            ],
                          )
                        : const SizedBox.shrink(),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    verticalSpacer(10),
                    Text(
                      content,
                      textAlign: contentTextAlign ?? TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpacer(25),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: footerColor ?? CustomColors.mainBlueColor,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Column(
                  children: [
                    verticalSpacer(25),
                    GestureDetector(
                      onTap: onYesPressed ??
                          () {
                            Navigator.pop(context);
                          },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  color: CustomColors.whiteColor),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 6),
                                child: Text(
                                  yesButtonText ?? 'Yes.. Continue',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: CustomColors.blackColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: onNoPressed ??
                              () {
                                Navigator.pop(context);
                              },
                          child: SizedBox(
                              child: Center(
                                  child: Text(noButtonText ?? 'Cancel',
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: CustomColors.royalPurple,
                                          fontWeight: FontWeight.w500)))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showApiErrorDialog({
    String title = "",
    String content = "",
  }) async {
    return showDialog<void>(
      context: modalContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            contentPadding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
            content: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    verticalSpacer(15),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    verticalSpacer(25),
                    Text(
                      content,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpacer(40),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                decoration: const BoxDecoration(
                    color: CustomColors.mainBlueColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    color: CustomColors.whiteColor),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 6),
                                  child: Text(
                                    'Okay',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: CustomColors.blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showSimplePopup(
      {String? title,
      bool showTitle = true,
      String content = "",
      required InfoBoxType type,
      Widget? customIcon,
      Widget? contentBody,
      TextAlign? textAlign,
      String? okText,
      Function()? onOkPressed,
      Function()? onNoPressed,
      Color? footerColor}) async {
    if ((type == InfoBoxType.information || type == InfoBoxType.warning) &&
        title == null) {
      showTitle = false;
    }
    return showDialog<void>(
      barrierColor: CustomColors.blackColor.withOpacity(0.75),
      context: modalContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            contentPadding:
                const EdgeInsets.only(top: 35, bottom: 25, left: 15, right: 10),
            content: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customIcon ??
                        Lottie.asset(
                          getAnimationPath(type),
                          height: 80,
                          width: 80,
                          animate: true,
                          repeat: false,
                          reverse: false,
                          fit: BoxFit.contain,
                        ),
                    // SvgPicture.asset(
                    //   getNewIconPath(type),
                    //   height: 50,
                    // ),
                    verticalSpacer(15),
                    showTitle
                        ? Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                title ?? toBeginningOfSentenceCase(type.name)!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: getTypeColor(type)),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    verticalSpacer(15),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: contentBody ??
                            Text(
                              content,
                              textAlign: textAlign ?? TextAlign.center,
                              style: const TextStyle(
                                  height: 1.4,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                      ),
                    ),
                    verticalSpacer(40),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: CustomButton(
                                  // height: 38.h,
                                  color: CustomColors.whiteColor,
                                  textcolor: CustomColors.greyBgColor,
                                  borderColor: CustomColors.greyBgColor,
                                  hasBorder: true,
                                  // borderSize: 1,
                                  title: okText ?? "Okay",
                                  onTap: onOkPressed ??
                                      () {
                                        Navigator.pop(context);
                                      }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpacer(10)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showUpdatePopup({
    String version = "",
    Function()? onOkPressed,
    Function()? onNoPressed,
  }) async {
    return showDialog<void>(
      barrierColor: CustomColors.blackColor.withOpacity(0.75),
      context: modalContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            contentPadding:
                const EdgeInsets.only(top: 35, bottom: 25, left: 15, right: 10),
            content: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/update_icon.svg",
                      height: 50,
                    ),
                    verticalSpacer(15),
                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "New Update is Available!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: CustomColors.mainBlueColor),
                        ),
                      ),
                    ),
                    verticalSpacer(15),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "We've got some fresh and exciting updates waiting for you in our latest version! \n\nDon't wait any longer, update now and enjoy a better experience with us!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            verticalSpacer(20),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'Latest Version: $version',
                      style: const TextStyle(
                          color: CustomColors.greyTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    verticalSpacer(15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: CustomButton(
                                      // height: 38.h,
                                      color: CustomColors.whiteColor,
                                      textcolor: CustomColors.greyBgColor,
                                      borderColor: CustomColors.greyTextColor,
                                      hasBorder: true,
                                      // borderSize: 1,
                                      title: "Download Update",
                                      onTap: onOkPressed ??
                                          () {
                                            Navigator.pop(context);
                                          }),
                                ),
                              ),
                            ],
                          ),
                          verticalSpacer(10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Remind me later",
                              style: TextStyle(
                                  height: 1.4,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColors.mainBlueColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpacer(10)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
