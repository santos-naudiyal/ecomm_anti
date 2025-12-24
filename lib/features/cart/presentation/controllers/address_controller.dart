import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/address_entity.dart';
import '../../data/repositories/address_repository_impl.dart';

part 'address_controller.g.dart';

@riverpod
class AddressController extends _$AddressController {
  @override
  FutureOr<List<AddressEntity>> build() {
    return ref.watch(addressRepositoryProvider).getAddresses();
  }

  Future<void> addAddress(
    String name,
    String street,
    String city,
    String addressState,
    String zip,
    String phone,
  ) async {
    final newAddress = AddressEntity(
      id: const Uuid().v4(),
      name: name,
      street: street,
      city: city,
      state: addressState,
      zipCode: zip,
      phoneNumber: phone,
    );
    state = const AsyncLoading();
    try {
      await ref.read(addressRepositoryProvider).addAddress(newAddress);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteAddress(String id) async {
    state = const AsyncLoading();
    try {
      await ref.read(addressRepositoryProvider).deleteAddress(id);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
