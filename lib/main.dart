import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(
    const MyApp(),
  );
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

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final text = useState('');

    useEffect((){
      emailController.addListener((){
        text.value = emailController.text;
        print("New Text Value: ${text.value}");
      });
      return null;
    },[emailController]);

    return  Scaffold(
      appBar: AppBar(title: const Text('Home Page'),),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: emailController,),
            const SizedBox(height: 20,),
            Text('You have typed: ${text.value}'),
          ],
        ),
      ),

    );

  }
}
