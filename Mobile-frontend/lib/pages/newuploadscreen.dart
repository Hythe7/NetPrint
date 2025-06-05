import 'package:flutter/material.dart';
import 'package:printhub/pages/profilescreen.dart';

import 'cheeckoutscreen.dart';

///
/// Main screen with TabBar: "New Upload" & "Recent"
///  - The selected tab is a rounded black pill with white text
///
class MergedTabScreen extends StatefulWidget {
  const MergedTabScreen({Key? key}) : super(key: key);

  @override
  State<MergedTabScreen> createState() => _MergedTabScreenState();
}

class _MergedTabScreenState extends State<MergedTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 2 tabs: New Upload, Recent
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // A TabBar with a custom "rounded black" indicator for the selected tab
    return Scaffold(
      appBar: AppBar(
        title: const Text('Printhub'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Tab bar at the top
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 12),
              child: TabBar(
                tabAlignment: TabAlignment.center,
                controller: _tabController,
                dividerColor: Colors.transparent,
                labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true, // let tabs size to content
                labelColor: Colors.white, // selected tab text color
                unselectedLabelColor: Colors.black, // unselected tab text color
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                indicator: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                indicatorColor: Colors.transparent,
                tabs: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Tab(text: "New Upload"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Tab(text: "Recent"),
                  ),
                ],
              ),
            ),

            // Tab views for "New Upload" and "Recent"
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  NewUploadTab(),
                  RecentTab(),
                ],
              ),
            ),
          ],
        ),
      ),

      // Custom bottom bar with 2 icons
      bottomNavigationBar: const CustomBottomBar(selectedIndex: 0),
    );
  }
}

///
/// TAB 1: New Upload
/// - Dashed PDF box
/// - "No. of copies" in one row with plus/minus stepper
/// - A single row of 4 dropdowns (Color mode, Page range, Paper size, Orientation)
/// - Green "proceed to checkout" button
/// - "Choose your printer" dropdown
///
class NewUploadTab extends StatefulWidget {
  const NewUploadTab({Key? key}) : super(key: key);

  @override
  State<NewUploadTab> createState() => _NewUploadTabState();
}

class _NewUploadTabState extends State<NewUploadTab> {
  int _copies = 1;
  String _colorMode = 'CMYK';
  String _pageRange = 'All pages';
  String _paperSize = 'A4';
  String _orientation = 'Portrait';
  String _selectedPrinter = 'Yfy korpus g';

  void _incrementCopies() {
    setState(() => _copies++);
  }

  void _decrementCopies() {
    if (_copies > 1) {
      setState(() => _copies--);
    }
  }

  void _onCheckout() {
    // Example action
    debugPrint(
        'Proceed to checkout: copies=$_copies, color=$_colorMode, pages=$_pageRange, size=$_paperSize, orientation=$_orientation, printer=$_selectedPrinter');
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const CheckoutScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PDF dashed box
          SizedBox(height: 24),
          Center(
            child: Container(
              width: 200,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomPaint(
                painter: DashedBorderPainter(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // PDF icon
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.red,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'PDF',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Row: "No. of copies" + stepper
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: const Text(
                  'No. of copies',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                        child:
                            _buildIconButton(Icons.remove, _decrementCopies)),
                    Expanded(
                      child: Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Text(
                          '$_copies',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                        child: _buildIconButton(Icons.add, _incrementCopies)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Row of 4 dropdowns: Color mode, Page range, Paper size, Orientation
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                // Color mode
                _buildDropdownColumn(
                  label: 'Color mode',
                  value: _colorMode,
                  items: const ['CMYK', 'RGB', 'Black & White'],
                  onChanged: (val) {
                    setState(() => _colorMode = val!);
                  },
                ),
                const SizedBox(width: 12),

                // Page range
                _buildDropdownColumn(
                  label: 'Page range',
                  value: _pageRange,
                  items: const ['All pages', 'Custom range'],
                  onChanged: (val) {
                    setState(() => _pageRange = val!);
                  },
                ),
                const SizedBox(width: 12),

                // Paper size
                _buildDropdownColumn(
                  label: 'Paper size',
                  value: _paperSize,
                  items: const ['A4', 'A3', 'Letter'],
                  onChanged: (val) {
                    setState(() => _paperSize = val!);
                  },
                ),
                const SizedBox(width: 12),

                // Orientation
                _buildDropdownColumn(
                  label: 'Orientation',
                  value: _orientation,
                  items: const ['Portrait', 'Landscape'],
                  onChanged: (val) {
                    setState(() => _orientation = val!);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Green button: proceed to checkout
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF34C759), // iOS-style green
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'proceed to checkout',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Choose your printer
          Text(
            'Choose your printer',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: _selectedPrinter,
              items: const [
                DropdownMenuItem(
                  value: 'Yfy korpus g',
                  child: Text('Yfy korpus g'),
                ),
                DropdownMenuItem(
                  value: 'Printer A',
                  child: Text('Printer A'),
                ),
                DropdownMenuItem(
                  value: 'Printer B',
                  child: Text('Printer B'),
                ),
              ],
              onChanged: (val) {
                setState(() => _selectedPrinter = val!);
              },
              isExpanded: true,
              underline: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the plus/minus buttons for the stepper
  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }

  /// Builds a column with label + dropdown
  Widget _buildDropdownColumn({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Text(label,
                style: const TextStyle(fontSize: 16, color: Colors.black))),
        const SizedBox(height: 8),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: value,
              items: items
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: onChanged,
              isExpanded: true,
              underline: const SizedBox(),
            ),
          ),
        ),
      ],
    );
  }
}

///
/// TAB 2: Recent
/// - File list with name, time, size/status
/// - "View all uploads" link
/// - Black "Next" button
///
class RecentTab extends StatelessWidget {
  const RecentTab({Key? key}) : super(key: key);

  void _onNext() {
    debugPrint('Next tapped');
  }

  void _onViewAllUploads() {
    debugPrint('View all uploads tapped');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // File list
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildFileItem(
                icon: Icons.picture_as_pdf,
                fileName: 'user-journey-01.pdf',
                time: '3m ago',
                sizeOrStatus: '604KB',
              ),
              _buildFileItem(
                icon: Icons.folder_outlined,
                fileName: 'Stock Photos',
                time: '5m ago',
                sizeOrStatus: '2,200B',
              ),
              _buildFileItem(
                icon: Icons.folder_outlined,
                fileName: 'Optimised Photos',
                time: '10m ago',
                sizeOrStatus: '1.3MB',
              ),
              _buildFileItem(
                icon: Icons.description_outlined,
                fileName: 'Strategy-Pitch-Final.pptx',
                time: 'Just now',
                sizeOrStatus: 'Error',
                isError: true,
              ),
              _buildFileItem(
                icon: Icons.image_outlined,
                fileName: 'man-holding-mobile-phone-white.png',
                time: '15m ago',
                sizeOrStatus: '2.4MB',
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _onViewAllUploads,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'View all uploads',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),

        // Bottom "Next" button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileItem({
    required IconData icon,
    required String fileName,
    required String time,
    required String sizeOrStatus,
    bool isError = false,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Icon(
        icon,
        size: 28,
        color: Colors.grey.shade700,
      ),
      title: Text(
        fileName,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        time,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
      ),
      trailing: Text(
        sizeOrStatus,
        style: TextStyle(
          color: isError ? Colors.red : Colors.grey.shade800,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

///
/// A custom bottom bar with 2 icons: home & profile (no labels)
///
class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  const CustomBottomBar({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                debugPrint('Home tapped');
              },
              icon: Icon(
                Icons.home_filled,
                color: selectedIndex == 0 ? Colors.black : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ProfileScreen()));
              },
              icon: Icon(
                Icons.person,
                color: selectedIndex == 1 ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
/// A custom painter for a dashed border around the PDF icon container
///
class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dashWidth = 6.0;
    final dashSpace = 4.0;
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(12),
    );

    final path = Path()..addRRect(rrect);

    // Create dashed effect by drawing small segments along path
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final currentLength = distance + dashWidth;
        if (currentLength > metric.length) {
          break;
        }
        canvas.drawLine(
          metric.getTangentForOffset(distance)!.position,
          metric.getTangentForOffset(currentLength)!.position,
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) => false;
}
