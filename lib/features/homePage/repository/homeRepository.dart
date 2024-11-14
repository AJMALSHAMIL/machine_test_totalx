import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:machine_test_totalx/core/constants/firebase_constant.dart';
import 'package:machine_test_totalx/model/adduserModel.dart';
import '../../../core/constants/faliure.dart';
import '../../../core/providers/providers.dart';


final homeRepositoryProvider = Provider((ref) => HomeRepository(
  firestore: ref.read(firestoreprovider),
  // firebaseStorage: ref.read(firebaseStorageProvider),
));

class HomeRepository {
  final FirebaseFirestore _firestore;
  // final FirebaseStorage _firebaseStorage;

  HomeRepository({
    required FirebaseFirestore firestore,
    // required FirebaseStorage firebaseStorage,
  })  : _firestore = firestore;
        // _firebaseStorage = firebaseStorage;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstant.usermodelCollection);


  Future<Either<Failure, UserModel>> addUser({
    required UserModel userModel,
    // required File file,
  }) async {
    try {
      print('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
      // print(file);
      // String imageExtension = file.path.split(".").last;
      // var uploadingImg = await _firebaseStorage
      //     .ref("users/images/${DateTime.now().toString()}")
      //     .putFile(file, SettableMetadata(contentType: "image/$imageExtension"));
      // String imageUrl = await uploadingImg.ref.getDownloadURL();
      DocumentReference documentReference = await _users.add(userModel.toJson());

      return right(userModel.copyWith(photoUrl: '', id: documentReference.id));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // Stream<List<UserModel>> StreamUser(){
  //   return _users.snapshots().map((event) => event.docs.map((e) => UserModel.fromJson(e.data()as Map<String,dynamic>) ,).toList(),) ;
  // }

  Stream<List<UserModel>> streamUsers({required String search, required String type}) {
    var query = _users.orderBy('createTime', descending: true);

    if (search.isNotEmpty) {
      query = query.where('search', arrayContains: search);
    }

    print(type);
    if (type == 'Elder') {
      query = query.where('age', isGreaterThanOrEqualTo: 60);
    } else if (type == 'Younger') {
      query = query.where('age', isLessThanOrEqualTo: 59);
    }

    return query.snapshots().map((event) =>
        event.docs.map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>)).toList());
  }



// if (search.isEmpty) {
  // return _firestore
  //     .collection(FirebaseConstants.languageCollection)
  //     .where('delete', isEqualTo: false)
  //     .snapshots()
  //     .map(
  // (event) => event.docs
  //     .map(
  // (e) => LanguagesModel.fromJson(e.data()),
  // )
  //     .toList(),
  // );
  // } else {
  // return _language
  //     .where('delete', isEqualTo: false)
  //     .where('search', arrayContains: search.toUpperCase())
  //     .snapshots()
  //     .map(
  // (event) => event.docs
  //     .map(
  // (e) =>
  // LanguagesModel.fromJson(e.data() as Map<String, dynamic>),
  // )
  //     .toList(),
  // );
  // }
  // Stream<List<UserModel>> StreamUser(String age){
  //   return age.isEmpty ?
  //   _users.snapshots().map((event) => event.docs.map((e) => UserModel.fromJson(e.data()),).toList(),) :
  //   _users.where("age",isEqualTo: age).snapshots().map((event) => event.docs.map((e) => UserModel.fromJson(e.data()),).toList(),);
  // }

}