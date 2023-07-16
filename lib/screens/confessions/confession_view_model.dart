import 'dart:async';
import 'dart:convert';

import 'package:anon/models/confession_response_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/generic_dialog.dart';
import '../../constants/custom_string.dart';
import '../../data/view_model/base_change_notifier.dart';
import '../../utils/enum.dart';

final confessionProvider =
    ChangeNotifierProvider.autoDispose<ConfessionViewModel>((ref) {
  return ConfessionViewModel.initWhoAmI();
});

class ConfessionViewModel extends BaseChangeNotifier {
  bool _isloading;

  String authorized = 'Not Authorized';

  ConfessionViewModel.initWhoAmI()
      : _isloading = false,
        _userId = "",
        _userName = "",
        _password = "",
        _email = "";
  ConfessionViewModel.profile()
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

  // Stream<QuerySnapshot<Object?>>? getAllConfessions() {
  //   try {
  //     final confessions = userRepository.getAllConfessions();

  //     return confessions;
  //   } catch (error) {}
  //   return null;
  // }

  // Future<void> getPastConfessors(WidgetRef ref) async {
  //   try {
  //     final confessions = await userRepository.getPastConfessors();
  //     for (var confession in confessions) {
  //       var result = ConfessionResponse.fromJson(confession);
  //       ref.read(confessionsProviderList.notifier).state = [
  //         ...ref.watch(confessionsProviderList),
  //         result
  //       ];

  //       // ref.read(discoverMatchesProvider.notifier).state.add(userData);
  //     }
  //   } catch (error) {}
  //   return;
  // }

  Future<void> sendConfession(
      {required String message,
      required String destinationName,
      required String destinationId,
      required String destinationImage,
      required GlobalKey<FormBuilderState> formKey,
      required WidgetRef ref}) async {
    try {
      isLoading = true;
      var result = await userRepository.sendConfession(
          message: message,
          destinationName: destinationName,
          destinationId: destinationId,
          destinationImage: destinationImage);
      if (result == true) {
        var user = await userRepository.getUsersCredentials();

        if (user != null) {
          final userJson = json.encode(user.toJson());
          localCache.saveToLocalCache(
              key: ConstantString.userJson, value: userJson);
        }
        isLoading = false;
        GenericDialog().showSimplePopup(
          type: InfoBoxType.success,
          content: "Your anonymous message has been sent",
          onOkPressed: () {
            navigationHandler.goBack();
            formKey.currentState?.fields['message']!.reset();
            ref.read(sendAnotherMessage.notifier).state = true;
          },
        );
      } else {
        isLoading = false;
        GenericDialog().showSimplePopup(
          type: InfoBoxType.error,
          content: 'Try again Later',
        );
      }
    } catch (e, stacktrace) {
      isLoading = false;
      GenericDialog().showSimplePopup(
        type: InfoBoxType.error,
        content: e.toString(),
      );
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
    // return;
  }

  Future<void> getAllConfessions(WidgetRef ref) async {
    try {
      final confessions = await userRepository.getAllConfessions();
      for (var confession in confessions) {
        var result = ConfessionResponse.fromJson(confession);
        ref.read(confessionsProviderList.notifier).state = [
          ...ref.watch(confessionsProviderList),
          result
        ];

        // ref.read(discoverMatchesProvider.notifier).state.add(userData);
      }
    } catch (error) {}
    return;
  }

  Stream<QuerySnapshot> getAllConfessionStream() {
    return userRepository.getAllConfessionStream();
  }

  Future<void> readConfession(String confessionId) async {
    await userRepository.readConfession(confessionId: confessionId);
  }

  Stream<QuerySnapshot> getAllReadConfessionStream() {
    return userRepository.getAllReadConfessionStream();
  }

  Stream<QuerySnapshot> getAllUnreadConfessionStream() {
    return userRepository.getAllUnreadConfessionStream();
  }

  // Future<void> getUsersForMatching({
  //   required int pageNumber,
  //   required int pageSize,
  //   required WidgetRef ref,
  //   BuildContext? context,
  // }) async {
  //   try {
  //     isLoading = true;
  //     final res = await userRepository.getUsersForMatching(
  //       pageNumber,
  //       pageSize,
  //     );

  //     if (res.success) {
  //       for (var users in res.data) {
  //         var userData = UserDataModel.fromJson(users);
  //         ref.read(confessionsProvider.notifier).state = [
  //           ...ref.watch(confessionsProvider),
  //           userData
  //         ];

  //         // ref.read(discoverMatchesProvider.notifier).state.add(userData);
  //       }
  //     } else {
  //       isLoading = false;
  //       ScaffoldMessenger.of(context!)
  //         ..removeCurrentSnackBar()
  //         ..showSnackBar(SnackBar(
  //           content: Text(res.errors!.join('\n')),
  //           backgroundColor: Colors.red,
  //         ));
  //     }
  //   } catch (e, stacktrace) {
  //     isLoading = false;
  //     debugPrint(e.toString());

  //     log(e.toString());
  //     log(stacktrace.toString());
  //   }
  // }
}

final confessionsProviderList =
    StateProvider<List<ConfessionResponse>>((ref) => []);
final sendAnotherMessage = StateProvider.autoDispose<bool>((ref) => false);
