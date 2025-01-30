import 'package:flutter/material.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  final bool _isHovered = false;
  int selectedPoints = 10;

  final List<Map<String, dynamic>> rewards = [
    {
      'points': '10',
      'tons': '1.25',
      'items': [
        {'name': 'Thermosteel Vacuum Flask', 'icon': Icons.thermostat_outlined},
        {'name': 'Murugan steel 7-10 size flat', 'icon': Icons.kitchen},
      ],
    },
    {
      'points': '20',
      'tons': '2.5',
      'items': [
        {'name': 'Murugan evasliva model', 'icon': Icons.aod},
        {'name': 'Murugan curve tall milk boiler', 'icon': Icons.kitchen},
      ],
    },
    {
      'points': '30',
      'tons': '3.75',
      'items': [
        {'name': 'Premium EVO series Copper', 'icon': Icons.hardware},
        {'name': 'Bajaj Popular Iron Box', 'icon': Icons.iron},
        {'name': 'Onix Stainless Steel Hot Pot 5', 'icon': Icons.local_fire_department},
      ],
    },
    {
      'points': '40',
      'tons': '5.0',
      'items': [
        {'name': 'Premier stainless', 'icon': Icons.local_dining},
        {'name': 'Portronics Por-2076', 'icon': Icons.headphones},
        {'name': 'Premier Km4813 Hydra', 'icon': Icons.kitchen},
      ],
    },
    {
      'points': '50',
      'tons': '6.25',
      'items': [], // No items here
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'REWARDS',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            DropdownButton<int>(
              value: selectedPoints,
              onChanged: (newValue) {
                setState(() {
                  selectedPoints = newValue!;
                });
              },
              items: rewards
                  .map((reward) => DropdownMenuItem<int>(
                        value: int.parse(reward['points']),
                        child: Text('${reward['points']} points'),
                      ))
                  .toList(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  final category = rewards[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Reward points and tons section
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal:10,vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.stars, color: Colors.black),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Points: ${category['points']} - ( ${category['tons']} tons )',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 13),
                            // Grid of items inside this category
                            category['items'].isEmpty
                                ? Center(
                                    child: Text(
                                      'No items available',
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                                  )
                                : ExpansionTile(
                                    title: Text(
                                      'Items Available',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    children: [
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 14,
                                          crossAxisSpacing: 12,
                                          childAspectRatio: 0.8,
                                        ),
                                        itemCount: category['items'].length,
                                        itemBuilder: (context, itemIndex) {
                                          final item = category['items'][itemIndex];
                                          return GestureDetector(
                                            onTap: () {
                                              // Handle item click
                                            },
                                            child: AnimatedScale(
                                              scale: _isHovered ? 1.1 : 1.0,
                                              duration: Duration(milliseconds: 200),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow[100],
                                                  borderRadius: BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 4,
                                                      offset: Offset(2, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        item['icon'],
                                                        size: 35,
                                                        color: Colors.yellow[700],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        item['name'],
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}