import 'package:anon/screens/communities/communities_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../constants/custom_colors.dart';
import '../../utils/community_icons_list.dart';
import '../../utils/spacers.dart';
import '../../widgets/custom_multi_textfield.dart';

class CommunityCreateScreen extends StatefulHookConsumerWidget {
  const CommunityCreateScreen({
    super.key,
  });

  static const String routeName = "communities_details";

  @override
  ConsumerState<CommunityCreateScreen> createState() =>
      _CommunityCreateScreenState();
}

class _CommunityCreateScreenState extends ConsumerState<CommunityCreateScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  late TabController _tabController;
  int colorIndex = 0;
  Color selectedColor = CustomColors.communityColorList[0];
  int selectedListviewIndex = 0;
  String communityName = "";
  late FixedExtentScrollController _controller;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int selectedIconIndex = 0;

  String? aboutCommunity;
  String visibility = 'public';

  @override
  void initState() {
    _tabController = TabController(
      length: 1,
      vsync: this,
    ); // Create Ta
    // _tabController.addListener(_handleTabSelection);
    _controller = FixedExtentScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selectedColor = ref.watch(communityColorProvider);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Color mainColor = args['color'];
    // final Color transMainColor = mainColor.withOpacity(0.5);
    // final String title = args['title'];
    // final IconData icon = args['icon'];
    List<Color> communityColorList = CustomColors.communityColorList;
    final communityVM = ref.watch(commmunityProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: selectedColor.withOpacity(0.5),
          child: SizedBox(
            // height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const Opacity(
                          opacity: 0.2,
                          child: SizedBox(
                            height: 260,
                            width: double.infinity,
                            child: Image(
                              image: AssetImage("assets/images/doodles.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        //  ref.read(indexProvider.notifier).state = i;
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpacer(MediaQuery.of(context).padding.top),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 10, bottom: 10),
                                    child: Container(
                                        // margin:
                                        //     const EdgeInsets.only(top: 5, bottom: 5),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: CustomColors.blackBgColor
                                                .withOpacity(0.2)),
                                        child: Center(
                                          child: Icon(
                                            FontAwesomeIcons.arrowLeft,
                                            size: 18,
                                            color: CustomColors.whiteBgColor
                                                .withOpacity(0.4),
                                          ),
                                          // FaIcon(
                                          //   FontAwesomeIcons.message,
                                          //   size: 20,
                                          // ),
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, top: 10, bottom: 10),
                                  child: Container(
                                      // margin:
                                      //     const EdgeInsets.only(top: 5, bottom: 5),
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: CustomColors.blackBgColor
                                              .withOpacity(0.2)),
                                      child: Center(
                                        child: Icon(
                                          FontAwesomeIcons.heart,
                                          size: 18,
                                          color: CustomColors.whiteBgColor
                                              .withOpacity(0.4),
                                        ),
                                        // FaIcon(
                                        //   FontAwesomeIcons.message,
                                        //   size: 20,
                                        // ),
                                      )),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        toBeginningOfSentenceCase(
                                                communityName) ??
                                            '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: CustomColors.whiteBgColor,
                                            fontSize: 30),
                                      ),
                                      verticalSpacer(10),
                                      Text(
                                        "0 ActiveMembers",
                                        style: TextStyle(
                                            color: CustomColors.whiteBgColor
                                                .withOpacity(0.7),
                                            fontSize: 15),
                                      ),
                                      verticalSpacer(20),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: CustomColors.whiteBgColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 20),
                                          child: Text(
                                            "Add Post",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: selectedColor,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  FaIcon(
                                    communityIconList[selectedIconIndex],

                                    // FontAwesomeIcons.heartPulse,
                                    color: CustomColors.whiteBgColor
                                        .withOpacity(0.4),
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                            verticalSpacer(30),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 2,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: CustomColors.whiteBgColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            onPageChanged: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                            },
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      verticalSpacer(60),
                                      const Text(
                                        "Select Preferred Community colour:",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff5F5F5F),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 2,
                                      ),
                                      verticalSpacer(20),
                                      Wrap(
                                        runSpacing: 10,
                                        spacing:
                                            10, // Adjust the spacing between widgets as needed
                                        children: CustomColors
                                            .communityColorList
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          final index = entry.key;
                                          final color = entry.value;
                                          return GestureDetector(
                                            onTap: () {
                                              print(index);
                                              print(colorIndex);
                                              setState(() {
                                                colorIndex = index;
                                                selectedColor =
                                                    communityColorList[index];
                                              });
                                            },
                                            child: Stack(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: color),
                                                      color: colorIndex == index
                                                          ? color
                                                          : Colors.transparent),
                                                ),
                                                Container(
                                                  height: 45,
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: color,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 30.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (_currentPage < 2) {
                                              _pageController.animateToPage(
                                                _currentPage + 1,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 105,
                                            decoration: BoxDecoration(
                                                color: selectedColor,
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Next",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: CustomColors
                                                            .whiteColor,
                                                        fontSize: 18),
                                                  ),
                                                  horizontalSpacer(10),
                                                  const FaIcon(
                                                    FontAwesomeIcons.arrowRight,
                                                    color:
                                                        CustomColors.whiteColor,
                                                    size: 20,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ListView(
                                      children: [
                                        verticalSpacer(10),
                                        const Text(
                                          "Input Community Details:",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff5F5F5F),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 2,
                                        ),
                                        verticalSpacer(20),
                                        customMultiTextField(
                                          'name',
                                          Icons.person,
                                          null,
                                          'Community Name',
                                          maxLength: 25,
                                          validator:
                                              FormBuilderValidators.compose(
                                            [
                                              FormBuilderValidators.minLength(4,
                                                  errorText:
                                                      'Community name should be greater than 4 characters '),
                                            ],
                                          ),
                                          onChanged: (name) {
                                            setState(() {
                                              communityName = name!;
                                            });
                                          },
                                        ),
                                        verticalSpacer(10),
                                        customMultiTextField(
                                          'about',
                                          Icons.person,
                                          null,
                                          'About Community',
                                          minLines: 3,
                                          validator:
                                              FormBuilderValidators.compose(
                                            [
                                              FormBuilderValidators.minLength(
                                                  20,
                                                  errorText:
                                                      'Community info should be greater than 20 characters '),
                                            ],
                                          ),
                                        ),
                                        verticalSpacer(20),
                                        FormBuilderChoiceChip(
                                          name: 'visibility',
                                          spacing: 20,
                                          initialValue: 'public',
                                          selectedColor: selectedColor,
                                          pressElevation: 10,
                                          decoration: const InputDecoration(
                                              labelText: 'Visibility',
                                              labelStyle: TextStyle(
                                                  fontSize: 20, height: 1),
                                              border: InputBorder.none),
                                          options: const [
                                            // FormBuilderChipOption(value: value)
                                            FormBuilderChipOption(
                                                value: 'public',
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 5),
                                                  child: Text('Public'),
                                                )),
                                            FormBuilderChipOption(
                                                value: 'private',
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5),
                                                  child: Text('Private'),
                                                )),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              visibility = value;
                                              // _selectedVisibility = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (_currentPage < 2) {
                                              _pageController.animateToPage(
                                                _currentPage - 1,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 105,
                                            decoration: BoxDecoration(
                                                color: selectedColor,
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const FaIcon(
                                                    FontAwesomeIcons.arrowLeft,
                                                    color:
                                                        CustomColors.whiteColor,
                                                    size: 20,
                                                  ),
                                                  horizontalSpacer(10),
                                                  const Text(
                                                    "Prev",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: CustomColors
                                                            .whiteColor,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            FocusScope.of(context).unfocus();
                                            bool? validate = _formKey
                                                .currentState
                                                ?.validate();
                                            print(validate);
                                            if (validate == true) {
                                              _formKey.currentState?.save();
                                              //
                                              var name = _formKey.currentState
                                                  ?.fields['name']?.value
                                                  .toString()
                                                  .trim();
                                              var about = _formKey.currentState
                                                  ?.fields['about']?.value
                                                  .toString()
                                                  .trim();
                                              var visibility1 = _formKey
                                                  .currentState
                                                  ?.fields['visibility']
                                                  ?.value;

                                              setState(() {
                                                aboutCommunity = about;
                                                visibility = visibility1;
                                              });
                                              var result = await communityVM
                                                  .checkCommunityName(
                                                      name: communityName,
                                                      context: context);

                                              //

                                              if (_currentPage < 2 && !result) {
                                                _pageController.animateToPage(
                                                  _currentPage + 1,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              }
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 105,
                                            decoration: BoxDecoration(
                                                color: selectedColor,
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  communityVM.isLoading
                                                      ? const Center(
                                                          child: SizedBox(
                                                              height: 25,
                                                              width: 25,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: CustomColors
                                                                    .whiteColor,
                                                              )),
                                                        )
                                                      : const Text(
                                                          "Next",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: CustomColors
                                                                  .whiteColor,
                                                              fontSize: 18),
                                                        ),
                                                  horizontalSpacer(10),
                                                  const FaIcon(
                                                    FontAwesomeIcons.arrowRight,
                                                    color:
                                                        CustomColors.whiteColor,
                                                    size: 20,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  verticalSpacer(60),
                                  const Text(
                                    "Select Preferred Community Icon:",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff5F5F5F),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 2,
                                  ),
                                  verticalSpacer(20),
                                  Builder(builder: (context) {
                                    return Expanded(
                                      child: Stack(
                                        children: [
                                          ListWheelScrollView.useDelegate(
                                              itemExtent: 50,
                                              perspective: 0.005,
                                              diameterRatio: 1.2,
                                              controller: _controller,
                                              // overAndUnderCenterOpacity: 02,
                                              onSelectedItemChanged: (value) {
                                                // print(value);
                                                // print(selectedListviewIndex);
                                                selectedListviewIndex = value;
                                                setState(() {
                                                  selectedIconIndex = value;
                                                });
                                              },
                                              physics:
                                                  const FixedExtentScrollPhysics(),
                                              childDelegate:
                                                  ListWheelChildBuilderDelegate(
                                                      childCount:
                                                          communityIconList
                                                              .length,
                                                      builder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Center(
                                                              child: FaIcon(
                                                                communityIconList[
                                                                    index],
                                                                size: 30,
                                                                color: CustomColors
                                                                    .greyBgColor
                                                                    .withOpacity(
                                                                        0.7),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      })),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: double.infinity,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: CustomColors
                                                      .greyTextColor
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                  verticalSpacer(25),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (_currentPage < 3) {
                                              _pageController.animateToPage(
                                                _currentPage - 1,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 105,
                                            decoration: BoxDecoration(
                                                color: selectedColor,
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const FaIcon(
                                                    FontAwesomeIcons.arrowLeft,
                                                    color:
                                                        CustomColors.whiteColor,
                                                    size: 20,
                                                  ),
                                                  horizontalSpacer(10),
                                                  const Text(
                                                    "Prev",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: CustomColors
                                                            .whiteColor,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            var newVisibility =
                                                visibility == 'public' ? 0 : 1;

                                            communityVM.createCommunity(
                                                color: colorIndex,
                                                icon: selectedListviewIndex,
                                                visibility: newVisibility,
                                                name: communityName,
                                                description: aboutCommunity!,
                                                ref: ref);

                                            // print(selectedColor);
                                            // print(colorIndex);
                                            // print(
                                            //     communityColorList[colorIndex]);
                                            // print(communityVM);
                                            // print(aboutCommunity);
                                            // print(visibility);
                                            // print(selectedListviewIndex);
                                            // print(communityIconList[
                                            //     selectedListviewIndex]);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 105,
                                            decoration: BoxDecoration(
                                                color: selectedColor,
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  communityVM.isLoading
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : const Text(
                                                          "Next",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: CustomColors
                                                                  .whiteColor,
                                                              fontSize: 18),
                                                        ),
                                                  horizontalSpacer(10),
                                                  const FaIcon(
                                                    FontAwesomeIcons.arrowRight,
                                                    color:
                                                        CustomColors.whiteColor,
                                                    size: 20,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
