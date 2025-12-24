import 'package:antigravity/core/errors/app_failure.dart';
import 'package:flutter/material.dart';

class AppErrorView extends StatelessWidget {
  final AppFailure failure;
  final VoidCallback? onRetry;

  const AppErrorView({
    super.key,
    required this.failure,
    this.onRetry,
  });

  IconData _iconForType() {
    switch (failure.type) {
      case FailureType.network:
        return Icons.wifi_off;
      case FailureType.permission:
        return Icons.lock_outline;
      case FailureType.notFound:
        return Icons.search_off;
      case FailureType.validation:
        return Icons.warning_amber;
      default:
        return Icons.error_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _iconForType(),
              size: 64,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 16),
            Text(
              failure.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
