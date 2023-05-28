import 'dart:async';
import 'dart:convert';
import 'dart:math' as maths;

import 'package:anon/models/app_user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/custom_string.dart';
import '../../data/view_model/base_change_notifier.dart';
import '../../utils/profile_avatar_links.dart';
import '../dashboard/dashboard_screen.dart';

final authProvider = ChangeNotifierProvider.autoDispose<AuthViewModel>((ref) {
  return AuthViewModel.initWhoAmI();
});

class AuthViewModel extends BaseChangeNotifier {
  bool _isloading;

  String authorized = 'Not Authorized';

  AuthViewModel.initWhoAmI()
      : _isloading = false,
        _userId = "",
        _userName = "",
        _password = "",
        _email = "";
  AuthViewModel.profile()
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

  Future<void> signUp(email, password, userName,
      {BuildContext? context}) async {
    try {
      isLoading = true;
      final user = await userRepository.createUserWithEmail(
        email,
        password,
      );

      if (user != null) {
        _email = email;
        maths.Random random = maths.Random();
        int randomNumber = random.nextInt(11);
        String avatarUrl = avatarLinks[randomNumber];

        var userId = await userRepository.saveUserCredentials(
            email, userName, avatarUrl, DateTime.now());

        if (userId != null) {
          AppUser user = AppUser(
              id: userId,
              userName: userName,
              email: email,
              myposts: [],
              avatarUrl: avatarUrl);
          final userJson = json.encode(user.toJson());
          localCache.saveToLocalCache(
              key: ConstantString.userJson, value: userJson);
        }

        isLoading = false;

        navigationHandler.pushNamed(
          DashboardScreen.routeName,
        );
      } else {
        isLoading = false;

        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isLoading = false;
      ScaffoldMessenger.of(context!)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> signIn(email, password, {BuildContext? context}) async {
    try {
      isLoading = true;
      final user = await userRepository.loginWithEmail(
        email,
        password,
      );

      if (user != null) {
        _email = email;
        var user = await userRepository.getUsersCredentials();

        if (user != null) {
          final userJson = json.encode(user.toJson());
          localCache.saveToLocalCache(
              key: ConstantString.userJson, value: userJson);
        }

        isLoading = false;

        navigationHandler.pushNamed(
          DashboardScreen.routeName,
        );
      } else {
        isLoading = false;
      }
    } catch (e, stacktrace) {
      isLoading = false;
      ScaffoldMessenger.of(context!)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }
}
