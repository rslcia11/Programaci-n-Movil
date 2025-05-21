import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Esta es la primera pantalla',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Image.network(
              'https://img.freepik.com/free-photo/sports-motorcycle-speed-motion-blur-dark-background_645697-1864.jpg',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailScreen(),
                  ),
                );
              },
              child: const Text('Seguir a la segunda pantalla', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Esta es la segunda pantalla',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'SALU2',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            Image.network(
              'https://img.freepik.com/free-photo/red-sports-bike-black-background_1150-4694.jpg',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Image.network(
              'https://img.freepik.com/free-photo/blue-black-powerful-motorcycle-road_114579-4070.jpg',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver a la primera pantalla', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}