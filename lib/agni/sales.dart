import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a delay for loading data
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  final List<bool> _expanded = [false, false, false, false];
  final List<Map<String, dynamic>> salesData = [
    {
      "enrollNo": "240829775000",
      "type": "Barbender",
      "name": "monishhhh test",
      "mobile": "6380129370",
      "address": "Chennai, TN, Choolaimedu, TN-600084",
      "creditPoints": 17.6,
      "status": "Active",
    },
    {
      "enrollNo": "240829942926",
      "type": "Mason",
      "name": "Siva bro",
      "mobile": "7401912345",
      "address": "bx, db, fb, dbd, xb-600094",
      "creditPoints": 0,
      "status": "Active",
    },
    {
      "enrollNo": "240903137834",
      "type": "Mason",
      "name": "vijayyyyy test",
      "mobile": "9342546151",
      "address": "9, Gill Nagar, Choolaimedu, Chennai, TN-600094",
      "creditPoints": 0,
      "status": "Inactive",
    },
    {
      "enrollNo": "221091157392",
      "type": "Mason",
      "name": "kausalya",
      "mobile": "9952080365",
      "address": "Not Provided",
      "creditPoints": 5.5,
      "status": "Active",
    },
  ];

  String searchQuery = "";
  bool isSearching = false;

  List<Map<String, dynamic>> get filteredSalesData {
    if (searchQuery.isEmpty) return salesData;
    return salesData
        .where((entry) => entry['enrollNo']
            .toString()
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: isSearching
                ? TextField(
                    decoration: const InputDecoration(
                      hintText: "Search by Enroll No.",
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
                    "SALES",
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
      body:  _isLoading
          ? _buildShimmerList()
          :ListView.builder(
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
                  title: Text(
                    'Enroll No: ${data['enrollNo']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    'Role: ${data['type']}',
                    style: const TextStyle(color: Colors.grey),
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
                            Icons.person, 'Name: ${data['name']}'),
                        _buildDetailRow(
                            Icons.phone, 'Mobile: ${data['mobile']}'),
                        _buildDetailRow(
                            Icons.location_on, 'Address: ${data['address']}'),
                        _buildDetailRow(Icons.star,
                            'Credit Points: ${data['creditPoints']}'),
                        _buildStatusRow(data['status'], index),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildActionButton(
                                'Redeem',
                                const Color.fromARGB(255, 133, 232, 224),
                                onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RewardsScreen(),
                                  ),
                                );
                              },
                                ),
                            _buildActionButton(
                              'Gift Image',
                              const Color.fromARGB(255, 223, 143, 237),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const GiftImg(),
                                  ),
                                );
                              },
                            ),
                            _buildActionButton(
                                'Sales Order',
                                const Color.fromARGB(255, 234, 197, 145),
                               onPressed: () {
                               _showSalesOrderDialog(context, 800); // Pass stock quantity dynamically
                              },
                            ),
                          ],
                        ),
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

  Widget _buildStatusRow(String status, int index) {
    Color statusColor = status == 'Active' ? Colors.green : Colors.red;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: statusColor, size: 20),
              const SizedBox(width: 10),
              Text(
                'Status: $status',
                style: TextStyle(
                  fontSize: 14,
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onPressed: () {
              setState(() {
                salesData[index]['status'] =
                    salesData[index]['status'] == 'Active'
                        ? 'Inactive'
                        : 'Active';
              });
            },
            child: Text(
              status == 'Active' ? 'Inactivate' : 'Activate',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, {VoidCallback? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('_isLoading', _isLoading));
  }
}




class GiftImg extends StatefulWidget {
  const GiftImg({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GiftImgState createState() => _GiftImgState();
}

class _GiftImgState extends State<GiftImg> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a delay for loading data
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  // Initial image URLs, product names, and rewards
  List<Map<String, String>> products = [
    {
      'image': 'https://th.bing.com/th/id/OIP.I5QiBGQ7MBgUz90ouANdggHaE8?w=250&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
      'name': 'Gift 1',
      'reward': '10 points'
    },
    {
      'image': 'https://th.bing.com/th/id/OIP.ECw8mUGJR095oWpLnL2y2gHaHa?rs=1&pid=ImgDetMain',
      'name': 'Gift 2',
      'reward': '15 points'
    },
    {
      'image': 'https://th.bing.com/th/id/OIP.HWiLrbcmr4WezN_KBeWHSwHaHY?w=158&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
      'name': 'Gift 3',
      'reward': '20 points'
    },
    {
      'image': 'https://th.bing.com/th/id/OIP.wHibMeUGjNE6x10WcTwHTgHaHa?w=199&h=199&c=7&r=0&o=5&dpr=1.3&pid=1.7',
      'name': 'Gift 4',
      'reward': '25 points'
    },
  ];

  void addGift() {
    setState(() {
      products.add({
        'image': 'https://th.bing.com/th/id/OIP.SgA14RV1vHkpX5-jFzS9uQHaE8?w=250&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
        'name': 'New Gift',
        'reward': '30 points'  // New reward for the added gift
      });
    });
  }

  void deleteGift(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  void rewardGift(int index) {
    // Example of rewarding logic: increase points for the selected gift
    setState(() {
      // You could increase the reward by modifying the 'reward' field
      products[index]['reward'] = '${int.parse(products[index]['reward']!.split(' ')[0]) + 5} points';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gift Image',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.yellow,
      ),
      body:  _isLoading
          ? buildShimmerGrid()
          :Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7, 
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                
                rewardGift(index);
              },
              child: SingleChildScrollView(
               child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          products[index]['image']!,
                          width: double.infinity,
                          height: 120.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          products[index]['name']!,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        products[index]['reward']!,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                       IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            deleteGift(index);
                          },
                      
                      ),
                    ],
                  ),
                )
              ),

            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addGift,
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add),
      ),
    );
  }
}


void _showSalesOrderDialog(BuildContext context, int stockQuantity) {
  TextEditingController quantityController = TextEditingController();

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'SALES ORDER',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Stock Quantity: $stockQuantity',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.scale, color: Colors.black),
                    hintText: 'Enter Quantity In Kg',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); 
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Implement your submit logic here
                        Navigator.pop(context); 
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      );
    },
  );
}



class RewardsScreen extends StatefulWidget {

  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a delay for loading data
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  final List<Map<String, dynamic>> rewards = [
    {
      'name': 'Amazon Gift Card',
      'price': 100,
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Spotify Premium',
      'price': 200,
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Netflix Subscription',
      'price': 300,
      'image': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards',style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.yellow,
      ),
      body: _isLoading
          ? buildShimmerGrid()
          : Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            // ignore: deprecated_member_use
            color: Colors.yellow.withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Credit Points: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '150',  // Hardcoded value for UI only
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                final reward = rewards[index];
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            reward['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reward['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Price: ${reward['price']} points',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Redeem',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildShimmerGrid() {
  return GridView.builder(
    padding: const EdgeInsets.all(10),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, 
      mainAxisSpacing: 10, 
      crossAxisSpacing: 10, 
      childAspectRatio: 1, 
    ),
    itemCount: 4, 
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 12),
                // Placeholder for text
                SizedBox(
                  height: 20,
                  width: 100,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 20,
                  width: 150,
                ),
              ],
            ),
          ),
        ),
        ),
      );
    },
  );
}
