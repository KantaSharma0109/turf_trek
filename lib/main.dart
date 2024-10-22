import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:turf_trek/Screens/signup_screen.dart';
import 'package:turf_trek/Widgets/navigate_tabs.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_trek/model/shared_prefs_helper.dart';
import 'package:turf_trek/Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

Future<bool> _checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('is_logged_in') ?? false;
}

Future<Map<String, String>> _getStoredUserData() async {
  return await SharedPrefsHelper().getUserData();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turf Trek',
      theme: ThemeData(
        primaryColor: Colors.green.shade900,
        useMaterial3: false,
      ),
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.hasData && snapshot.data!) {
            // If logged in, get user data
            return FutureBuilder<Map<String, String>>(
              future: _getStoredUserData(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                } else if (userSnapshot.hasData) {
                  final userData = userSnapshot.data!;
                  return NavigateTabs(
                    customerId: userData['customerId']!,
                    customerName: userData['customerName']!,
                    mobileNum: userData['mobileNum']!,
                  );
                } else {
                  return const SignUpPage();
                }
              },
            );
          } else {
            return const SignUpPage();
          }
        },
      ),
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Turf Trek',
//       theme: ThemeData(
//         primaryColor: Colors.green.shade900,
//         useMaterial3: false,
//       ),
//       home: FutureBuilder<bool>(
//         future: _checkLoginStatus(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return SplashScreen();
//           } else if (snapshot.hasData && snapshot.data!) {
//             return NavigateTabs(
//               customerId: '',
//               customerName: '',
//               mobileNum: '',
//             ); // or any initial screen after login
//           } else {
//             return SignUpPage(); // login screen if not logged in
//           }
//         },
//       ),
//     );
//   }

//   Future<bool> _checkLoginStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
//     return isLoggedIn;
//   }
// }
