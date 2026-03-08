import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gamification_controller.g.dart';

@Riverpod(keepAlive: true)
class GamificationController extends _$GamificationController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<Map<String, dynamic>> build() {
    const userId = 'user_123';
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('gamification')
        .doc('stats')
        .snapshots()
        .map((doc) => doc.data() ?? {'coins': 0, 'lastLogin': null, 'streak': 0});
  }

  Future<void> claimDailyReward() async {
    const userId = 'user_123';
    final statsDoc = _firestore
        .collection('users')
        .doc(userId)
        .collection('gamification')
        .doc('stats');

    final doc = await statsDoc.get();
    final data = doc.data() ?? {};
    final lastLogin = (data['lastLogin'] as Timestamp?)?.toDate();
    final now = DateTime.now();

    if (lastLogin != null &&
        lastLogin.year == now.year &&
        lastLogin.month == now.month &&
        lastLogin.day == now.day) {
      // Already claimed today
      return;
    }

    await statsDoc.set({
      'coins': FieldValue.increment(50),
      'lastLogin': FieldValue.serverTimestamp(),
      'streak': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  Future<void> rewardForReview() async {
    const userId = 'user_123';
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('gamification')
        .doc('stats')
        .update({'coins': FieldValue.increment(100)});
  }
}
