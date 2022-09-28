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
    print('Building AuthCard');
    //en el estado vas a ver que hay dos controller declarados. No les hagas caso, estos son los importantes
    final uController = TextEditingController(text: '');
    final pController = TextEditingController(text: '');
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // print(details.toString());
        double dx = details.velocity.pixelsPerSecond.dx;

        dx < 0 ? controller.changeToSignIn() : controller.changeToSignUp();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            gradient: const LinearGradient(tileMode: TileMode.decal, colors: [
              Color.fromARGB(255, 216, 112, 105),
              Color.fromARGB(255, 194, 92, 212)
            ]),
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
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 3)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255))),
                        hintText: 'email@riverpod.com',
                        hintStyle: TextStyle(color: Colors.white),
                        label: Text(
                          'Email',
                          style: TextStyle(color: Colors.white),
                        )),
                    controller: uController)),
            SizedBox(
              height: size.height * 0.15,
            ),
            //password
            SizedBox(
                width: size.width * 0.8,
                child: TextField(
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 3)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255))),
                        hintText: '*********',
                        hintStyle: TextStyle(color: Colors.white),
                        label: Text(
                          'Password',
                          style: TextStyle(color: Colors.white),
                        )),
                    controller: pController)),
            Consumer(
                builder: (ctx, ref, _) => ElevatedButton(
                    // style: const  ButtonStyle(
                    //   alignment: Alignment.centerRight
                    // ),
                    onPressed: ref.watch(authState).isLoading
                        ? null
                        : () async {
                            if (controller.isSignUpPage()) {
                              bool success = await controller.signUp(
                                  uController.text, pController.text);
                              if (!success) {
                                errorDialog(context, ref);
                              }
                              return;
                            }
                            bool success = await controller.signIn(
                                uController.text, pController.text);
                            if (!success) {
                              errorDialog(context, ref);
                            }
                          },

                    //Cómo actualizar Únicamente un solo Widget? con el Consumer!
                    child: ref.watch(authState).isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(ref.watch(authState).isSignUp
                            ? 'Sign Up'
                            : 'Sign In'))),
          ],
        ),
      ),
    );
  }

  void errorDialog(BuildContext context, WidgetRef ref) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ha ocurrido un error...'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ref
                        .read(authState.notifier)
                        .update((state) => state.copyWith(isError: false));
                  },
                  child: const Text('Continuar'))
            ],
          );
        });
  }
}
