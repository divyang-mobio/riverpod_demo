import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/local_database.dart';
import '../utils/provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Stream<List<DemoTableData>> counter = ref.watch(dataProvider).getData();
    return Scaffold(
      appBar: AppBar(title: const Text('RiverPod Demo')),
      body: StreamBuilder<List<DemoTableData>>(
          stream: counter,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) => GestureDetector(
                        onDoubleTap: () {
                          ref.read(dataProvider.notifier).state.updateData(
                              DemoTableData(
                                  id: snapshot.data?[index].id as int,
                                  name: "update"));
                        },
                        onTap: () {
                          ref.read(dataProvider.notifier).state.deleteData(
                              snapshot.data?[index] as DemoTableData);
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
                .read(dataProvider.notifier)
                .state
                .insertData(const DemoTableData(name: "name"));
          },
          child: const Icon(Icons.add)),
    );
  }
}
