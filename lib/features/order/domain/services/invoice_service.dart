import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

import '../../../cart/domain/entities/address_entity.dart';
import '../../domain/entities/order_entity.dart';

class InvoiceService {
  Future<void> generateAndDownloadInvoice({
    required OrderEntity order,
    required AddressEntity address,
  }) async {
    final pdf = pw.Document();

    // Standard Font (optional, can load custom fonts)
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        theme: pw.ThemeData.withFont(base: font),
        build: (pw.Context context) {
          return [
            _buildHeader(order),
            pw.SizedBox(height: 20),
            _buildAddressSection(address),
            pw.SizedBox(height: 20),
            _buildItemsTable(order.items),
            pw.Divider(),
            _buildTotalSection(order),
            pw.SizedBox(height: 20),
            _buildFooter(),
          ];
        },
      ),
    );

    // Share/Print/Download
    final String filename = 'Invoice_${order.id.substring(0, 8)}.pdf';
    await Printing.sharePdf(bytes: await pdf.save(), filename: filename);
  }

  pw.Widget _buildHeader(OrderEntity order) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'INVOICE',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text('Order ID: ${order.id}'),
            pw.Text(
              'Date: ${DateFormat('dd MMM yyyy').format(order.createdAt)}',
            ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              'E-Com App',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text('support@ecomapp.com'),
            pw.Text('+91 1234567890'),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildAddressSection(AddressEntity address) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Bill To:',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(address.name),
        pw.Text(address.street),
        pw.Text('${address.city}, ${address.state} - ${address.zipCode}'),
        pw.Text('Phone: ${address.phoneNumber}'),
      ],
    );
  }

  pw.Widget _buildItemsTable(List<OrderItem> items) {
    final headers = ['Product', 'Qty', 'Price', 'Total'];
    final data = items.map((item) {
      final total = (item.price * item.quantity) / 100.0;
      return [
        item.name,
        '${item.quantity}',
        '${(item.price / 100).toStringAsFixed(2)}',
        '${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return pw.Table.fromTextArray(
      headers: headers,
      data: data,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
      },
    );
  }

  pw.Widget _buildTotalSection(OrderEntity order) {
    final total = order.totalAmount / 100.0;
    // Assuming simple tax calculation reverse engineering or just total
    // For now showing Total Amount directly
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              'Grand Total:  ${total.toStringAsFixed(2)}',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildFooter() {
    return pw.Center(
      child: pw.Text(
        'Thank you for your business!',
        style: const pw.TextStyle(color: PdfColors.grey),
      ),
    );
  }
}

// Provider
final invoiceServiceProvider = Provider<InvoiceService>((ref) {
  return InvoiceService();
});
