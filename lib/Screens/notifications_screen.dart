import 'package:flutter/material.dart';
import 'package:turf_trek/Widgets/background_theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BackGroundTheme(),
      child: Scaffold(
        backgroundColor: Colors.yellow.shade50.withOpacity(0.9),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Notifcations",
            style: TextStyle(
              color: Colors.green.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          backgroundColor: const Color(0xfffffdeb),
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              elevation: 2,
              shadowColor: Colors.green,
              //color: Colors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Adjust the radius as needed
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                horizontalTitleGap: 0.0,
                //visualDensity: VisualDensity(vertical: 4.0),
                leading: Icon(
                  Icons.notifications,
                  color: Colors.green.shade800,
                ),
                title: Text(
                  'Notification ${index + 1}',
                  style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
