import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:turf_trek/Screens/turf_details_screen.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen(
      {super.key,
      required String customerId,
      required String customerName,
      required String mobileNum});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  int selectedList = 1;
  DateTime date = DateTime(2023, 12, 25);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return Scaffold(
      backgroundColor: Colors.yellow.shade50.withOpacity(0.9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'My Bookings',
          style: TextStyle(
              fontSize: 30,
              color: Colors.green.shade900,
              fontFamily: 'FontTitle'),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border(
            top: BorderSide(
              color: Colors.green.shade200,
              width: 2,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedList = 1;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        'Upcoming',
                        style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 1,
                          fontFamily: 'FontText',
                          fontWeight: FontWeight.w900,
                          color: Colors.green.shade900,
                        ),
                      ),
                      Container(
                        height: 6,
                        width: 100,
                        decoration: BoxDecoration(
                            color: selectedList == 1
                                ? Colors.green.shade900
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(3)),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedList = 2;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        'All Bookings',
                        style: TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                          fontFamily: 'FontText',
                          color: Colors.green.shade900,
                        ),
                      ),
                      Container(
                        height: 6,
                        width: 100,
                        decoration: BoxDecoration(
                            color: selectedList == 2
                                ? Colors.green.shade900
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(3)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: selectedList == 1 ? 4 : 5,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.yellow.shade50,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    elevation: 3,
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TurfBookingDetails(),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.all(10.0),
                      horizontalTitleGap: 0.0,
                      leading: Icon(
                        Icons.calendar_month,
                        color: Colors.green.shade900,
                      ),
                      title: Text(
                        'Turf Name ${index + 1}',
                        style: TextStyle(
                            fontFamily: 'FontTitle',
                            color: Colors.green.shade900,
                            fontSize: 25),
                      ),
                      subtitle: Text(
                        'Date: $formattedDate',
                        style: const TextStyle(
                            color: Colors.green, fontFamily: 'FontExtra'),
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
