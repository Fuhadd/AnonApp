import 'package:anon/utils/spacers.dart';
import 'package:flutter/material.dart';

import '../../Constants/custom_colors.dart';
import 'direct_messages_screen.dart';
import 'group_messages_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({
    super.key,
  });

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
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
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: CustomColors.blackColor,
            unselectedLabelColor: CustomColors.blackBgColor.withOpacity(0.4),
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
            controller: _tabController, // Assign TabController to TabBar
            tabs: const [
              Tab(
                text: 'Direct',
              ),
              Tab(
                text: 'Groups',
              ),
            ],
          ),
          verticalSpacer(20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller:
                    _tabController, // Assign TabController to TabBarView
                children: const [
                  DirectMessagesScreen(),
                  GroupMessagesScreen(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
