import 'package:anon/utils/spacers.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import '../constants/custom_colors.dart';
import '../locator.dart';
import '../style/custom_text_styles.dart';
import 'navigator_handler.dart';

final copiedStatusProvider = StateProvider.autoDispose<bool>((ref) => false);

class ClipBoardTextUpdater {
  static show(
      {required WidgetRef ref, String? copiedText, String? toastMessage}) {
    Clipboard.setData(ClipboardData(text: copiedText)).then((value) {
      ref.read(copiedStatusProvider.notifier).state = true;
    });
  }
}

class ToastNotification {
  static show(
      {BuildContext? context, String? copiedText, String? toastMessage}) {
    final defaultContext =
        locator<NavigationHandler>().navigatorKey.currentContext!;
    ScaffoldMessenger.of(context ?? defaultContext).showSnackBar(SnackBar(
      padding: const EdgeInsets.all(6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: CustomColors.greyColor,
      content: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.asset(
              "assets/images/anon_icon.png",
              width: 35,
              height: 35,
            ),
          ),
          horizontalSpacer(80),
          Text(toastMessage ?? "Sample Toast",
              textAlign: TextAlign.center,
              style: CustomStyle.textStyleBody1.copyWith(
                fontSize: 14,
                color: CustomColors.whiteColor,
                fontWeight: FontWeight.w500,
              ))
        ],
      ),
    ));
  }
}
