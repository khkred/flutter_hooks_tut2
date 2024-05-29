import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(
        transform ?? (e) => e,
      ).where((e) => e != null).cast();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

const imageUrl =
    'https://images.unsplash.com/photo-1716407406496-e9cafce02032?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(() => NetworkAssetBundle(Uri.parse(imageUrl))
        .load(imageUrl)
        .then((data) => data.buffer.asUint8List())
        .then((data) => Image.memory(data)));

    final snapshot = useFuture(future);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: snapshot.connectionState == ConnectionState.waiting
              ? const CircularProgressIndicator()
              : snapshot.hasError
                  ? Text('Error : ${snapshot.error}')
                  : snapshot.data,
        ),
      ),
    );
  }
}
