import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:turf_trek/model/constants.dart';
import 'package:turf_trek/Widgets/background_theme.dart';

class PaymentScreen extends StatefulWidget {
  final String? turfId;
  final int? userId;
  final String? postImg;
  final String? turfName;
  final String? customerId;
  final String? customerName;
  final String? mobileNum;
  final DateTime selectedDate;
  final String? selectedCourt;
  final TimeOfDay fromTime;
  final TimeOfDay toTime;
  final String price;

  const PaymentScreen({
    super.key,
    this.turfId,
    this.userId,
    this.postImg,
    this.turfName,
    this.customerId,
    this.customerName,
    this.mobileNum,
    required this.selectedDate,
    this.selectedCourt,
    required this.fromTime,
    required this.toTime,
    required this.price,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BackGroundTheme(),
      child: Scaffold(
        backgroundColor: Colors.yellow.shade50.withOpacity(0.9),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          // iconTheme: IconThemeData(color: Colors.green.shade900),
          backgroundColor: Colors.transparent,
          title: Text(
            'Confirm',
            style: TextStyle(
              color: Colors.green.shade900,
              fontSize: 35,
              fontFamily: 'FontTitle',
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            border: Border(
              top: BorderSide(
                color: Colors.green.shade200,
                width: 2,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(35)),
                    // child: const CircleAvatar(
                    //   radius: 30,
                    //   backgroundImage:
                    //       AssetImage('assets/images/turf_image.jpeg'),
                    // ),

                    child: ClipOval(
                      child: Image.network(
                        '${IMG_URL}${widget.postImg}',
                        width: 55,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/offer1.jpeg',
                            fit: BoxFit.cover,
                          ); // Fallback image in case of error
                        },
                      ),
                    ),
                  ),
                  title: Text(
                    // 'Turf Name',
                    '${widget.turfName}',
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontFamily: 'FontTitle',
                      fontSize: 25,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 'Fri,14 Jun / Type-1',
                        DateFormat('EEE, d MMM / ${widget.selectedCourt}')
                            .format(widget.selectedDate),

                        style: const TextStyle(
                          color: Colors.blueGrey,
                        ),
                      ),
                      Text(
                        // '04:00 PM - 05:00 PM',
                        '${widget.fromTime.format(context)} - ${widget.toTime.format(context)}',

                        style: const TextStyle(
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18.0,
                    ),
                    child: Text(
                      'Payment',
                      style: TextStyle(
                        color: Colors.green.shade900,
                        fontFamily: 'FontTitle',
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Court Fee',
                      style: TextStyle(
                          color: Colors.green.shade900,
                          fontFamily: 'FontText',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      // '₹300.00',
                      'Price: ₹${widget.price}',
                      style: TextStyle(
                          color: Colors.green.shade900,
                          fontFamily: 'FontText',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 2,
                  color: Colors.green.shade300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Fee',
                      style: TextStyle(
                          color: Colors.green.shade900,
                          fontFamily: 'FontText',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      // '₹00.00',
                      'Price: ₹${widget.price}',
                      style: TextStyle(
                          color: Colors.green.shade900,
                          fontFamily: 'FontText',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 2,
                  color: Colors.green.shade300,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF326A1A),
                          Color(0xFF499B26),
                          Color(0xFF63D033),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {},
                    child: Text(
                      // 'Pay  ₹300.00',
                      'Price: ₹${widget.price}',
                      style: const TextStyle(
                          fontSize: 40,
                          fontFamily: 'FontText',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
