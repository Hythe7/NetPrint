import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  void _onClose() {
    // TODO: Implement close or dismiss logic
    debugPrint("Close tapped");
  }

  void _onBack(BuildContext context) {
    Navigator.pop(context);
  }

  void _onPlaceOrder() {
    // TODO: Implement place order logic
    debugPrint("Place order tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => _onBack(context),
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: _onClose,
          ),
        ],
      ),

      // Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // WAIT TIME row
            _buildTappableRow(
              title: "WAIT TIME",
              subtitle: "40 minutes",
              onTap: () => debugPrint("Wait time tapped"),
            ),
            const Divider(height: 1),

            // PRINTER ADDRESS row (with two lines for the subtitle)
            _buildTappableRow(
              title: "PRINTER ADDRESS",
              subtitle: "Free\nStandard | 3-4 days",
              onTap: () => debugPrint("Printer address tapped"),
              isTwoLineSubtitle: true,
            ),
            const Divider(height: 1),

            // PAYMENT row
            _buildTappableRow(
              title: "PAYMENT",
              subtitle: "Visa *1234",
              onTap: () => debugPrint("Payment tapped"),
            ),
            const Divider(height: 1),

            // PROMOS row
            _buildTappableRow(
              title: "PROMOS",
              subtitle: "Apply promo code",
              onTap: () => debugPrint("Promos tapped"),
            ),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // Items section
            _buildCartItem(
              icon: Icons.picture_as_pdf,
              itemDetails: "Brand\nPDF\n1 page\nQuantity: 01",
              price: "\$10.99",
            ),
            const SizedBox(height: 8),
            _buildCartItem(
              icon: Icons.description_outlined,
              itemDetails: "Brand\nWorld\n2 pages\nQuantity: 01",
              price: "\$8.99",
            ),

            const SizedBox(height: 16),
            // Subtotal
            _buildSummaryRow(label: "Subtotal (2)", value: "\$19.98"),
            // Shipping total
            _buildSummaryRow(label: "Shipping total", value: "\$0.00"),
            // Taxes
            _buildSummaryRow(label: "Taxes", value: "\$2.00"),
            const Divider(height: 24),
            // Total (bold)
            _buildSummaryRow(label: "Total", value: "\$21.98", isBold: true),

            const SizedBox(height: 24),
          ],
        ),
      ),

      // Bottom "Place order" button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onPlaceOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF34C759), // iOS green
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Place order",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a single row with title on the left, subtitle on the right,
  /// and a trailing chevron icon. For example:
  /// WAIT TIME      40 minutes   >
  ///
  /// If [isTwoLineSubtitle] is true, the subtitle is split into multiple lines.
  Widget _buildTappableRow({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isTwoLineSubtitle = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: isTwoLineSubtitle
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: isTwoLineSubtitle
                  ? Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subtitle,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  /// Builds a cart item row with an icon, multi-line details, and a trailing price.
  /// For example:
  /// [PDF ICON]  Brand
  ///            PDF
  ///            1 page
  ///            Quantity: 01                $10.99
  Widget _buildCartItem({
    required IconData icon,
    required String itemDetails,
    required String price,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon or image
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.red, size: 30),
        ),
        const SizedBox(width: 12),
        // Item details
        Expanded(
          child: Text(
            itemDetails,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        // Price
        Text(
          price,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  /// Builds a summary row for Subtotal, Taxes, etc.
  /// For example:
  /// Subtotal (2)             $19.98
  /// or
  /// Total                    $21.98
  Widget _buildSummaryRow({
    required String label,
    required String value,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
