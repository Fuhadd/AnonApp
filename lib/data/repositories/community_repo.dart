// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'package:anon/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../models/communities_model.dart';
import '../../utils/enum.dart';
import '../local_cache/local_cache.dart';

abstract class CommunityRepository {
  Future<User?> createCommunity(
      {required String name,
      required String description,
      required int icon,
      required int visibility,
      required int color});

  Future<bool> checkCommunityName({
    required String name,
  });

  Future<List<Community>> discoverNewCommunities();
  Future<List<Post>> fetchallCommunityPosts(String communityId);
  Future<List<Post>> fetchMyCommunityPosts(String communityId);
  Future<List<Post>> fetchallCommunityPostsByCategory(
      String communityId, String categoryName);
  Future<List<Post>> fetchMyCommunityPostsByCategory(
      String communityId, String categoryName);

  Future<List<Community>> fetchMyCommunities();
  Future createCommunityPost(
      {required String communityId,
      required String post,
      required String categoryName,
      required DateTime createdAt,
      required String userName});

  // Future isUserSignedIn();
}

class CommunityRepositoryImpl implements CommunityRepository {
  late LocalCache cache;

  CommunityRepositoryImpl({
    required this.cache,
  }) : super();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference firebaseFirestore =
      FirebaseFirestore.instance.collection('UserData');
  CollectionReference communityFirebaseFirestore =
      FirebaseFirestore.instance.collection('Community');
  CollectionReference postFirebaseFirestore =
      FirebaseFirestore.instance.collection('Post');

  @override
  Future<User?> createCommunity(
      {required String name,
      required String description,
      required int icon,
      required int visibility,
      required int color}) async {
    // TODO: implement createCommunity
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final docUser = communityFirebaseFirestore.doc();
    await docUser.set(
        {
          "id": docUser.id,
          "name": name,
          "description": description,
          "icon": icon,
          "members": [uid],
          "admins": [uid],
          "postIds": [],
          'color': color,
          'visibility': visibility,
          'createdBy': uid.toString(),
          "Status": CommunityStatus.pendingAprroval.index,
          "popularity": 0,
        },
        SetOptions(
          merge: true,
        ));
    return null;
    // return uid;
  }

  @override
  Future<bool> checkCommunityName({required String name}) async {
    String uid = firebaseAuth.currentUser!.uid;

    final community = communityFirebaseFirestore.where('name', isEqualTo: name);
    final snapshot = await community.get();

    if (snapshot.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<List<Community>> discoverNewCommunities() async {
    List<Community> discoveredCommunities = [];
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final QuerySnapshot querySnapshot = await communityFirebaseFirestore
        // .where('members', arrayContains: uid)
        .orderBy('popularity', descending: true)
        .get();

    // Extract the documents where the currentUserID is not present in the 'posts' array
    final List<QueryDocumentSnapshot> communities = querySnapshot.docs
        .where((doc) => !(doc['members'] as List<dynamic>).contains(uid))
        .toList();

    for (var community in communities) {
      var result = Community.fromJson(community.data());
      discoveredCommunities.add(result);
    }

    return discoveredCommunities;
  }

  @override
  Future<List<Community>> fetchMyCommunities() async {
    List<Community> discoveredCommunities = [];
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final QuerySnapshot querySnapshot = await communityFirebaseFirestore
        // .where('members', arrayContains: uid)
        .orderBy('popularity', descending: true)
        .get();

    // Extract the documents where the currentUserID is not present in the 'posts' array
    final List<QueryDocumentSnapshot> communities = querySnapshot.docs
        .where((doc) => (doc['members'] as List<dynamic>).contains(uid))
        .toList();

    for (var community in communities) {
      var result = Community.fromJson(community.data());
      discoveredCommunities.add(result);
    }

    return discoveredCommunities;
  }

  @override
  Future createCommunityPost(
      {required String communityId,
      required String post,
      required String categoryName,
      required DateTime createdAt,
      required String userName}) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final docUser = postFirebaseFirestore.doc();
    await docUser.set(
        {
          "id": docUser.id,
          "communityId": communityId,
          "post": post,
          "categoryName": categoryName,
          "createdBy": uid,
          "status": 0,
          "createdAt": createdAt,
          "userName": userName,
        },
        SetOptions(
          merge: true,
        ));

    await firebaseFirestore.doc(uid.toString()).update(
      {
        'myposts': FieldValue.arrayUnion([docUser.id]),
      },
    );
    return null;
  }

  @override
  Future<List<Post>> fetchallCommunityPosts(String communityId) async {
    List<Post> communityPosts = [];
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final QuerySnapshot querySnapshot = await postFirebaseFirestore
        .where('communityId', isEqualTo: communityId)
        .where('createdBy', isNotEqualTo: uid)
        // .orderBy('createdAt', descending: true)
        .get();

    // Extract the documents where the currentUserID is not present in the 'posts' array
    // final List<QueryDocumentSnapshot> posts = querySnapshot.docs
    //     .where((doc) => !(doc['members'] as List<dynamic>).contains(uid))
    //     .toList();

    for (var post in querySnapshot.docs) {
      var result = Post.fromJson(post.data());
      communityPosts.add(result);
    }

    return communityPosts;
  }

  @override
  Future<List<Post>> fetchMyCommunityPosts(String communityId) async {
    List<Post> communityPosts = [];
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final QuerySnapshot querySnapshot = await postFirebaseFirestore
        .where('communityId', isEqualTo: communityId)
        .where('createdBy', isEqualTo: uid)
        // .orderBy('createdAt', descending: true)
        .get();

    // Extract the documents where the currentUserID is not present in the 'posts' array
    // final List<QueryDocumentSnapshot> posts = querySnapshot.docs
    //     .where((doc) => !(doc['members'] as List<dynamic>).contains(uid))
    //     .toList();

    for (var post in querySnapshot.docs) {
      var result = Post.fromJson(post.data());
      communityPosts.add(result);
    }

    return communityPosts;
  }

  @override
  Future<List<Post>> fetchMyCommunityPostsByCategory(
      String communityId, String categoryName) async {
    List<Post> communityPosts = [];
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final QuerySnapshot querySnapshot = await postFirebaseFirestore
        .where('communityId', isEqualTo: communityId)
        .where('createdBy', isEqualTo: uid)
        .where('categoryName', isEqualTo: categoryName)
        // .orderBy('createdAt', descending: true)
        .get();

    // Extract the documents where the currentUserID is not present in the 'posts' array
    // final List<QueryDocumentSnapshot> posts = querySnapshot.docs
    //     .where((doc) => !(doc['members'] as List<dynamic>).contains(uid))
    //     .toList();

    for (var post in querySnapshot.docs) {
      var result = Post.fromJson(post.data());
      communityPosts.add(result);
    }

    return communityPosts;
  }

  @override
  Future<List<Post>> fetchallCommunityPostsByCategory(
      String communityId, String categoryName) async {
    List<Post> communityPosts = [];
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final QuerySnapshot querySnapshot = await postFirebaseFirestore
        .where('communityId', isEqualTo: communityId)
        .where('createdBy', isNotEqualTo: uid)
        .where('categoryName', isEqualTo: categoryName)
        // .orderBy('createdAt', descending: true)
        .get();

    // Extract the documents where the currentUserID is not present in the 'posts' array
    // final List<QueryDocumentSnapshot> posts = querySnapshot.docs
    //     .where((doc) => !(doc['members'] as List<dynamic>).contains(uid))
    //     .toList();

    for (var post in querySnapshot.docs) {
      var result = Post.fromJson(post.data());
      communityPosts.add(result);
    }

    return communityPosts;
  }

  // Future<List<Community>?> discoverNewCommunities(
  //     List<dynamic> groupMembersId) async {
  //   List<AppUser> nonMembers = [];
  //   List<List<dynamic>> subList = [];
  //   try {
  //     for (var i = 0; i < groupMembersId.length; i += 10) {
  //       subList.add(groupMembersId.sublist(i,
  //           i + 10 > groupMembersId.length ? groupMembersId.length : i + 10));
  //     }
  //     for (var element in subList) {
  //       await employeeFirebaseFirestore
  //           // .orderBy("id", descending: true)
  //           .where("id", whereIn: element)
  //           .get()
  //           .then((value) {
  //         for (var snapshot in value.docs) {
  //           var result = AppUser.fromJson(snapshot.data());
  //           nonMembers.add(result);
  //         }
  //       });
  //     }

  //     return nonMembers;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return null;
  // }
}
