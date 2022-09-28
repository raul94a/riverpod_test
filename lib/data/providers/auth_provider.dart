import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_test/env/env.dart';

class AuthProvider {
  AuthProvider();

  Future<Map<String, dynamic>> signUp(String email, String pwd) async {
        print('SignUp function');

    final response = await http.post(Uri.parse(Env.signUpEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': pwd, 'returnSecureToken': true}));

    if(response.statusCode  == 200 ){
      return jsonDecode(response.body);
    }
    return {'error':true};
  }

  Future<Map<String,dynamic>> sigIn(String email, String pwd) async {
    print('SignIn function');
      final response = await http.post(Uri.parse(Env.signInEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': pwd, 'returnSecureToken': true}));

    if(response.statusCode  == 200 ){
      return jsonDecode(response.body);
    }
    return {'error':true};
  }
}
