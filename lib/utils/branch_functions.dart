import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

import '../components/generic_dialog.dart';
import '../constants/custom_string.dart';
import '../data/local_cache/local_cache.dart';
import '../locator.dart';
import 'enum.dart';

class BranchFunctions {
  static void generateLink(
      String destinationName, String destinationId, destinationImage,
      {dynamic Function()? onOkPressed}) async {
    const imageURL =
        'https://raw.githubusercontent.com/RodrigoSMarques/flutter_branch_sdk/master/assets/branch_logo_qrcode.jpeg';

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

    BranchUniversalObject buo = BranchUniversalObject(
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
          ..addCustomMetadata('key', 1)
          ..addCustomMetadata('destinationName', destinationName)
          ..addCustomMetadata('destinationId', destinationId)
          ..addCustomMetadata('destinationImage', destinationImage),
        // contentMetadata: metadata,
        keywords: ['Plugin', 'Branch', 'Flutter'],
        publiclyIndex: true,
        locallyIndex: true,
        expirationDateInMilliSec: DateTime.now()
            .add(const Duration(days: 365))
            .millisecondsSinceEpoch);
    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
    if (response.success) {
      print(response.result);
      await locator<LocalCache>().saveToLocalCache(
          key: ConstantString.referralLink, value: response.result);
      GenericDialog().showSimplePopup(
          type: InfoBoxType.success,
          content: response.result,
          title: 'Confession Link generated',
          onOkPressed: onOkPressed);
    } else {
      GenericDialog().showSimplePopup(
          type: InfoBoxType.error,
          content: '${response.errorCode} - ${response.errorMessage}');
    }
  }
}
