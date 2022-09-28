class Env {
  static const String firebaseApiKey = 'AIzaSyA9dEV-LHls0VndM4NijC1by8L7BdhOMqM';
  //auth
  static const String signUpEndpoint =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$firebaseApiKey';
  static const String signInEndpoint =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$firebaseApiKey';
}
