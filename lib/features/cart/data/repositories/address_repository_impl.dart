import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/address_repository.dart';

part 'address_repository_impl.g.dart';

class AddressRepositoryImpl implements AddressRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser?.uid ?? '';

  @override
  Future<List<AddressEntity>> getAddresses() async {
    if (_uid.isEmpty) return [];
    final snapshot = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('addresses')
        .get();
    return snapshot.docs
        .map((doc) => AddressEntity.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> addAddress(AddressEntity address) async {
    if (_uid.isEmpty) return;
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('addresses')
        .doc(address.id)
        .set(address.toJson());
  }

  @override
  Future<void> updateAddress(AddressEntity address) async {
    if (_uid.isEmpty) return;
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('addresses')
        .doc(address.id)
        .update(address.toJson());
  }

  @override
  Future<void> deleteAddress(String id) async {
    if (_uid.isEmpty) return;
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('addresses')
        .doc(id)
        .delete();
  }
}

@Riverpod(keepAlive: true)
AddressRepository addressRepository(AddressRepositoryRef ref) {
  return AddressRepositoryImpl();
}
