// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class QuickAccess extends StatelessWidget {
  final String title, message, quickRoute, communityId;
  final IconData quickIcon;
  final Color quickIconColor,
      quickTitleColor,
      quickBackgroundColor,
      quickBorderColor;
  final bool isMember;
  const QuickAccess(
      {Key? key,
      required this.title,
      required this.message,
      required this.quickIcon,
      required this.isMember,
      required this.quickIconColor,
      required this.quickTitleColor,
      required this.quickBackgroundColor,
      required this.quickBorderColor,
      required this.communityId,
      required this.quickRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, quickRoute, arguments: {
          "color": quickBackgroundColor,
          "title": title,
          "icon": quickIcon,
          "message": message,
          "isMember": isMember,
          "communityId": communityId,
        });
      },
      focusColor: Color(0xff5BBE5F),
      hoverColor: Color(0xff5BBE5F),
      child: Ink(
          // width: MediaQuery.of(context).size.width * 0.40,
          height: 200,
          decoration: BoxDecoration(
              color: quickBackgroundColor.withOpacity(0.5),
              // border: Border.all(
              //   color: quickBorderColor,
              // ),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(
              15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  quickIcon,
                  color: quickIconColor,
                  size: 20,
                ),
                SizedBox(height: 20),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16,
                      color: quickTitleColor,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                ),
                SizedBox(height: 5),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xff5F5F5F),
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 2,
                ),
              ],
            ),
          )),
    );
    // ElevatedButton(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         margin: EdgeInsets.only(top: 30),
    //         child: Icon(
    //           quickIcon,
    //           color: quickIconColor,
    //           size: 20,
    //         ),
    //       ),
    //       SizedBox(height: 12),
    //       Text(
    //         title,
    //         style: GoogleFonts.poppins(
    //             fontSize: 14,
    //             color: quickTitleColor,
    //             fontWeight: FontWeight.bold),
    //       ),
    //       SizedBox(height: 5),
    //       Text(
    //         message,
    //         style: GoogleFonts.poppins(
    //             fontSize: 10, color: const Color(0xff5F5F5F)),
    //       ),
    //     ],
    //   ),
    //   style: ElevatedButton.styleFrom(
    //       minimumSize: const Size(156, 160),
    //       maximumSize: const Size(156, 160),
    //       primary: quickBackgroundColor,
    //       shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(10),
    //           side: BorderSide(
    //             color: quickBorderColor,
    //           )),
    //       shadowColor: Colors.transparent,
    //       elevation: 0),
    //   onPressed: () {
    //     Get.toNamed(quickRoute);
    //   },
    // );
  }
}
