import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

Stream<String> getTime() => Stream.periodic(const Duration(seconds: 1),(_) => DateTime.now().toString());

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

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTime = useStream(getTime());

    return  Scaffold(
      appBar: AppBar(title:  Text(currentTime.data ?? ' '),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );

  }
}
