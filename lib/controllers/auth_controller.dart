import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/data/providers/auth_provider.dart';
import 'package:riverpod_test/state/auth_state.dart';

class AuthController {
  //constructor
  AuthController._({required WidgetRef ref}) {
    _ref = ref;
  }
  //class attributes
  static AuthController? _authController;
  late WidgetRef _ref;
  final AuthProvider _authProvider = AuthProvider();
  //getters
  WidgetRef get ref => _ref;
  AuthProvider get authProvider => _authProvider;

  //singleton
  static AuthController instance(WidgetRef reference) =>
      _authController ??= AuthController._(ref: reference);

  //methods
  //TODO: REGISTER THE PROVIDERS AND THE REPOS TO BE AUTH
  Future<bool> signUp(String e, String p) async{
    print('Triggering signUP');
    //empezamos cambiando el state a loading... envuelvo al resto en un Future.delayed
    //para que se vea bien la actualización del estado
    ref.read(authState.notifier).update(
          (state) => state.copyWith(isLoading: true),
        );
    bool canSignUp = await Future.delayed(const Duration(seconds: 7), () async {
      //inicio de sesión
      Map<String, dynamic> responseBody = await authProvider.signUp(e, p);
      print(responseBody);
      //si hay error no se inicia sesion...
      
      if (responseBody.containsKey('error')) {
        ref.read(authState.notifier).update((state) =>
            state.copyWith(isSignUp: false, isError: true, isLoading: false));
        
        return false;
      }
      //no hay error => inicio de sesion
      final state = ref.read(authState.notifier).update((state) =>
          state.copyWith(isSignUp: true, isError: false, isLoading: false));
      print(state);
      return true;
      //estas dos opciones se podrían extraer en métodos dentro del estado
      //(las he incluido y testeado... en auth_state.dart)
    });
    return canSignUp;
  }

  //registro...
  Future<bool> signIn(String email, String pwd) async {
    print('Triggering signIN');
    Map<String, dynamic> responseBody = await authProvider.sigIn(email, pwd);
    print('responseBody $responseBody');
    if(responseBody.containsKey('error')){
      return false;
    }
    final state = ref
        .read(authState.notifier)
        .update((state) => state.copyWith(isSignUp: false, isError: false));
    print(state);
    return true;
  }

  void changeToSignIn() {
    ref
        .read(authState.notifier)
        .update((state) => state.copyWith(isSignUp: false));
  }

  void changeToSignUp() {
    ref
        .read(authState.notifier)
        .update((state) => state.copyWith(isSignUp: true));
  }

  bool isSignUpPage() {
    return ref.read(authState).isSignUp;
  }
}
