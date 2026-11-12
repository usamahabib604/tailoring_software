import 'package:flutter/material.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8);

  String dateRangeText = '10/21/2026 - 10/21/2026';

  Future<void> _selectDateRange(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(
        start: DateTime(2026, 10, 21),
        end: DateTime(2026, 10, 21),
      ),
    );

    if (picked != null) {
      setState(() {
        dateRangeText = "${picked.start.month}/${picked.start.day}/${picked.start.year} - ${picked.end.month}/${picked.end.day}/${picked.end.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildPanel(
                    context: context,
                    title: 'Monthly Sales - 2026',
                    subtitle: 'Sales data grouped by month',
                    height: 200,
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(12, (index) => Text('0', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold))),
                        ),
                        const SizedBox(height: 5),
                        Container(height: 2, color: parrotGreen.withOpacity(0.5)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: _buildPanel(
                    context: context,
                    title: 'Total Sales',
                    height: 200,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('0', style: TextStyle(color: darkGreenText, fontSize: 42, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text('Top performing month:', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                        const Text('---', style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text('0.00', style: TextStyle(color: darkGreenText, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            InkWell(
              onTap: () => _selectDateRange(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Periodic Reports ( $dateRangeText )', style: TextStyle(color: darkGreenText, fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Icon(Icons.calendar_today, color: darkGreenText, size: 16),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 12),

            SizedBox(
              height: 180,
              child: Row(
                children: [
                  Expanded(child: _buildPanel(context: context, title: 'Top Products', centerText: 'No data to display')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildPanel(context: context, title: 'Hourly Sales', centerText: 'No data to display')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildPanel(
                    context: context,
                    title: 'Total Sales (Amount)',
                    content: Center(child: Text('0', style: TextStyle(color: darkGreenText, fontSize: 60, fontWeight: FontWeight.bold))),
                  )),
                ],
              ),
            ),
            
            const SizedBox(height: 16),

            SizedBox(
              height: 180,
              child: Row(
                children: [
                  Expanded(child: _buildPanel(context: context, title: 'Top Product Groups', centerText: 'No data to display')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildPanel(context: context, title: 'Top Customers', centerText: 'No data to display')),
                  const SizedBox(width: 16),
                  Expanded(child: Container()), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel({required BuildContext context, required String title, String? subtitle, double? height, String? centerText, Widget? content}) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade100, blurRadius: 4, offset: const Offset(0, 2))
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
              if (subtitle == null) 
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Refreshing $title...'), duration: const Duration(seconds: 1)),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.sync, color: Colors.grey, size: 16),
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(title),
                            content: const SizedBox(
                              height: 200,
                              width: 300,
                              child: Center(child: Text('Expanded view (No data)')),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.open_in_full, color: Colors.grey, size: 16),
                      ),
                    ),
                  ],
                )
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
          ],
          Expanded(
            child: content ?? Center(
              child: Text(centerText ?? '', style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}