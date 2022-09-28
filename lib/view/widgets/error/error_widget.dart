import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/state/auth_state.dart';

class CustomErrorWidget extends ConsumerWidget {
  const CustomErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Ha ocurrido un error...'),
      actions: [
        TextButton(
            onPressed: () {
              ref
                  .read(authState.notifier)
                  .update((state) => state.copyWith(isError: false));
            },
            child: const Text('Continuar'))
      ],
    );
  }
}
