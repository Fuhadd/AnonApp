import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

import '../../components/generic_dialog.dart';
import '../../utils/enum.dart';

class GenerateConfessionLinkScreen extends StatefulWidget {
  const GenerateConfessionLinkScreen({super.key});

  @override
  State<GenerateConfessionLinkScreen> createState() =>
      _GenerateConfessionLinkScreenState();
}

class _GenerateConfessionLinkScreenState
    extends State<GenerateConfessionLinkScreen> {
  StreamController<String> controllerUrl = StreamController<String>();

  void generateLink(BranchUniversalObject buo, BranchLinkProperties lp) async {
    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
    if (response.success) {
      GenericDialog()
          .showSimplePopup(type: InfoBoxType.success, content: response.result);
    } else {
      GenericDialog().showSimplePopup(
          type: InfoBoxType.error,
          content: '${response.errorCode} - ${response.errorMessage}');
    }
  }

  static const imageURL =
      'https://raw.githubusercontent.com/RodrigoSMarques/flutter_branch_sdk/master/assets/branch_logo_qrcode.jpeg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              BranchLinkProperties lp = BranchLinkProperties(
                  channel: 'facebook',
                  feature: 'sharing',
                  //parameter alias
                  //Instead of our standard encoded short url, you can specify the vanity alias.
                  // For example, instead of a random string of characters/integers, you can set the vanity alias as *.app.link/devonaustin.
                  // Aliases are enforced to be unique** and immutable per domain, and per link - they cannot be reused unless deleted.
                  //alias: 'https://branch.io' //define link url,
                  stage: 'new share',
                  campaign: 'campaign',
                  tags: ['one', 'two', 'three'])
                ..addControlParam('\$uri_redirect_mode', '1')
                ..addControlParam('\$ios_nativelink', true)
                ..addControlParam('\$match_duration', 7200)
                ..addControlParam('\$always_deeplink', true)
                ..addControlParam('\$android_redirect_timeout', 750)
                ..addControlParam('referring_user_id', 'user_id');

              return generateLink(
                BranchUniversalObject(
                    canonicalIdentifier: 'flutter/branch',
                    //parameter canonicalUrl
                    //If your content lives both on the web and in the app, make sure you set its canonical URL
                    // (i.e. the URL of this piece of content on the web) when building any BUO.
                    // By doing so, we’ll attribute clicks on the links that you generate back to their original web page,
                    // even if the user goes to the app instead of your website! This will help your SEO efforts.
                    canonicalUrl: 'https://flutter.dev',
                    title: 'Flutter Branch Plugin',
                    imageUrl: imageURL,
                    contentDescription: 'Flutter Branch Description',
                    contentMetadata: BranchContentMetaData()
                      ..addCustomMetadata('title', 'Wisper')
                      ..addCustomMetadata('custom_number', 12345)
                      ..addCustomMetadata('custom_bool', true)
                      ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
                      ..addCustomMetadata(
                          'custom_list_string', ['a', 'b', 'c']),

                    // contentMetadata: metadata,
                    keywords: ['Plugin', 'Branch', 'Flutter'],
                    publiclyIndex: true,
                    locallyIndex: true,
                    expirationDateInMilliSec: DateTime.now()
                        .add(const Duration(days: 365))
                        .millisecondsSinceEpoch),
                lp,
              );
            },
            child: const Text("Generate Link")),
      ),
    );
  }
}
