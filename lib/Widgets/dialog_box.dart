import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_trek/Screens/signup_screen.dart';
import 'package:turf_trek/Widgets/logo_widget.dart';

class DialogBox extends StatelessWidget {
  final String text;
  final VoidCallback onLogout;
  final String customerId;
  final String customerName;
  final String mobileNum;

  const DialogBox({
    super.key,
    required this.text,
    required this.onLogout,
    required this.customerId,
    required this.customerName,
    required this.mobileNum,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.yellow.shade50,
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border(
            top: BorderSide(
              color: Colors.green.shade100,
              width: 3,
            ),
            bottom: BorderSide(
              color: Colors.green.shade100,
              width: 3,
            ),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LogoSign(),
            const Text(
              "Come back Soon !",
              style: TextStyle(
                color: Colors.green,
                fontSize: 30,
              ),
            ),
            const Text(
              textAlign: TextAlign.center,
              'Are you sure you want to logout ?',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 40,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF326A1A),
                          Color(0xFF568C3F),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric()),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontFamily: 'FontText', fontSize: 30),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 40,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF326A1A),
                          Color(0xFF568C3F),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () async {
                      // Close the dialog first
                      Navigator.of(context).pop();

                      // Clear user data
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('is_logged_in');

                      // Navigate to SignUpPage
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontFamily: 'FontText', fontSize: 25),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
