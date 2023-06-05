import 'package:anon/components/generic_dialog.dart';
import 'package:anon/constants/custom_colors.dart';
import 'package:anon/models/communities_model.dart';
import 'package:anon/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../data/view_model/base_change_notifier.dart';
import '../../models/post_model.dart';

final commmunityProvider =
    ChangeNotifierProvider.autoDispose<CommunityViewModel>((ref) {
  return CommunityViewModel.initWhoAmI();
});

class CommunityViewModel extends BaseChangeNotifier {
  bool _isloading;

  String authorized = 'Not Authorized';

  CommunityViewModel.initWhoAmI()
      : _isloading = false,
        _userId = "",
        _userName = "",
        _password = "",
        _email = "";
  CommunityViewModel.profile()
      : _userId = "",
        _userName = "",
        _email = "",
        _password = "",
        _isloading = false;

  bool get isLoading => _isloading;
  String _email, _userId, _userName, _password = "";

  String get email => _email;
  String get password => _password;
  String get userId => _userId;

  String get userName => _userName;

  set isLoading(bool isloading) {
    _isloading = isloading;
    notifyListeners();
  }

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Stream<QuerySnapshot<Object?>>? getAllConfessions() {
    try {
      final confessions = userRepository.getAllConfessions();
      return confessions;
    } catch (error) {}
    return null;
  }

  Future<void> createCommunity({
    required String name,
    required String description,
    required int icon,
    required int visibility,
    required int color,
    required WidgetRef ref,
  }) async {
    try {
      isLoading = true;
      await communityRepository.createCommunity(
        name: name,
        description: description,
        icon: icon,
        visibility: visibility,
        color: color,
      );
      await discoverNewCommunities(ref);
      isLoading = false;
      navigationHandler.goBack();
    } catch (error) {
      isLoading = false;
    }
    return;
  }

  Future<void> createCommunityPost({
    required String communityId,
    required String post,
    required String categoryName,
    required DateTime createdAt,
    required WidgetRef ref,
    required String userName,
  }) async {
    try {
      isLoading = true;
      await communityRepository.createCommunityPost(
          communityId: communityId,
          post: post,
          categoryName: categoryName,
          createdAt: createdAt,
          userName: userName);

      isLoading = false;
      GenericDialog().showSimplePopup(
        type: InfoBoxType.success,
        content: "Your post has been sent for review, it will go public soon",
        onOkPressed: () {
          navigationHandler.goBack();
          navigationHandler.goBack();
        },
      );

      // navigationHandler.goBack();
    } catch (error) {
      GenericDialog().showSimplePopup(
        type: InfoBoxType.error,
        content: error.toString(),
      );
      isLoading = false;
    }
    return;
  }

  Future<List<Community>> discoverNewCommunities(WidgetRef ref) async {
    try {
      var res = await communityRepository.discoverNewCommunities();
      print(res);
      ref.read(discoveredCommunitiesProvider.notifier).state = res;
      return res;
    } catch (error) {
      print("------------------>");
      print(error.toString());
    }
    return [];
  }

  Future<List<Community>> fetchMyCommunities(WidgetRef ref) async {
    try {
      var res = await communityRepository.fetchMyCommunities();
      print(res);
      ref.read(discoveredCommunitiesProvider.notifier).state = res;
      return res;
    } catch (error) {
      print("------------------>");
      print(error.toString());
    }
    return [];
  }

  Future<List<Post>> fetchallCommunityPosts(
      WidgetRef ref, String communityId) async {
    try {
      var res = await communityRepository.fetchallCommunityPosts(communityId);
      print(res);
      ref.read(CommunityPostsProvider.notifier).state = res;
      return res;
    } catch (error) {
      print("------------------>");
      print(error.toString());
      // GenericDialog().showSimplePopup(
      //   type: InfoBoxType.error,
      //   content: error.toString(),
      // );
    }
    return [];
  }

  Future<List<Post>> fetchallCommunityPostsByCategory(
      WidgetRef ref, String communityId, String categoryName) async {
    try {
      var res = await communityRepository.fetchallCommunityPostsByCategory(
          communityId, categoryName);
      print(res);
      ref.read(CommunityPostsProvider.notifier).state = res;
      return res;
    } catch (error) {
      print("------------------>");
      print(error.toString());
      // GenericDialog().showSimplePopup(
      //   type: InfoBoxType.error,
      //   content: error.toString(),
      // );
    }
    return [];
  }

  Future<List<Post>> fetchMyCommunityPosts(
      WidgetRef ref, String communityId) async {
    try {
      var res = await communityRepository.fetchMyCommunityPosts(communityId);
      print(res);
      ref.read(CommunityPostsProvider.notifier).state = res;
      return res;
    } catch (error) {
      print("------------------>");
      print(error.toString());
      // GenericDialog().showSimplePopup(
      //   type: InfoBoxType.error,
      //   content: error.toString(),
      // );
    }
    return [];
  }

  Future<List<Post>> fetchMyCommunityPostsByCategory(
      WidgetRef ref, String communityId, String categoryName) async {
    try {
      var res = await communityRepository.fetchMyCommunityPostsByCategory(
          communityId, categoryName);
      print(res);
      ref.read(CommunityPostsProvider.notifier).state = res;
      return res;
    } catch (error) {
      print("------------------>");
      print(error.toString());
      // GenericDialog().showSimplePopup(
      //   type: InfoBoxType.error,
      //   content: error.toString(),
      // );
    }
    return [];
  }

  //  Future<List<Community>> discoverNewCommunities(WidgetRef ref) async {
  //   try {
  //     var res = await communityRepository.discoverNewCommunities();
  //     print(res);
  //     ref.read(discoveredCommunitiesProvider.notifier).state = res;
  //     return res;
  //   } catch (error) {
  //     print("------------------>");
  //     print(error.toString());
  //   }
  //   return [];
  // }

  Future<bool> checkCommunityName(
      {required String name, BuildContext? context}) async {
    isLoading = true;
    try {
      var data = await communityRepository.checkCommunityName(
        name: name,
      );
      if (data) {
        isLoading = false;
        ScaffoldMessenger.of(context!)
          ..removeCurrentSnackBar()
          ..showSnackBar(const SnackBar(
            content: Text('Community Name already exists....'),
            backgroundColor: Colors.red,
          ));

        return true;
      }
      isLoading = false;
      return false;
    } catch (error) {}
    isLoading = false;
    return false;
  }
}

final communityColorProvider =
    StateProvider<Color>((ref) => CustomColors.communityColorList[0]);

final discoveredCommunitiesProvider =
    StateProvider<List<Community>>((ref) => []);

final CommunityPostsProvider = StateProvider<List<Post>>((ref) => []);
