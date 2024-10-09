import 'package:flutter/material.dart';

class RatingsPage extends StatefulWidget {
  const RatingsPage({super.key});

  @override
  _RatingsPageState createState() => _RatingsPageState();
}

class _RatingsPageState extends State<RatingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ratings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Ratings', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.star, size: 24),
                Text('5.0', style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 16),
            const Text('This app is awesome!', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle rating button press
              },
              child: const Text('Rate Now'),
            ),
          ],
        ),
      ),
    );
  }
}