import 'package:anon/components/generic_dialog.dart';
import 'package:anon/utils/enum.dart';
import 'package:anon/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../Constants/custom_colors.dart';
import '../../data/local_cache/local_cache.dart';
import '../../locator.dart';
import '../../utils/spacers.dart';
import '../../widgets/custom_noborder_textfield.dart';
import '../../widgets/custom_text_field.dart';
import 'communities_view_model.dart';

class CreatePostScreen extends StatefulHookConsumerWidget {
  const CreatePostScreen(
      {required this.mainColor,
      required this.discussions,
      required this.communityId,
      super.key});
  final Color mainColor;
  final List<String> discussions;
  final String communityId;

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  int activeIndex = -1;
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: 0); // Create Ta
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userData = locator<LocalCache>().getUserData();
    final communityVM = ref.watch(commmunityProvider);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomColors.blackBgColor.withOpacity(0.2),
                    image: DecorationImage(
                        image: NetworkImage(userData.avatarUrl))),
                // child: const Icon(Icons.person_2_outlined),
              ),
              horizontalSpacer(15),
              Text(
                "@${userData.userName}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff5F5F5F),
                ),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 2,
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 5),
                    child: FaIcon(
                      FontAwesomeIcons.xmark,

                      // FontAwesomeIcons.heartPulse,
                      color: CustomColors.blackIconColor.withOpacity(0.9),
                      size: 20,
                    ),
                  ),
                ),
              ],
            )
            // Padding(
            //   padding: const EdgeInsets.only(right: 15.0, top: 10, bottom: 10),
            //   child: Container(
            //     height: 40,
            //     width: 40,
            //     decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: CustomColors.blackBgColor.withOpacity(0.2),
            //         image: DecorationImage(
            //             image: NetworkImage(userData.avatarUrl))),
            //     // child: const Icon(Icons.person_2_outlined),
            //   ),
            // ),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height -
              100 -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpacer(20),
                    // const Text(
                    //   "Welcome Back,",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.w300,
                    //       fontSize: 30,
                    //       color: CustomColors.blackBgColor),
                    // ),
                    const Text(
                      "Start a Discussion .........",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: CustomColors.blackBgColor),
                    ),
                    verticalSpacer(20),
                    TabBar(
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: CustomColors.blackColor,
                      unselectedLabelColor:
                          CustomColors.blackBgColor.withOpacity(0.4),
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),

                      indicator: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        border: Border(
                          bottom: BorderSide(
                            color: widget.mainColor,
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                      controller:
                          _tabController, // Assign TabController to TabBar
                      tabs: const [
                        Tab(
                          text: 'Select a category',
                        ),
                        Tab(
                          text: 'New category',
                        ),
                      ],
                    ),

                    verticalSpacer(20),
                    SizedBox(
                      height: 35,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller:
                            _tabController, // Assign TabController to TabBarView
                        children: [
                          SizedBox(
                            height: 35,
                            // height: 30,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: widget.discussions.length,
                              itemBuilder: (BuildContext context, int index) {
                                return activeIndex == index
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            activeIndex = -1;
                                            print(activeIndex);
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          child: Container(
                                            height: 20,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: widget.mainColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Center(
                                                child: Text(
                                                  "#${widget.discussions[index]}   x",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: widget.mainColor,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            activeIndex = index;
                                            print(activeIndex);
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          child: Container(
                                            height: 20,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: widget.mainColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Center(
                                                child: Text(
                                                  "#${widget.discussions[index]}",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xff5F5F5F),
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ),
                          customTextField(
                            'category',
                            FontAwesomeIcons.hashtag,
                            null,
                            'Category',
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.minLength(2,
                                    errorText:
                                        'A valid category should be greater than 2 characters '),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 35,
                    //   // height: 30,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     shrinkWrap: true,
                    //     itemCount: widget.discussions.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return activeIndex == index
                    //           ? GestureDetector(
                    //               onTap: () {
                    //                 setState(() {
                    //                   activeIndex = -1;
                    //                   print(activeIndex);
                    //                 });
                    //               },
                    //               child: Padding(
                    //                 padding: const EdgeInsets.only(right: 12.0),
                    //                 child: Container(
                    //                   height: 20,
                    //                   decoration: BoxDecoration(
                    //                     border: Border.all(
                    //                       color: widget.mainColor,
                    //                     ),
                    //                     borderRadius: BorderRadius.circular(10),
                    //                   ),
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.symmetric(
                    //                         horizontal: 12.0),
                    //                     child: Center(
                    //                       child: Text(
                    //                         "#${widget.discussions[index]}   x",
                    //                         style: TextStyle(
                    //                           fontSize: 15,
                    //                           color: widget.mainColor,
                    //                         ),
                    //                         overflow: TextOverflow.ellipsis,
                    //                         softWrap: false,
                    //                         maxLines: 2,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             )
                    //           : GestureDetector(
                    //               onTap: () {
                    //                 setState(() {
                    //                   activeIndex = index;
                    //                   print(activeIndex);
                    //                 });
                    //               },
                    //               child: Padding(
                    //                 padding: const EdgeInsets.only(right: 12.0),
                    //                 child: Container(
                    //                   height: 20,
                    //                   decoration: BoxDecoration(
                    //                     border: Border.all(
                    //                       color: widget.mainColor,
                    //                     ),
                    //                     borderRadius: BorderRadius.circular(10),
                    //                   ),
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.symmetric(
                    //                         horizontal: 12.0),
                    //                     child: Center(
                    //                       child: Text(
                    //                         "#${widget.discussions[index]}",
                    //                         style: const TextStyle(
                    //                           fontSize: 15,
                    //                           color: Color(0xff5F5F5F),
                    //                         ),
                    //                         overflow: TextOverflow.ellipsis,
                    //                         softWrap: false,
                    //                         maxLines: 2,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //     },
                    //   ),
                    // ),

                    verticalSpacer(40),

                    customNoBorderTextField(
                      'post',
                      Icons.mail,
                      null,
                      'Leave A Message',
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.minLength(5,
                              errorText:
                                  'Post should generally be greater than 5 cahracters.'),
                          FormBuilderValidators.required(
                              errorText: 'Post field cannot be empty '),
                        ],
                      ),
                    ),

                    Stack(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      children: [
                        Column(
                          children: const [
                            Opacity(
                              opacity: 0.2,
                              child: SizedBox(
                                height: 100,
                                width: double.infinity,
                                child: Image(
                                  image:
                                      AssetImage("assets/images/doodles.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Opacity(
                              opacity: 0.2,
                              child: SizedBox(
                                height: 100,
                                width: double.infinity,
                                child: Image(
                                  image:
                                      AssetImage("assets/images/doodles.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            verticalSpacer(40),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  bool? validate =
                                      _formKey.currentState?.validate();
                                  print(validate);
                                  if (validate == true) {
                                    _formKey.currentState?.save();
                                    if (_tabController.index == 0 &&
                                        activeIndex < 0) {
                                      GenericDialog().showSimplePopup(
                                          type: InfoBoxType.information,
                                          title: "Warning",
                                          content:
                                              "Select a category or input a new category");
                                    } else {
                                      var category = _tabController.index == 0
                                          ? widget.discussions[activeIndex]
                                          : _formKey.currentState
                                              ?.fields['category']?.value
                                              .toString()
                                              .trim();
                                      var post = _formKey
                                          .currentState?.fields['post']?.value
                                          .toString()
                                          .trim();

                                      communityVM.createCommunityPost(
                                          communityId: widget.communityId,
                                          post: post!,
                                          categoryName: category!,
                                          createdAt: DateTime.now(),
                                          userName: userData.userName,
                                          ref: ref);
                                    }
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      color: widget.mainColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: communityVM.isLoading
                                        ? loader
                                        : const Text(
                                            "Submit",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: CustomColors.whiteColor,
                                                fontSize: 18),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // customTextField(
                    //   'password',
                    //   Icons.vpn_key,
                    //   Icons.remove_red_eye_outlined,
                    //   'Password',
                    //   // obscureText: passwordObscured,
                    //   // onSuffixTap: () {
                    //   //   setState(() {
                    //   //     passwordObscured = !passwordObscured;
                    //   //   });
                    //   // },
                    //   onChanged: (value) {
                    //     // setState(() {
                    //     //   password = value!;
                    //     //   print(password);
                    //     // });
                    //   },
                    //   validator: FormBuilderValidators.compose([
                    //     FormBuilderValidators.minLength(6,
                    //         errorText:
                    //             'Good passwords are greater than 6 characters'),
                    //     FormBuilderValidators.required(
                    //         errorText: 'Password field cannot be empty '),
                    //   ]),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
