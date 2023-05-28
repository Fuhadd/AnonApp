import 'package:anon/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/custom_colors.dart';
import '../../utils/loader.dart';
import 'auth_view_model.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';

class AuthScreen extends StatefulHookConsumerWidget {
  static const routeName = '/AuthScreen';

  const AuthScreen({Key? key, required this.authType}) : super(key: key);
  final AuthType authType;

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _signInFormKey = GlobalKey<FormBuilderState>();
  final _signUpFormKey = GlobalKey<FormBuilderState>();

  final TextEditingController phoneController = TextEditingController();
  late TabController _tabController;

  String password = "";

  @override
  void initState() {
    _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex: widget.authType == AuthType.signIn ? 0 : 1); // Create Ta
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  void signIn() {
    // Add your logic here for signing in
    // Call the onSignIn callback function to notify the parent widget
    print("jdjdjdjdjd");
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final authVM = ref.watch(authProvider);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: CustomColors.whiteBgColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.only(
                  top: (statusBarHeight + 20), left: 20, right: 20, bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 90,
                          child: TabBar(
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

                            indicator: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              border: Border(
                                bottom: BorderSide(
                                  color: CustomColors.blackBgColor,
                                ),
                              ),
                              color: Colors.transparent,
                            ),
                            controller:
                                _tabController, // Assign TabController to TabBar
                            tabs: const [
                              Tab(
                                text: 'Login',
                              ),
                              Tab(
                                text: 'Sign Up',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColors.mainBlueColor),
                          child: const Icon(Icons.person_2_outlined),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller:
                            _tabController, // Assign TabController to TabBarView
                        children: [
                          SignInScreen(
                            formkey: _signInFormKey,
                          ),
                          SignUpScreen(
                            formkey: _signUpFormKey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _tabController.index == 0 // If first tab is selected
                            ? "Forgot Password?" // Show "Forgot Password?" text
                            : "Don't have an account?",
                        style:
                            const TextStyle(color: CustomColors.blackBgColor),
                      ),
                      GestureDetector(
                        onTap: _tabController.index == 0
                            ? () {
                                FocusScope.of(context).unfocus();
                                bool? validate =
                                    _signInFormKey.currentState?.validate();
                                print(validate);
                                if (validate == true) {
                                  _signInFormKey.currentState?.save();

                                  var email = _signInFormKey
                                      .currentState?.fields['email']?.value
                                      .toString()
                                      .trim();
                                  var password = _signInFormKey
                                      .currentState?.fields['password']?.value;
                                  authVM.signIn(email, password,
                                      context: context);
                                }
                              }
                            : () {
                                FocusScope.of(context).unfocus();
                                bool? validate =
                                    _signUpFormKey.currentState?.validate();
                                print(validate);
                                if (validate == true) {
                                  _signUpFormKey.currentState?.save();
                                  var userName = _signUpFormKey
                                      .currentState?.fields['name']?.value
                                      .toString()
                                      .trim();
                                  var email = _signUpFormKey
                                      .currentState?.fields['email']?.value
                                      .toString()
                                      .trim();
                                  var password = _signUpFormKey
                                      .currentState?.fields['password']?.value;
                                  authVM.signUp(email, password, userName,
                                      context: context);
                                }
                              },
                        child: Container(
                          width: 80,
                          height: 55,
                          decoration: BoxDecoration(
                              color: CustomColors.mainBlueColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: authVM.isLoading
                              ? const Center(child: loader)
                              : const Icon(
                                  Icons.arrow_forward,
                                  size: 30,
                                ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
