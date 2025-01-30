import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<Map<String, dynamic>> salesData = [
    {
      "orderId": "240829775000",
      "name": "monishhhh test",
      "mobile": "6380129370",
      "address": "Chennai, TN, Choolaimedu, TN-600084",
      "orderdate": "12/12/2024",
      "status": "Received",
      "Product":" ",
      "Quantity":"34kg"
    },
    {
      "orderId": "240829942926",
      "name": "Siva bro",
      "mobile": "7401912345",
      "address": "bx, db, dbd, xb-600094",
      "orderdate": "23/12/2024",
      "status": "Received",
      "Product":" ",
      "Quantity":"34kg"
    },
    {
      "orderId": "240903137834",
      "name": "vijayyyyy test",
      "mobile": "9342546151",
      "address": "9, Gill Nagar, Choolaimedu, Chennai, TN-600094",
      "orderdate": "1/12/2024",
      "status": "Pending",
      "Product":" ",
      "Quantity":"34kg"
    },
    {
      "orderId": "221091157392",
      "name": "kausalya",
      "mobile": "9952080365",
      "address": "Not Provided",
      "orderdate": "12/11/2024",
      "status": "Cancelled",
      "Product":" ",
      "Quantity":"34kg"
    },
  ];

  String searchQuery = "";
  bool isSearching = false;
  bool _isLoading = true;
  List<bool> _expanded = [];

  @override
  void initState() {
    super.initState();Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
    _expanded = List.generate(salesData.length, (_) => false);
  }

  List<Map<String, dynamic>> get filteredSalesData {
    if (searchQuery.isEmpty) return salesData;
    return salesData
        .where((entry) => entry['orderId']
            .toString()
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'received':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: isSearching
            ? TextField(
                decoration: const InputDecoration(
                  hintText: "Search by Order ID.",
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              )
            : const Text(
                "ORDER",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchQuery = "";
                }
              });
            },
          ),
        ],
      ),
      body: 
       _isLoading
          ? _buildShimmerList()
          :filteredSalesData.isEmpty
          ? Center(
              child: Text(
                'No orders found!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: filteredSalesData.length,
              itemBuilder: (context, index) {
                final data = filteredSalesData[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Column(
                          children: [Text(
                          'Order ID: ${data['orderId']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        _buildDetail(
                                Icons.shopping_cart_checkout_rounded, 'Product: ${data['product']}' ),
                             _buildDetail(Icons.scale_rounded, 'Quantity: ${data['Quantity']}'),],
                        ),
                        
                        subtitle:
                             Row(children: [
                              Icon(Icons.info, color: getStatusColor(data['status']), size: 20),
                            const SizedBox(width: 5),
                            Text(
                              'Status: ${data['status']}',
                              style: TextStyle(color: getStatusColor(data['status'])),
                            ),
                            ],
                            ),
                          
                        trailing: IconButton(
                          icon: Icon(
                            _expanded[index]
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.teal,
                          ),
                          onPressed: () {
                            setState(() {
                              _expanded[index] = !_expanded[index];
                            });
                          },
                        ),
                      ),
                      AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),
                        secondChild: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow(
                                  Icons.person, 'Customer Name: ${data['name']}'),
                              _buildDetailRow(
                                  Icons.phone, 'Mobile: ${data['mobile']}'),
                              _buildDetailRow(
                                  Icons.location_on, 'Address: ${data['address']}'),
                              _buildDetailRow(
                                  Icons.calendar_month_rounded, 'Order Date: ${data['orderdate']}'),
                            ],
                            
                          ),
                        ),
                        crossFadeState: _expanded[index]
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildDetailRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
 Widget _buildDetail(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 7, 7, 7), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 4, // Placeholder count
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Container(
                    height: 20,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  subtitle: Container(
                    height: 15,
                    width: 100,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
