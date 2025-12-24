enum FailureType { network, permission, notFound, validation, server, unknown }

class AppFailure {
  final String message;
  final FailureType type;

  const AppFailure({required this.message, this.type = FailureType.unknown});

  factory AppFailure.fromException(Object error) {
    final msg = error.toString();

    // 1. Permission / Auth
    if (msg.contains('permission-denied') ||
        msg.contains('User not authenticated')) {
      return const AppFailure(
        message: 'You don’t have permission to perform this action.',
        type: FailureType.permission,
      );
    }

    // 2. Network
    if (msg.contains('network')) {
      return const AppFailure(
        message: 'Please check your internet connection.',
        type: FailureType.network,
      );
    }

    // 3. Domain Logic Errors (Stock, Cart, etc.)
    // Check for common keywords we throw in Repository
    if (msg.contains('out of stock') ||
        msg.contains('Cart is empty') ||
        msg.contains('Product not found')) {
      // Remove "Exception: " prefix if present for cleaner UI
      final cleanMsg = msg.replaceAll('Exception: ', '');
      return AppFailure(message: cleanMsg, type: FailureType.validation);
    }

    // 4. Fallback
    return const AppFailure(
      message: 'Something went wrong. Please try again.',
      type: FailureType.unknown,
    );
  }
}
