import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateNotifierProvider =
    StateNotifierProvider((ref) => ref.read(authState.notifier));
    
final authState = StateProvider(((ref) {
  final AuthStateProvider authProvider = AuthStateProvider(
      emailController: TextEditingController(text: ''),
      pwdController: TextEditingController(text: ''));

  ref.onDispose(() {
    print('============================================');
    print('DISPOSING SERVERAL THINGS');
    print('============================================');
    authProvider.emailController!.dispose();
    authProvider.pwdController!.dispose();
  });

  return authProvider;
}));

class AuthStateProvider {
  bool isLoading;
  bool isError;
  bool isSignUp;
  bool isAuth;
  TextEditingController? pwdController;
  TextEditingController? emailController;

  AuthStateProvider(
      {this.isAuth = false,
      this.isError = false,
      this.isLoading = false,
      this.isSignUp = true,
      this.emailController,
      this.pwdController});

  AuthStateProvider copyWith({
    bool? isLoading,
    bool? isError,
    bool? isSignUp,
    bool? isAuth,
    TextEditingController? pwdController,
    TextEditingController? emailController,
  }) {
    return AuthStateProvider(
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        isSignUp: isSignUp ?? this.isSignUp,
        isAuth: isAuth ?? this.isAuth,
        emailController: emailController ?? this.emailController,
        pwdController: pwdController ?? this.emailController);
  }

  @override
  String toString() {
    return 'AuthStateProvider(isLoading: $isLoading, isError: $isError, isSignUp: $isSignUp, isAuth: $isAuth, pwdController: $pwdController, emailController: $emailController)';
  }
}
