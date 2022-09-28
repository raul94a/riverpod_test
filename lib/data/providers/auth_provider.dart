import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_test/env/env.dart';

class AuthProvider {
  //

  Future<Map<String, dynamic>> signUp(String email, String pwd) async {
    final response = await http.post(Uri.parse(Env.signUpEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': pwd, 'returnSecureToken': true}));

    if(response.statusCode  == 200 ){
      return jsonDecode(response.body);
    }
    return {'error':true};
  }
}
