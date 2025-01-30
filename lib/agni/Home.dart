import 'package:agni_app/agni/login.dart';
import 'package:agni_app/agni/order.dart';
import 'package:agni_app/agni/sales.dart';
import 'package:flutter/material.dart';
import 'voucher.dart';
import 'project.dart';
import 'customer.dart';


const Color primaryColor = Colors.yellow;
const Color secondaryColor = Colors.yellow;


const String defaultUserName = 'Guest User';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     
      theme: _appTheme(),
      home: SolidHomePage(userName: defaultUserName),
    );
  }

  ThemeData _appTheme() {
    return ThemeData(
      fontFamily: 'Roboto',
      primaryColor: primaryColor,
      hintColor: Colors.black,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
      ),
    );
  }
}

class SolidHomePage extends StatelessWidget {
  final String userName;

  const SolidHomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          _buildBody(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      // ignore: deprecated_member_use
      backgroundColor: primaryColor.withOpacity(0.8),
      elevation: 0,
      title: Text(
        "Jerom",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.black, 
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app, color: const Color.fromARGB(255, 0, 0, 0)), 
          onPressed: () {
            _showLogoutDialog(context);
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/img.png", height: 150, width: 200),
          _buildMainContent(context),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMainButton(Icons.shopping_cart, 'Orders', onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderScreen()));
            }),
            _buildMainButton(Icons.sell, 'Sale Entry', onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SalesScreen()));
            }),
          ],

        ),
        SizedBox(height: 20),
        Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
          _buildMainButton(Icons.work, 'Project', onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ComingSoonPage()));
            }),
          
                  _buildMainButton(Icons.card_giftcard, 'Voucher', onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RewardsPage()));
            }),
              ],
            ),
             SizedBox(height: 20),
            Center(child:
           _buildMainButton(Icons.people, 'Customers', onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerScreen()));
          }),
            ),
              
            
        
      ],
    );
  }

  Widget _buildMainButton(IconData icon, String title, {VoidCallback? onPressed}) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // ignore: deprecated_member_use
          backgroundColor: secondaryColor.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Logout',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(fontSize: 16)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout', style: TextStyle(fontSize: 16, color: Colors.red)),
              onPressed: () {
                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
              },
            ),
          ],
        );
      },
    );
  }
}
