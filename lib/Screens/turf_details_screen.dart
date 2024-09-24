import 'package:flutter/material.dart';
import 'package:turf_trek/Widgets/background_theme.dart';

class TurfBookingDetails extends StatefulWidget {
  const TurfBookingDetails({super.key});

  @override
  State<TurfBookingDetails> createState() => _TurfBookingDetailsState();
}

class _TurfBookingDetailsState extends State<TurfBookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BackGroundTheme(),
      child: Scaffold(
        backgroundColor: Colors.yellow.shade50.withOpacity(0.9),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Turf Name',
            style: TextStyle(
              color: Colors.green.shade900,
              fontSize: 35,
              fontFamily: 'FontTitle',
            ),
          ),
        ),
        body: Container(decoration: BoxDecoration(
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 20,
                      color: Colors.green.shade900,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Date: 14 - 6 - 2024',
                        style: TextStyle(
                          color: Colors.green.shade900,
                          fontFamily: 'FontText',
                          fontWeight: FontWeight.w800,fontSize: 20
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.white,
                  child: const Text('Turf Details')
                ),
                Row(
                  children: [
                    Icon(
                      Icons.pin_drop,
                      size: 20,
                      color: Colors.green.shade900,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Location: ',
                        style: TextStyle(
                            color: Colors.green.shade900,
                            fontFamily: 'FontText',
                            fontWeight: FontWeight.w800,fontSize: 20
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text('Address : It is a long established fact that It is a long established..'),
                ),
                Image.asset('assets/images/map.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
