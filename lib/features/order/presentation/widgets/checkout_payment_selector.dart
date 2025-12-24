import 'package:flutter/material.dart';

class CheckoutPaymentSelector extends StatelessWidget {
  final String selectedMethod; // 'COD', 'Card', 'UPI'
  final ValueChanged<String> onMethodSelected;

  const CheckoutPaymentSelector({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'Payment Method',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            _buildPaymentOption(
              context,
              id: 'COD',
              title: 'Cash on Delivery',
              icon: Icons.money,
              subtitle: 'Pay when you receive the order',
            ),
            const SizedBox(height: 12),
            _buildPaymentOption(
              context,
              id: 'UPI',
              title: 'UPI / GPay',
              icon: Icons.qr_code,
              subtitle: 'Coming Soon',
              enabled: true,
            ),
            const SizedBox(height: 12),
            _buildPaymentOption(
              context,
              id: 'Card',
              title: 'Credit / Debit Card',
              icon: Icons.credit_card,
              subtitle: 'Visa, Mastercard, etc.',
              enabled: true,
            ),
            const SizedBox(height: 12),
            _buildPaymentOption(
              context,
              id: 'GPay',
              title: 'Google Pay',
              icon: Icons
                  .payment, // Using generic icon as font_awesome might not be there
              subtitle: 'Secure payment via Google',
              enabled: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
    BuildContext context, {
    required String id,
    required String title,
    required IconData icon,
    String? subtitle,
    bool enabled = true,
  }) {
    final isSelected = selectedMethod == id;
    final primaryColor = Theme.of(context).primaryColor;

    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: GestureDetector(
        onTap: enabled ? () => onMethodSelected(id) : null,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withOpacity(0.05) : Colors.white,
            border: Border.all(
              color: isSelected ? primaryColor : Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.blueGrey),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle, color: primaryColor)
              else
                const Icon(Icons.circle_outlined, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
