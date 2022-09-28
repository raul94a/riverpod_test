

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/data/providers/auth_provider.dart';
import 'package:riverpod_test/state/auth_state.dart';

class AuthController {

  late WidgetRef _ref;
  WidgetRef get ref => _ref;

  static AuthController? _authController;


  AuthController._({required WidgetRef ref}){
    _ref = ref;
  }



  static AuthController instance(WidgetRef reference){
    if(_authController == null){
      return AuthController._(ref:reference);
    }
    return _authController!;
  }


  //TODO: REGISTER THE PROVIDERS AND THE REPOS TO BE AUTH
  void toSignUp(String  e,String  p)async{
        ref.read(authState.notifier).update((state) => state.copyWith(isLoading: true),);
        print(await AuthProvider().signUp(e,p));
        print('Triggering signUP');

   final state = ref.read(authState.notifier).update((state) => state.copyWith(isSignUp: true,isError: false,isLoading: false));
     print(state);
  }
  void toSignIn(){
    print('Triggering signIN');
    final state = ref.read(authState.notifier).update((state) => state.copyWith(isSignUp: false, isError: true));
    print(state);
  }


}