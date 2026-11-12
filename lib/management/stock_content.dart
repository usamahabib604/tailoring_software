import 'package:flutter/material.dart';

class StockContent extends StatelessWidget {
  const StockContent({super.key});

  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildToolbarButton(Icons.refresh, 'Refresh', darkGreenText),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.history, 'Stock history', Colors.grey.shade700),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.print, 'Print', Colors.grey.shade700),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.picture_as_pdf, 'Save as PDF', Colors.grey.shade700),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.table_chart, 'Excel', Colors.grey.shade700),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.assignment, 'Inventory count report', Colors.grey.shade700),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.bolt, 'Quick inventory', Colors.grey.shade700),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.help_outline, 'Help', Colors.grey.shade700),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Wrap(
              spacing: 20,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _buildCheckboxFilter('Negative quantity'),
                _buildCheckboxFilter('Non zero quantity'),
                _buildCheckboxFilter('Zero quantity'),
                _buildCheckboxFilter('Active products'),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCountBadge('0', Colors.red),
                    const SizedBox(width: 4),
                    _buildCountBadge('0', Colors.blue),
                    const SizedBox(width: 4),
                    _buildCountBadge('0', Colors.green),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: Row(
              children: [
                Container(
                  width: 240,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        color: parrotGreen.withOpacity(0.2),
                        child: Row(
                          children: [
                            Icon(Icons.folder, size: 16, color: darkGreenText),
                            const SizedBox(width: 8),
                            Text('Products', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: darkGreenText)),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(8),
                          children: const [],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                          ),
                          child: Row(
                            children: [
                              _buildSearchFilterIcon(Icons.star_outline),
                              const SizedBox(width: 8),
                              _buildSearchFilterIcon(Icons.view_headline),
                              const SizedBox(width: 8),
                              _buildSearchFilterIcon(Icons.tag),
                              const SizedBox(width: 8),
                              _buildSearchFilterIcon(Icons.local_offer),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  height: 28,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: const Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Product name',
                                            hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(bottom: 14),
                                          ),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Icon(Icons.search, size: 16, color: Colors.grey),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Text('Products count: 0', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                            ],
                          ),
                        ),

                        Container(
                          color: Colors.grey.shade100,
                          height: 35,
                          child: Row(
                            children: const [
                              SizedBox(width: 80, child: Padding(padding: EdgeInsets.only(left: 8), child: Text('Code', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)))),
                              Expanded(child: Text('Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                              SizedBox(width: 80, child: Text('Quantity', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                              SizedBox(width: 90, child: Text('Unit of...', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                              SizedBox(width: 90, child: Text('Cost p...', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                              SizedBox(width: 80, child: Text('Cost', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),

                        const Expanded(child: SizedBox()),

                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey.shade300)),
                            color: Colors.grey.shade50,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Cost price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text('Total cost: ', style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                                      const Text('0.00', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Total cost inc. tax: ', style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                                      const Text('0.00', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Sale price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text('Total: ', style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                                      const Text('0.00', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Total inc. tax: ', style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                                      const Text('0.00', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbarButton(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildCheckboxFilter(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: Checkbox(value: false, onChanged: (v) {}),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black87)),
      ],
    );
  }

  Widget _buildCountBadge(String count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(count, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSearchFilterIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(2),
        color: Colors.grey.shade50,
      ),
      child: Icon(icon, size: 16, color: Colors.grey.shade700),
    );
  }
}