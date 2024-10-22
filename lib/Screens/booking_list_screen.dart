import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:turf_trek/model/constants.dart';

class BookingListScreen extends StatefulWidget {
  final String? customerId;
  final String? customerName;
  final String? mobileNum;
  const BookingListScreen({
    super.key,
    this.customerId,
    this.customerName,
    this.mobileNum,
  });

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  // String _customerName = 'N/A';
  // String _customerId = 'N/A';
  // String _mobileNum = 'N/A';
  List<dynamic> upcomingBookings = [];
  List<dynamic> pastBookings = [];
  int selectedList = 1;

  @override
  void initState() {
    super.initState();
    // _loadUserData();
    _fetchBookings();
  }

  // Future<void> _loadUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _customerName = prefs.getString('customer_name') ?? 'N/A';
  //     _customerId = prefs.getString('customer_id') ?? 'N/A';
  //     _mobileNum = prefs.getString('mobile_num') ?? 'N/A';
  //   });

  // await _fetchBookings();
  // }

  Future<void> _fetchBookings() async {
    try {
      final response = await http.post(
        Uri.parse('${BASE_URL}get_bookings.php'),
        body: {'customer_id': widget.customerId},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          upcomingBookings = data['upcoming_bookings'];
          pastBookings = data['past_bookings'];
        });
      } else {
        print('Failed to load bookings');
      }
    } catch (e) {
      print('Error fetching bookings: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            // Tabs for upcoming and all bookings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton('Upcoming', 1),
                _buildTabButton('All Bookings', 2),
              ],
            ),
            // Booking list
            Expanded(
              child: selectedList == 1 && upcomingBookings.isEmpty ||
                      selectedList == 2 && pastBookings.isEmpty
                  ? Center(
                      child: Text(
                        'Booking Not Available',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: selectedList == 1
                          ? upcomingBookings.length
                          : pastBookings.length,
                      itemBuilder: (BuildContext context, int index) {
                        var booking = selectedList == 1
                            ? upcomingBookings[index]
                            : pastBookings[index];

                        return Card(
                          color: Colors.yellow.shade50,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          elevation: 3,
                          shadowColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const TurfBookingDetails(),
                              //   ),
                              // );
                            },
                            contentPadding: const EdgeInsets.all(10.0),
                            horizontalTitleGap: 0.0,
                            leading: Icon(
                              Icons.calendar_month,
                              color: Colors.green.shade900,
                            ),
                            title: Text(
                              booking['turf_name'] ?? 'Turf Name',
                              style: TextStyle(
                                  fontFamily: 'FontTitle',
                                  color: Colors.green.shade900,
                                  fontSize: 25),
                            ),
                            // subtitle: Text(
                            //   'Date: ${booking['date']}\nTime: ${booking['from_time']} - ${booking['to_time']}',
                            //   style: const TextStyle(
                            //       color: Colors.green, fontFamily: 'FontExtra'),
                            // ),
                            subtitle: Text(
                              'Date: ${booking['date']}\n'
                              'Time: ${booking['from_time']} - ${booking['to_time']}\n'
                              'Court: ${booking['category']}\n'
                              'Price: ₹${booking['price']}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontFamily: 'FontExtra',
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

  Widget _buildTabButton(String text, int listType) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedList = listType;
        });
      },
      child: Column(
        children: [
          Text(
            text,
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
                color: selectedList == listType
                    ? Colors.green.shade900
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(3)),
          ),
        ],
      ),
    );
  }
}
