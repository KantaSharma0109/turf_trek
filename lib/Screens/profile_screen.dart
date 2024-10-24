import 'package:flutter/material.dart';
import 'package:turf_trek/Screens/signup_screen.dart';
import 'package:turf_trek/Widgets/background_theme.dart';

import 'package:turf_trek/Widgets/dialog_box.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile_edit_screen.dart';

class UserProfile extends StatefulWidget {
  final String customerId;
  final String customerName;
  final String mobileNum;
  const UserProfile({
    super.key,
    required this.customerId,
    required this.customerName,
    required this.mobileNum,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BackGroundTheme(),
      child: Scaffold(
        backgroundColor: Colors.yellow.shade50.withOpacity(0.9),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          //bottomOpacity: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Profile',
            style: TextStyle(
              color: Colors.green.shade900,
              fontFamily: 'FontText',
              fontSize: 25,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(
                20,
              ),
              topLeft: Radius.circular(
                20,
              ),
            ),
            border: Border(
              top: BorderSide(
                width: 2,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.all(10),
                  tileColor: const Color(0xFF225A0A),
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      'assets/images/user.png',
                    ),
                  ),
                  title: Text(
                    widget.customerName, // Display customer's name
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'FontText',
                    ),
                  ),
                  subtitle: Wrap(
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        '${widget.mobileNum}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      print("Navigating to EditProfile");
                      print("Customer ID: ${widget.customerId}");
                      print("Customer Name: ${widget.customerName}");
                      print("Mobile Num: ${widget.mobileNum}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(
                            customerId: widget.customerId,
                            customerName: widget.customerName,
                            mobileNum: widget.mobileNum,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade50.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CustomListTile(
                        title: 'Help & Support',
                        subtitle: 'Connect to Turf Trek',
                        leadingIcon: Icons.question_mark_rounded,
                        onTap: () => _showModalBottomSheet(context),
                      ),
                      const SizedBox(height: 20),
                      // CustomListTile(
                      //   title: 'Rate Us',
                      //   subtitle: 'Rate the Turf Trek App',
                      //   leadingIcon: Icons.star_rounded,
                      //   onTap: () => _showModalBottomSheet(context),
                      // ),
                      CustomListTile(
                        title: 'Rate Us',
                        subtitle: 'Rate the Turf Trek App',
                        leadingIcon: Icons.star_rounded,
                        onTap: () => _rateUs(), // Use the method for Rate Us
                      ),
                      const SizedBox(height: 20),
                      CustomListTile(
                        title: 'Logout',
                        subtitle: '',
                        leadingIcon: Icons.logout_rounded,
                        onTap: () => _showCustomDialog(context, 'logout'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _rateUs() async {
    const String url =
        'https://play.google.com/store/apps/details?id=com.yourapp'; // Replace with your app's link
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // Show an AlertDialog if the link cannot be opened
      _showAlertDialog(context);
    }
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Link Unavailable'),
          content: const Text('Currently, the link is not available.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCustomDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBox(
          text: text,
          customerId: widget.customerId,
          customerName: widget.customerName,
          mobileNum: widget.mobileNum,
          onLogout: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpPage(),
              ),
            );
          },
        );
      },
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: Color(0XFFFFFDEB),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'Need Help!',
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'FontTitle',
                      color: Colors.green.shade900,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'For any queries or concerns, chat with the Turf Trek App Support team.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF326A1A),
                        Color(0xFF499B26),
                        Color(0xFF63D033),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      _openWhatsAppChat();
                    },
                    child: const Text('Chat us on WhatsApp'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openWhatsAppChat() async {
    const String phoneNumber = '917597363636'; // Use the correct format
    const String url = 'https://wa.me/$phoneNumber';

    try {
      // Check if the URL can be launched
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
        print("WhatsApp URL: $url"); // Log the URL for debugging
      } else {
        _showAlertDialog(context);
      }
    } catch (e) {
      // Catch any exceptions and show alert dialog
      _showAlertDialog(
        context,
      );
    }
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final VoidCallback onTap;

  CustomListTile({
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
          border: Border(
              bottom: BorderSide(
            color: Color(0xFF326A1A),
            width: 3,
          ))),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          radius: 12.0,
          backgroundColor: Colors.green.shade900,
          child: Icon(
            leadingIcon,
            color: Colors.yellow.shade50,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.green.shade900,
            fontFamily: 'FontText',
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.green, fontFamily: 'FontExtra'),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.green.shade900,
          size: 20,
        ),
      ),
    );
  }
}
