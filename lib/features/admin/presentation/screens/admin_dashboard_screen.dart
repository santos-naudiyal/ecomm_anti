import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/admin_analytics_section.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Admin Console'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A237E),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const AdminAnalyticsSection(),
          const SizedBox(height: 32),
          Text('Operational Tools', style: AppTextStyles.headingLarge),
          const SizedBox(height: 16),
          _AdminMenuCard(
            title: 'Manage Products',
            subtitle: 'Add, Edit, Delete Products & Stock',
            icon: Icons.inventory_2,
            color: Colors.blue,
            onTap: () => context.push('/admin/products'),
          ),
          const SizedBox(height: 16),
          _AdminMenuCard(
            title: 'Manage Orders',
            subtitle: 'View Orders, Update Status',
            icon: Icons.shopping_bag,
            color: Colors.orange,
            onTap: () => context.push('/admin/orders'),
          ),
          const SizedBox(height: 16),
          _AdminMenuCard(
            title: 'Sales Analytics',
            subtitle: 'View Revenue & Trends (Coming Soon)',
            icon: Icons.bar_chart,
            color: Colors.purple,
            onTap: () {}, // Future implementation
          ),
        ],
      ),
    );
  }
}

class _AdminMenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AdminMenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
