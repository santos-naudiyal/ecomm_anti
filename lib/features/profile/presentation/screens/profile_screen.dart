import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../auth/data/repositories/auth_repository_impl.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authRepositoryProvider).getCurrentUser();

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: FutureBuilder(
        future: userAsync,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = snapshot.data;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (user != null) ...[
                CircleAvatar(
                  radius: 40,
                  child: Text(
                    user.email.isEmpty ? 'U' : user.email[0].toUpperCase(),
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],

              ListTile(
                leading: const Icon(Icons.receipt_long),
                title: const Text('My Orders'),
                onTap: () => context.go('/orders'),
              ),

              const Divider(),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('My Addresses'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                // Note: Addresses are currently under Cart branch, but we link there.
                onTap: () => context.push('/cart/addresses'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text('Edit Profile'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => context.push('/profile/edit'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.local_offer, color: Colors.orange),
                title: const Text('Coupons'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No coupons available yet!')),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.people, color: Colors.green),
                title: const Text('Refer & Earn'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Referral code copied!')),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => context.push('/profile/settings'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.black,
                ),
                title: const Text('Admin Panel'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => context.push('/admin'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  ref.read(authControllerProvider.notifier).signOut();
                  context.go('/login');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
