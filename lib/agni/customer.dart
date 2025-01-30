import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shimmer/shimmer.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreen();
}


class _CustomerScreen extends State<CustomerScreen> {
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
                    "UNAPPROVED CLIENT",
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
     floatingActionButton: FloatingActionButton(onPressed:(){
      Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => const CustomerForm(),
      ),
      );
     },
     backgroundColor: Colors.yellow,
     child:  const Icon(Icons.add),),
  
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
}



class CustomerForm extends StatefulWidget {
  const CustomerForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomerFormState createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  String customerType = "New";
  String customerRole = "Mason";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Customer",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.yellow,
        centerTitle: true,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Choose Customer Type
            buildSectionTitle("Choose Customer Type"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: buildChoiceChip("New", customerType, (value) {
                      setState(() {
                        customerType = value!;
                      });
                    }),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: buildChoiceChip("Existing", customerType, (value) {
                      setState(() {
                        customerType = value!;
                      });
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (customerType == "New") ...[
              // Section: Choose Role
              buildSectionTitle("Choose Role"),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildChoiceChip("Mason", customerRole, (value) {
                    setState(() {
                      customerRole = value!;
                    });
                  }),
                  buildChoiceChip("Barbender", customerRole, (value) {
                    setState(() {
                      customerRole = value!;
                    });
                  }),
                  buildChoiceChip("Engineer", customerRole, (value) {
                    setState(() {
                      customerRole = value!;
                    });
                  }),
                ],
              ),
              const Divider(height: 30, thickness: 1, color: Colors.grey),
            ],

            if (customerType == "Existing") ...[
              // Section: Search by Customer ID
              buildSectionTitle("Find Customer"),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: buildTextField("Enter Customer ID", Icons.search),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle find button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "FIND",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 30, thickness: 1, color: Colors.grey),


              
            ],

            if (customerType == "New") ...[
              // Text fields for New Customers
              buildTextField("Name", Icons.person),
              buildTextField("Mobile Number", Icons.phone),
              buildTextField("Aadhaar Number", Icons.fingerprint),
              buildTextField("Door No.", Icons.home),
              buildTextField("Street Name", Icons.location_on),
              buildTextField("Area Name", Icons.map),
              buildTextField("City Name", Icons.location_city),
              buildTextField("State Name", Icons.public),
              buildTextField("Pincode", Icons.pin_drop),
              buildDatePicker("Choose Birthday"),
              buildDatePicker("Choose Anniversary"),
              buildTextField("Enter Referral Mobile Number", Icons.phone),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle form submission
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // ignore: deprecated_member_use
                    shadowColor: Colors.black.withOpacity(0.2),
                    elevation: 5,
                  ),
                  child: const Text(
                    "SUBMIT",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey[800],
      ),
    );
  }

  Widget buildChoiceChip(String label, String groupValue,
      ValueChanged<String?> onSelected) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: groupValue == label ? Colors.black : Colors.grey[600],
        ),
      ),
      selected: groupValue == label,
      selectedColor: Colors.yellow,
      backgroundColor: Colors.grey[300],
      onSelected: (isSelected) {
        if (isSelected) {
          onSelected(label);
        }
      },
    );
  }

   Widget buildTextField(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(icon, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87),
          ),
        ),
      ),
    );
  }



  Widget buildDatePicker(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(Icons.calendar_today, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87),
          ),
        ),
        onTap: () async {
          // ignore: unused_local_variable
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          // Handle pickedDate here if needed
        },
      ),
    );
  }
}