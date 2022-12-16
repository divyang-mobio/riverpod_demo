import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/database/local_database.dart';
import 'package:riverpod_demo/utils/provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Stream<List<SafeTableData>> counter = ref.watch(counterProvider).getData();
    return Scaffold(
      appBar: AppBar(title: const Text('RiverPod Demo')),
      body: StreamBuilder<List<SafeTableData>>(
          stream: counter,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) => GestureDetector(
                        onDoubleTap: () {
                          ref.read(counterProvider.notifier).state.updateData(
                              SafeTableData(
                                  id: snapshot.data?[index].id as int,
                                  name: "update"));
                        },
                        onTap: () {
                          ref.read(counterProvider.notifier).state.deleteData(
                              snapshot.data?[index] as SafeTableData);
                        },
                        child: ListTile(
                          title: Text((snapshot.data?[index].name).toString()),
                        ),
                      ));
            } else {
              return const CircularProgressIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref
                .read(counterProvider.notifier)
                .state
                .insertData(const SafeTableData(name: "name"));
          },
          child: const Icon(Icons.add)),
    );
  }
}
