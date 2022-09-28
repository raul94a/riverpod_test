import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/controllers/auth_controller.dart';
import 'package:riverpod_test/state/auth_state.dart';

class AuthCard extends ConsumerWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final controller = AuthController.instance(ref);

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // print(details.toString());
        double dx = details.velocity.pixelsPerSecond.dx;

        dx < 0
            ? controller.toSignIn()
            : controller.toSignUp(
                ref.read(authState).emailController!.text, ref.read(authState).pwdController!.text);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                tileMode: TileMode.decal,
                colors: [Color.fromARGB(255, 216, 112, 105), Color.fromARGB(255, 194, 92, 212)]),
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 201, 201, 206),
                  spreadRadius: 7,
                  blurRadius: 12,
                  offset: Offset(2, 3))
            ]),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            //email
            Container(
                margin: const EdgeInsets.only(top: 15),
                width: size.width * 0.8,
                child: TextField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 3)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255))),
                      hintText: 'email@riverpod.com',
                      hintStyle: TextStyle(color: Colors.white),
                      label: Text(
                        'Email',
                        style: TextStyle(color: Colors.white),
                      )),
                  controller: ref.read(authState.notifier).state.emailController,
                )),
            SizedBox(
              height: size.height * 0.11,
            ),
            //password
            SizedBox(
                width: size.width * 0.8,
                child: TextField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 3)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255))),
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.white),
                      label: Text(
                        'Password',
                        style: TextStyle(color: Colors.white),
                      )),
                  controller: ref.read(authState.notifier).state.pwdController,
                )),
            ElevatedButton(
                // style: const  ButtonStyle(
                //   alignment: Alignment.centerRight
                // ),
                onPressed: () {
                  //ON LOGIN
                },
                child: Consumer(
                    builder: (ctx, ref, child) => ref.watch(authState).isLoading
                        ? CircularProgressIndicator()
                        : Text(ref.watch(authState).isSignUp ? 'Sign Up' : 'Sign In'))),
          ],
        ),
      ),
    );
  }
}
