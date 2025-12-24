import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final notifications = List.generate(
      5,
      (index) => {
        'title': index % 2 == 0 ? 'Order Update' : 'Special Offer',
        'body': index % 2 == 0
            ? 'Your order #1234$index has been shipped!'
            : 'Get 50% off on electronics this weekend!',
        'time': '${index + 1}h ago',
        'isOrder': index % 2 == 0,
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final n = notifications[index];
          final isOrder = n['isOrder'] as bool;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isOrder
                  ? Colors.blue.withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1),
              child: Icon(
                isOrder ? Icons.local_shipping : Icons.local_offer,
                color: isOrder ? Colors.blue : Colors.orange,
              ),
            ),
            title: Text(
              n['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(n['body'] as String),
            trailing: Text(
              n['time'] as String,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          );
        },
      ),
    );
  }
}
