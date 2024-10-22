import 'package:flutter/material.dart';

BoxDecoration BackGroundTheme() {
  return BoxDecoration(
    color: Colors.yellow.shade50,
    image: const DecorationImage(
      image: AssetImage(
        'assets/images/sports_booking.jpeg',
      ),
    ),
  );
}
