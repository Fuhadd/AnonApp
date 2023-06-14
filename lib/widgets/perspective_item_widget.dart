import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/custom_colors.dart';
import '../models/confession_response_model.dart';
import '../utils/spacers.dart';

class PerspectiveItem extends StatelessWidget {
  PerspectiveItem(
    this.isCardActivated,
    this.confession, {
    super.key,
  });
  bool isCardActivated;
  ConfessionResponse confession;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.center,
      children: [
        //Shadow Widget
        Container(
          height: 250,
          width: 150,
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1059C6).withOpacity(0.15),
                  blurRadius: 50,
                  spreadRadius: 10,
                  offset: const Offset(0, 40),
                )
              ]),
        ),

        // Real card widget
        Container(
          height: 250,
          width: screenWidth * 0.75,
          decoration: const BoxDecoration(
            color: CustomColors.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(60)),
            // boxShadow: [
            //   BoxShadow(
            //     color:
            //         const Color(0xFF1059C6).withOpacity(0.15),
            //     blurRadius: 50,
            //     spreadRadius: 10,
            //     offset: const Offset(0, 40),
            //   )
            // ]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: CustomColors.mainBlueColor),
                child: const Icon(Icons.person_2_outlined),
              ),
              verticalSpacer(10),
              Text(
                confession.userName,
                style: TextStyle(
                    fontSize: 11,
                    // fontWeight: FontWeight.w400,
                    color: Colors.grey.shade500),
              ),
              verticalSpacer(15),
              Text(
                confession.title,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              verticalSpacer(15),
              Text(
                confession.content,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),
              ),
              // verticalSpacer(10),
              // Text(
              //   "read all features",
              //   style: TextStyle(
              //       fontSize: 11,
              //       // fontWeight: FontWeight.w400,
              //       color: Colors.grey.shade500),
              // ),
              verticalSpacer(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Text(
                  //   "I want this",
                  //   style: TextStyle(
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.w600,
                  //       color: isCardActivated
                  //           ? Colors.greenAccent
                  //           : Colors.grey.shade500),
                  // ),
                  Container(
                      // margin:
                      //     const EdgeInsets.only(top: 5, bottom: 5),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isCardActivated
                              ? CustomColors.mainBlueColor.withOpacity(0.6)
                              : Colors.grey.shade500),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.star,
                          size: 16,
                          color: CustomColors.whiteColor,
                        ),
                        // FaIcon(
                        //   FontAwesomeIcons.message,
                        //   size: 20,
                        // ),
                      )),
                  horizontalSpacer(20),
                  Container(
                      // margin:
                      //     const EdgeInsets.only(top: 5, bottom: 5),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isCardActivated
                              ? CustomColors.mainBlueColor.withOpacity(0.6)
                              : Colors.grey.shade500),
                      child: const Center(
                        child: Icon(
                          Icons.message,
                          size: 16,
                          color: CustomColors.whiteColor,
                        ),
                        // FaIcon(
                        //   FontAwesomeIcons.message,
                        //   size: 20,
                        // ),
                      )),
                  horizontalSpacer(20),
                  Container(
                      // margin:
                      //     const EdgeInsets.only(top: 5, bottom: 5),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isCardActivated
                              ? CustomColors.mainBlueColor.withOpacity(0.6)
                              : Colors.grey.shade500),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.camera,
                          size: 16,
                          color: CustomColors.whiteColor,
                        ),
                        // FaIcon(
                        //   FontAwesomeIcons.message,
                        //   size: 20,
                        // ),
                      )),
                  horizontalSpacer(20),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
