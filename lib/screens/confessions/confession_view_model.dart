import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/view_model/base_change_notifier.dart';

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

  Stream<QuerySnapshot<Object?>>? getAllConfessions() {
    try {
      final confessions = userRepository.getAllConfessions();
      return confessions;
    } catch (error) {}
    return null;
  }
}
