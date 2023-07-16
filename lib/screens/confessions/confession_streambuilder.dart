import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'confession_card.dart';
import 'confession_view_model.dart';

class ConfessionStreamBuilder extends StatefulHookConsumerWidget {
  const ConfessionStreamBuilder({super.key, required this.read});
  final bool read;

  @override
  ConsumerState<ConfessionStreamBuilder> createState() =>
      _ConfessionStreamBuilderState();
}

class _ConfessionStreamBuilderState
    extends ConsumerState<ConfessionStreamBuilder> {
  @override
  Widget build(BuildContext context) {
    final confessionVM = ref.watch(confessionProvider);
    return widget.read == true
        ? StreamBuilder(
            stream: confessionVM.getAllReadConfessionStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return ConfessionCard(
                read: widget.read,
                snapshot: snapshot,
                confessionVM: confessionVM,
              );
            })
        : StreamBuilder(
            stream: confessionVM.getAllUnreadConfessionStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return ConfessionCard(
                read: widget.read,
                snapshot: snapshot,
                confessionVM: confessionVM,
              );
            });
  }
}
