import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../Constants/custom_colors.dart';
import '../../components/base_scaffold.dart';
import '../../data/local_cache/local_cache.dart';
import '../../locator.dart';
import '../communities/communities_screen.dart';
import '../communities/communities_view_model.dart';
import '../confessions/confession_screen.dart';
import '../home/home_page.dart';
import '../messages/messages_screen.dart';
import 'dashboard_view_model.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String routeName = "dashboardScreen";
  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    ); // Create Ta
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final menuIndex = ref.watch(indexProvider);
    final discoveredCommunities = ref.read(discoveredCommunitiesProvider);

    final List<Widget> pages = [
      // const HomeScreen(),
      const ConfessionScreen(),
      CommunitiesScreen2(
        discoveredCommunities: discoveredCommunities,
      ),
      const HomePage(),
      const MessagesScreen(),
    ];
    final userData = locator<LocalCache>().getUserData();
    return BaseScaffold(
      onWillPop: () async {
        false;
      },
      backgroundColor: CustomColors.whiteBgColor,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.whiteBgColor,
        title: menuIndex == 3
            ? Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Messages",
                  style: TextStyle(
                      color: CustomColors.blackColor.withOpacity(0.9),
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              )
            : null,
        // title: menuIndex == 0
        //     ? Container(
        //         color: Colors.red,
        //         width: 39,
        //         height: 20,
        //       )
        //     : menuIndex == 3
        //         ? Row(
        //             children: [
        //               Expanded(
        //                 child: SizedBox(
        //                   // width: 500,
        //                   child: TabBar(
        //                     // indicatorSize: TabBarIndicatorSize.label,
        //                     labelColor: CustomColors.blackColor,
        //                     unselectedLabelColor:
        //                         CustomColors.blackBgColor.withOpacity(0.4),
        //                     labelStyle: const TextStyle(
        //                       fontSize: 14,
        //                       fontWeight: FontWeight.w700,
        //                     ),
        //                     unselectedLabelStyle: const TextStyle(
        //                       fontSize: 14,
        //                       fontWeight: FontWeight.w700,
        //                     ),

        //                     indicator: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(20),
        //                       // border: Border(
        //                       //   bottom: BorderSide(
        //                       //     color: CustomColors.blackBgColor,
        //                       //   ),
        //                       // ),
        //                       color: CustomColors.mainBlueColor,
        //                     ),
        //                     controller:
        //                         _tabController, // Assign TabController to TabBar
        //                     tabs: const [
        //                       Tab(
        //                         text: 'Login',
        //                       ),
        //                       Tab(
        //                         text: 'Sign Up',
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           )
        //         : const SizedBox.shrink(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 10, bottom: 10),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColors.blackBgColor.withOpacity(0.2),
                  image:
                      DecorationImage(image: NetworkImage(userData.avatarUrl))),
              // child: const Icon(Icons.person_2_outlined),
            ),
          ),
        ],
        // leading: const Padding(
        //   padding: EdgeInsets.only(top: 10.0, left: 20),
        //   child: FaIcon(FontAwesomeIcons.barsStaggered),
        // ),
      ),
      bottomNavBar: Row(
        children: [
          Expanded(
            child: Container(
              color: CustomColors.whiteBgColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    elevation: 0,
                    selectedItemColor: CustomColors.mainBlueColor,
                    unselectedItemColor: const Color.fromARGB(255, 65, 37, 37),
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    selectedFontSize: 14,
                    unselectedFontSize: 13,
                    backgroundColor: CustomColors.whiteBgColor,
                    currentIndex: menuIndex,
                    onTap: (i) {
                      ref.read(indexProvider.notifier).state = i;
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.houseFire),
                        label: '',
                        activeIcon: FaIcon(FontAwesomeIcons.houseFire),
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.fire),
                        label: '',
                        activeIcon: FaIcon(FontAwesomeIcons.fire),
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.searchengin),
                        label: '',
                        activeIcon: FaIcon(FontAwesomeIcons.searchengin),
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(Icons.message),
                        label: '',
                        activeIcon: FaIcon(Icons.message),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      builder: ((size) {
        return pages[menuIndex];
      }),
    );
  }
}
