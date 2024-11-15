import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machine_test_totalx/features/homePage/repository/homeRepository.dart';
import 'package:machine_test_totalx/model/adduserModel.dart';

import '../../../core/snackbar/snakbar.dart';

final homeControllerProvider = Provider(
  (ref) => Homecontroller(repository: ref.read(homeRepositoryProvider)),
);

final streamUser = StreamProvider.family(
  (ref, String data) =>
      ref.watch(homeControllerProvider).streamUsers(data: data),
);

class Homecontroller {
  final HomeRepository _repository;

  Homecontroller({required HomeRepository repository})
      : _repository = repository;

  addUser({
    required UserModel usermodel,
    required BuildContext context,
    // required File file
  }) async {
    final res = await _repository.addUser(
      userModel: usermodel,
      // file: file
    );
    res.fold(
      (l) {
        showSnackBar(context: context, content: l.message);
      },
      (r) {
        showSnackBar(content: 'success', context: context);
      },
    );
  }

  Stream<List<UserModel>> streamUsers({required String data}) {
    final m = jsonDecode(data);
    return _repository.streamUsers(search: m['search'], type: m['type']);
  }
}
