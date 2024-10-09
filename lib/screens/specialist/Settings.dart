import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Settings', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Notification'),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Handle notification switch
                },
              ),
            ),
            ListTile(
              title: const Text('Location'),
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  // Handle location switch
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle save button press
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}