import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/state/auth_state.dart';
import 'package:riverpod_test/view/widgets/error/error_widget.dart';
import 'package:riverpod_test/view/widgets/home_page/auth_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final notifier = ref.read(authStateNotifierProvider.notifier);
    notifier.addListener((state) {
      if (state.isError) {
        print('Ha habido un error');
      }
    });
    print('============================================');
    print('REBUILDING Home page');
    print('============================================');

    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            return Text(ref.watch(authState).isSignUp ? 'Sign Up' : 'Sign In');
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //error watcher
            
              //Loading watcher
              Consumer(
                  builder: (ctx, ref, child) => ref.watch(authState).isLoading
                      ? const CircularProgressIndicator(
                          semanticsLabel: 'loading...',
                        )
                      : const SizedBox()),
              const AuthCard()
            ],
          ),
        ),
      ),
    );
  }
}
