import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machine_test_totalx/features/homePage/repository/homeRepository.dart';
import 'package:machine_test_totalx/model/adduserModel.dart';

import '../../../core/snackbar/snakbar.dart';

final homeControllerProvider = Provider((ref) => Homecontroller(repository: ref.read(homeRepositoryProvider)),);

class Homecontroller {
  final HomeRepository _repository;

  Homecontroller({required HomeRepository repository})
      :_repository=repository;

  // addUser({required UserModel usermodel,required File file}){
  //   _repository.addUser(usermodel: usermodel, file: file);
  // }

  addUser({required UserModel usermodel,required File file,required BuildContext context})async{
  final res=  await _repository.addUser(file: file,userModel: usermodel);
  res.fold((l) {
    print('llllllllllllllllll');
    print(l.message);
    showSnackBar(context: context,content: l.message);
  }, (r) {
    print('rrrrrrrrrrrrrrrrrrr');
    showSnackBar(content: 'success',context: context);
  },);
  }


}