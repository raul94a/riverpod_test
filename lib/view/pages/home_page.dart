import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/state/auth_state.dart';
import 'package:riverpod_test/view/widgets/home_page/auth_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);


  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final size = MediaQuery.of(context).size;
    final notifier = ref.read(authStateNotifierProvider.notifier);
    notifier.addListener((state) {
      if (state.isError) {
        showDialog(
            context: context,
            builder: (ctx) =>
                Dialog(child: Container(decoration: BoxDecoration(color: Colors.pink), child: Text('CHORPRES'))));
      }
    });
   print('============================================');
   print('REBUILDINGGGGGG');
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            const AuthCard()
          ],
        ),
      ),
    );
  }
}
