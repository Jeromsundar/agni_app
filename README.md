Introduction

This Flutter application consists of a Splash Screen, Login Page with OTP Verification, and a Home Screen with various navigation options. The app allows users to log in using their phone number and OTP before accessing the main dashboard.

1. Splash Screen (SplashScreen)

File: splash_screen.dart

Purpose:

Displays a logo/image for 3 seconds before navigating to the LoginPage.

Acts as the entry point of the application.

Implementation Details:

Uses Future.delayed to automatically navigate to the LoginPage.

Navigation Issue Fix: To avoid use_build_context_synchronously errors, checks if the widget is still mounted before navigation.


2. Login Page (LoginPage)

File: login.dart

Purpose:

Handles user login via phone number and OTP.

Sends OTP when the user enters their phone number.

Allows the user to enter OTP and verify it before navigating to the Home screen.

Implementation Details:

Uses a GlobalKey<FormState> to validate phone number and OTP inputs.

Displays a "Send OTP" button initially, which changes to an OTP input field after clicking.

Navigation: Pushes the Home screen on successful OTP verification.


3. Home Screen (Home)

File: home.dart

Purpose:

Displays a dashboard with options for Orders, Sales, Projects, Vouchers, and Customers.

Provides navigation to different sections.

Implementation Details:

Uses MaterialApp to set the theme and default route.

Uses a Scaffold with an AppBar and a Column layout for main buttons.

Implements a logout dialog when clicking the logout button.

Navigation Options:

Orders → OrderScreen()

Sales Entry → SalesScreen()

Project → ComingSoonPage()

Voucher → RewardsPage()

Customers → CustomerScreen()

4. Logout Functionality

Displays a confirmation dialog before logging out.

On Logout: Redirects back to the LoginPage.
