import 'dart:async';

import 'package:anon/screens/confessions/confession_send_screen.dart';
import 'package:anon/screens/startup/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

import '../dashboard/dashboard_screen.dart';
import '../onboarding/onboarding_page_view.dart';

class PrelaunchScreen extends StatefulWidget {
  const PrelaunchScreen({super.key});

  @override
  State<PrelaunchScreen> createState() => _PrelaunchScreenState();
}

class _PrelaunchScreenState extends State<PrelaunchScreen> {
  BranchContentMetaData metadata = BranchContentMetaData();
  BranchUniversalObject? buo;
  BranchLinkProperties lp = BranchLinkProperties();
  BranchEvent? eventStandard;
  BranchEvent? eventCustom;

  StreamSubscription<Map>? streamSubscription;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();
  static const imageURL =
      'https://raw.githubusercontent.com/RodrigoSMarques/flutter_branch_sdk/master/assets/branch_logo_qrcode.jpeg';

  void listenDynamicLinks() async {
    // testing = "starting ...........";
    // setState(() {});
    streamSubscription = FlutterBranchSdk.initSession().listen(
      (data) {
        // testing = data.toString();
        // testing = "next 123...........";
        // setState(() {});

        if (data.containsKey('+clicked_branch_link') &&
            data['+clicked_branch_link'] == true) {
          print(
              '------------------------------------Link clicked----------------------------------------------');
          print('Custom string: ${data['title']}');
          print('Custom number: ${data['key']}');
          print('Custom bool: ${data['custom_bool']}');
          print('Custom list number: ${data['custom_list_number']}');
          print(
              '------------------------------------------------------------------------------------------------');

          var result = int.parse(data['key']);
          var destinationId = data['destinationId'];
          var destinationName = data['destinationName'];
          var destinationImage = data['destinationImage'];
          // LocalCache.saveToLocalCache(
          //     key: ConstantString.destinationId, value: destinationId);
          // LocalCache.saveToLocalCache(
          //     key: ConstantString.destinationName, value: destinationName);
          // LocalCache.saveToLocalCache(
          //     key: ConstantString.destinationImage, value: destinationImage);

          if (result == 1) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ConfessionSendScreen(
                          destinationId: destinationId,
                          destinationImage: destinationImage,
                          destinationName: destinationName,
                        )));
          }
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.hasData) {
            return const DashboardScreen();
          } else {
            return const OnboardingPageViewScreen();
          }
        });
  }
}
