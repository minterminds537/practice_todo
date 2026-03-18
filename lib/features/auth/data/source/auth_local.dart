import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:practice/core/services/storage_service.dart';
import 'package:practice/features/auth/data/models/sign_up_model.dart';
import '../../../../core/utils/constants/key_string.dart';

abstract class AuthLocal {
   Future<bool> signUpUser(SignUpModel user);
   Future<SignUpModel?> loginUser(String email, String password);
 }


 class AuthLocalImpl implements AuthLocal{
    final StorageService _storageService;
    AuthLocalImpl({required StorageService storageService}) : _storageService = storageService;

  @override
  Future<bool>signUpUser(SignUpModel user) async {
    try{
      await _storageService.put(AppKeys.userBox, user.email!, jsonEncode(user.toJson()));
      return true;
    }catch(e,stack){
      debugPrint(e.toString());
      debugPrint(stack.toString());
      return false;
    }
  }

  @override
  Future<SignUpModel?> loginUser(String email, String password) async  {
    try{
     var result =  await _storageService.get(AppKeys.userBox, email);
     debugPrint(result);
     if(result == null){
       return null;
     }
     var user = SignUpModel.fromJson(jsonDecode(result));
     print("from local password ${user.password}");
    return user;
    }catch(e,stack){
      debugPrint(e.toString());
      debugPrint(stack.toString());
      return null;
    }
  }

 }