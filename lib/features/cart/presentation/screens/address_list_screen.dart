import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/address_controller.dart';

class AddressListScreen extends ConsumerWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressAsync = ref.watch(addressControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Addresses')),
      body: addressAsync.when(
        data: (addresses) {
          if (addresses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No addresses found'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.push('/cart/addresses/add'),
                    child: const Text('Add Address'),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: addresses.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final address = addresses[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(address.name),
                  subtitle: Text(
                    '${address.street}, ${address.city}, ${address.state} ${address.zipCode}\n${address.phoneNumber}',
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      ref
                          .read(addressControllerProvider.notifier)
                          .deleteAddress(address.id);
                    },
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/cart/addresses/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
