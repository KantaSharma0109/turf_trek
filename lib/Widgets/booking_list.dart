import 'package:flutter/material.dart';

class BookingList extends StatefulWidget {
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingList();
}

class _BookingList extends State<BookingList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (
          BuildContext context,
          int index,
          ) {
        return ListTile(
          tileColor: Colors.red,
          title: Text('TurfName $index'),
          subtitle: Text('Date: 14-10-24'),
        );
      },
    );
  }
}
