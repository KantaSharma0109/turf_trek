// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert'; // For JSON decoding

// import 'package:dotted_border/dotted_border.dart';
// import 'package:turf_trek/Screens/payment_screen.dart';
// import 'package:turf_trek/Widgets/background_theme.dart';

// class TurfBookingScreen extends StatefulWidget {
//   final String? turfId;
//   final int? userId;
//   final String? postImg;
//   final String? turfName;
//   final String? customerId;
//   final String? customerName;
//   final String? mobileNum;

//   const TurfBookingScreen({
//     super.key,
//     this.turfId,
//     this.userId,
//     this.postImg,
//     this.turfName,
//     this.customerId,
//     this.customerName,
//     this.mobileNum,
//   });

//   @override
//   State<TurfBookingScreen> createState() => _TurfBookingScreenState();
// }

// class _TurfBookingScreenState extends State<TurfBookingScreen> {
//   String? _selectedCourt1;
//   String? _selectedCourt2;
//   String? _allselectedCourt;
//   bool _isAllSelected = false;

//   List<String> _1courtSelected = [];
//   List<String> _2courtSelected = [];
//   List<String> _allcourtSelected = [];
//   bool _showContinueButton = false;

//   // List<bool> _buttonPressed = List.filled(15, false);
//   List<bool> _buttonPressed = List.generate(24, (_) => false);
//   int _selectedDateIndex = 0;

//   // void _onAvailableButtonPressed(int index) {
//   //   setState(() {
//   //     _buttonPressed[index] = !_buttonPressed[index];
//   //     _showContinueButton = _buttonPressed.contains(true);
//   //   });
//   // }

//   void _onAvailableButtonPressed(int index) {
//     setState(() {
//       _buttonPressed[index] = !_buttonPressed[index];
//       _showContinueButton = _buttonPressed.contains(true);
//     });
//   }

//   List<String> _getSelectedTimeSlots() {
//     final selectedSlots = <String>[];

//     for (int i = 0; i < _buttonPressed.length; i++) {
//       if (_buttonPressed[i]) {
//         selectedSlots.add(_formatTime(i));
//       }
//     }

//     return selectedSlots;
//   }

//   void _selectDate(int index) {
//     setState(() {
//       _selectedDateIndex = index; // Update the selected date
//     });
//   }

//   void _allCourtSelected() {
//     setState(() {
//       _isAllSelected = !_isAllSelected;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchCategories();
//   }

//   Future<void> _fetchCategories() async {
//     final response = await http.get(Uri.parse(
//         'http://192.168.29.202:8080/admin/api/court_list.php?turf_id=${widget.turfId}'));

//     if (response.statusCode == 200) {
//       final List<dynamic> categories = json.decode(response.body);

//       setState(() {
//         _1courtSelected = categories
//             .where((item) => !item.contains('+'))
//             .toList()
//             .cast<String>();

//         _2courtSelected = categories
//             .where((item) =>
//                 item.split('+').length ==
//                 2) // This checks if there is exactly one '+'
//             .toList()
//             .cast<String>();

//         final List<String> moreThanTwoPlus = categories
//             .where((item) => item.split('+').length > 2) // More than one '+'
//             .toList()
//             .cast<String>();

//         // Combine all categories
//         _allcourtSelected = [
//           ..._1courtSelected,
//           ..._2courtSelected,
//           ...moreThanTwoPlus
//         ];
//       });
//     } else {
//       // Handle error
//       print('Failed to load categories');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BackGroundTheme(),
//       child: Scaffold(
//         backgroundColor: Colors.yellow.shade50.withOpacity(0.9),
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           automaticallyImplyLeading: false,
//           title: Text(
//             // 'Turf Name',
//             '${widget.turfName}',
//             // 'Turf ID: ${widget.turfId ?? 'N/A'}',
//             style: TextStyle(
//                 color: Colors.green.shade900,
//                 fontSize: 30,
//                 fontFamily: 'FontTitle'),
//           ),
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               topRight: Radius.circular(
//                 20,
//               ),
//               topLeft: Radius.circular(
//                 20,
//               ),
//             ),
//             border: Border(
//               top: BorderSide(
//                 width: 2,
//                 color: Colors.grey.shade400,
//               ),
//             ),
//           ),
//           child: Padding(
//             // padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             // child: Column(
//             //   crossAxisAlignment: CrossAxisAlignment.stretch,
//             //   children: [
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: Column(
//                 //     crossAxisAlignment: CrossAxisAlignment.start,
//                 //     children: [
//                 //       Text('User ID: ${widget.userId}',
//                 //           style: TextStyle(fontSize: 16)),
//                 //       Text('Turf ID: ${widget.turfId}',
//                 //           style: TextStyle(fontSize: 16)),
//                 //       Text('Truf Name: ${widget.turfName}',
//                 //           style: TextStyle(fontSize: 16)),
//                 //     ],
//                 //   ),
//                 // ),
//                 SizedBox(
//                   height: 80,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 365, // Show up to one year of dates
//                     itemBuilder: (BuildContext context, int index) {
//                       DateTime date = getDateByIndex(index);
//                       String weekday = DateFormat('EEE').format(date);
//                       String day = DateFormat('dd').format(date);
//                       String month = DateFormat('MMM').format(date);

//                       bool isSelected = index == _selectedDateIndex;

//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: isSelected
//                                 ? Colors.white // Selected date color
//                                 : Colors.green, // Unselected date color
//                             foregroundColor: isSelected
//                                 ? Colors.green.shade900 // Selected text color
//                                 : Colors.white, // Unselected text color
//                             elevation: isSelected ? 0 : 5,
//                             shadowColor:
//                                 isSelected ? Colors.transparent : Colors.green,
//                           ),
//                           onPressed: () {
//                             _selectDate(index); // Update selected date
//                           },
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(weekday),
//                               Text(day),
//                               Text(month),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     const Text(
//                       'Court :',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                     const SizedBox(width: 10), // Adjust spacing as needed
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             // Dropdown for 1 Court
//                             Container(
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: _selectedCourt1 == null
//                                     ? Colors.green
//                                     : Colors.white,
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                               padding: EdgeInsets.zero,
//                               child: DropdownButton<String>(
//                                 underline: const SizedBox.shrink(),
//                                 value: _selectedCourt1,
//                                 hint: const Text(
//                                   '1 Court',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 items: _1courtSelected.map((String item) {
//                                   return DropdownMenuItem<String>(
//                                     value: item,
//                                     child: Text(
//                                       item,
//                                       style: TextStyle(
//                                           color: Colors.green.shade900),
//                                     ),
//                                   );
//                                 }).toList(),
//                                 onChanged: (String? newValue) {
//                                   setState(() {
//                                     // When selecting 1 Court, deselect the others
//                                     _selectedCourt1 = newValue;
//                                     _selectedCourt2 = null;
//                                     _allselectedCourt = null;
//                                   });
//                                 },
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             // Dropdown for 2 Courts
//                             Container(
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: _selectedCourt2 == null
//                                     ? Colors.green
//                                     : Colors.white,
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                               padding: EdgeInsets.zero,
//                               child: DropdownButton<String>(
//                                 underline: const SizedBox.shrink(),
//                                 value: _selectedCourt2,
//                                 hint: const Text(
//                                   '2 Courts',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 items: _2courtSelected.map((String item) {
//                                   return DropdownMenuItem<String>(
//                                     value: item,
//                                     child: Text(
//                                       item,
//                                       style: TextStyle(
//                                           color: Colors.green.shade900),
//                                     ),
//                                   );
//                                 }).toList(),
//                                 onChanged: (String? newValue) {
//                                   setState(() {
//                                     // When selecting 2 Courts, deselect the others
//                                     _selectedCourt2 = newValue;
//                                     _selectedCourt1 = null;
//                                     _allselectedCourt = null;
//                                   });
//                                 },
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             // Dropdown for All Courts
//                             Container(
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: _allselectedCourt == null
//                                     ? Colors.green
//                                     : Colors.white,
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                               padding: EdgeInsets.zero,
//                               child: DropdownButton<String>(
//                                 underline: const SizedBox.shrink(),
//                                 value: _allselectedCourt,
//                                 hint: const Text(
//                                   'All Courts',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 items: _allcourtSelected.map((String item) {
//                                   return DropdownMenuItem<String>(
//                                     value: item,
//                                     child: Text(
//                                       item,
//                                       style: TextStyle(
//                                           color: Colors.green.shade900),
//                                     ),
//                                   );
//                                 }).toList(),
//                                 onChanged: (String? newValue) {
//                                   setState(() {
//                                     // When selecting All Courts, deselect the others
//                                     _allselectedCourt = newValue;
//                                     _selectedCourt1 = null;
//                                     _selectedCourt2 = null;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Divider(
//                   color: Colors.green.shade700,
//                   thickness: 2,
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: 24, // Set to 24 hours to cover the full day
//                     itemBuilder: (BuildContext context, int index) {
//                       return IntrinsicHeight(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 18.0),
//                           child: Row(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Convert index to time in 12-hour format
//                                   Text(
//                                     // _formatTime(
//                                     //     index), // Format time for 24 hours (AM/PM)
//                                     _displayTime(index),
//                                     style: TextStyle(fontSize: 16),
//                                   ),
//                                   // Determine the icon based on time
//                                   index >= 6 &&
//                                           index <= 18 // Include 18 for 6 PM
//                                       ? const Icon(
//                                           Icons.sunny,
//                                           color: Colors.orange,
//                                         )
//                                       : const Icon(
//                                           Icons.nights_stay,
//                                           color: Colors.black,
//                                         ),
//                                 ],
//                               ),

//                               VerticalDivider(
//                                 thickness: 1,
//                                 color: Colors.green.shade700,
//                               ),
//                               // Display availability/unavailability
//                               (index == 0 ||
//                                       index == 3 ||
//                                       index == 4 ||
//                                       index == 10)
//                                   ? Text(
//                                       'Unavailable',
//                                       style: TextStyle(
//                                         color: Colors.green.shade900,
//                                         fontSize: 20,
//                                         fontFamily: 'FontText',
//                                       ),
//                                     )
//                                   : DottedBorder(
//                                       strokeWidth: 2,
//                                       dashPattern: [6, 3],
//                                       color: _buttonPressed[index]
//                                           ? Colors.green.shade900
//                                           : Colors.green.shade200,
//                                       borderType: BorderType.RRect,
//                                       radius: const Radius.circular(20),
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 50,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           boxShadow: _buttonPressed[index]
//                                               ? [
//                                                   BoxShadow(
//                                                     color: Colors.grey
//                                                         .withOpacity(0.3),
//                                                     spreadRadius: 3,
//                                                     blurRadius: 0,
//                                                     offset: const Offset(0, 4),
//                                                   )
//                                                 ]
//                                               : [],
//                                           color: _buttonPressed[index]
//                                               ? Colors.green.shade900
//                                                   .withOpacity(0.2)
//                                               : Colors.transparent,
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                           border: const Border(),
//                                         ),
//                                         child: ElevatedButton(
//                                           onPressed: () {
//                                             _onAvailableButtonPressed(index);
//                                           },
//                                           style: ElevatedButton.styleFrom(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 0.0),
//                                             elevation: 0.0,
//                                             backgroundColor: Colors.transparent,
//                                             foregroundColor: Colors.transparent,
//                                           ),
//                                           child: Text(
//                                             'Available ₹300',
//                                             style: TextStyle(
//                                               fontSize: 20,
//                                               color: Colors.green.shade900,
//                                               fontFamily: 'FontText',
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Visibility(
//                   visible: _showContinueButton,
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 10),
//                       decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [
//                               Color(0xFF63D033),
//                               Color(0xFF499B26),
//                               Color(0xFF326A1A),
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomLeft,
//                           ),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PaymentScreen(
//                                 turfId: widget.turfId,
//                                 userId: widget.userId,
//                                 postImg: widget.postImg,
//                                 turfName: widget.turfName,
//                                 customerId: widget.customerId,
//                                 customerName: widget.customerName,
//                                 mobileNum: widget.mobileNum,
//                                 selectedDate:
//                                     getDateByIndex(_selectedDateIndex),
//                                 selectedCourt: _selectedCourt1 ??
//                                     _selectedCourt2 ??
//                                     _allselectedCourt,
//                                 // selectedTimeSlots: _buttonPressed,
//                                 selectedTimeSlots: _getSelectedTimeSlots(),
//                               ),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 112, vertical: 10),
//                           elevation: 0.0,
//                           backgroundColor: Colors.transparent,
//                         ),
//                         child: const Text(
//                           'Confirm',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: 'FontText',
//                               fontWeight: FontWeight.w800,
//                               letterSpacing: 0,
//                               fontSize: 30),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   String _displayTime(int index) {
//     final startHour = index;
//     final startAmPm = startHour >= 12 ? 'PM' : 'AM';
//     final formattedStartHour = startHour % 12 == 0 ? 12 : startHour % 12;

//     return '$formattedStartHour:00 $startAmPm';
//   }

//   String _formatTime(int index) {
//     final startHour = index;
//     final endHour = (index + 1) % 24; // Wrap around to 0 after 23

//     final startAmPm = startHour >= 12 ? 'PM' : 'AM';
//     final endAmPm = endHour >= 12 ? 'PM' : 'AM';

//     final formattedStartHour = startHour % 12 == 0 ? 12 : startHour % 12;
//     final formattedEndHour = endHour % 12 == 0 ? 12 : endHour % 12;

//     return '$formattedStartHour:00 $startAmPm - $formattedEndHour:00 $endAmPm';
//   }

//   DateTime getDateByIndex(int index) {
//     DateTime baseDate = DateTime.now();
//     return baseDate.add(Duration(days: index));
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding
import 'package:turf_trek/model/constants.dart';
import 'package:turf_trek/Screens/payment_screen.dart';
import 'package:turf_trek/Widgets/background_theme.dart';

class TurfBookingScreen extends StatefulWidget {
  final String? turfId;
  final int? userId;
  final String? postImg;
  final String? turfName;
  final String? customerId;
  final String? customerName;
  final String? mobileNum;

  const TurfBookingScreen({
    super.key,
    this.turfId,
    this.userId,
    this.postImg,
    this.turfName,
    this.customerId,
    this.customerName,
    this.mobileNum,
  });

  @override
  State<TurfBookingScreen> createState() => _TurfBookingScreenState();
}

class _TurfBookingScreenState extends State<TurfBookingScreen> {
  String? _selectedCourt1;
  String? _selectedCourt2;
  String? _allselectedCourt;
  bool _isAllSelected = false;

  List<String> _1courtSelected = [];
  List<String> _2courtSelected = [];
  List<String> _allcourtSelected = [];
  bool _showContinueButton = false;

  // List<bool> _buttonPressed = List.filled(15, false);
  List<bool> _buttonPressed = List.generate(24, (_) => false);
  int _selectedDateIndex = 0;
  TimeOfDay _fromTime = TimeOfDay.now();
  TimeOfDay _toTime = TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1);
  String? availabilityStatus; // Variable to store the availability status
  String? price; // Variable to store the price if available

  void _onAvailableButtonPressed(int index) {
    setState(() {
      _buttonPressed[index] = !_buttonPressed[index];
      _showContinueButton = _buttonPressed.contains(true);
    });
  }

  void _selectDate(int index) {
    setState(() {
      _selectedDateIndex = index; // Update the selected date
    });
  }

  void _allCourtSelected() {
    setState(() {
      _isAllSelected = !_isAllSelected;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final response = await http
        .get(Uri.parse('${BASE_URL}court_list.php?turf_id=${widget.turfId}'));

    if (response.statusCode == 200) {
      final List<dynamic> categories = json.decode(response.body);

      setState(() {
        _1courtSelected = categories
            .where((item) => !item.contains('+'))
            .toList()
            .cast<String>();

        _2courtSelected = categories
            .where((item) =>
                item.split('+').length ==
                2) // This checks if there is exactly one '+'
            .toList()
            .cast<String>();

        final List<String> moreThanTwoPlus = categories
            .where((item) => item.split('+').length > 2) // More than one '+'
            .toList()
            .cast<String>();

        // Combine all categories
        _allcourtSelected = [
          ..._1courtSelected,
          ..._2courtSelected,
          ...moreThanTwoPlus
        ];
      });
    } else {
      // Handle error
      print('Failed to load categories');
    }
  }

  void _selectTime(TimeOfDay initialTime, bool isFromTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null && picked != initialTime) {
      setState(() {
        if (isFromTime) {
          _fromTime = picked;
          // Set _toTime to one hour after _fromTime
          _toTime = TimeOfDay(
              hour: (_fromTime.hour + 1) % 24, minute: _fromTime.minute);
        } else {
          _toTime = picked;
        }
      });
    }
  }

  void _checkAvailability() async {
    // Validate input
    if (_selectedDateIndex == null ||
        _selectedCourt1 == null &&
            _selectedCourt2 == null &&
            _allselectedCourt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all options')),
      );
      return;
    }

    DateTime selectedDate = getDateByIndex(_selectedDateIndex);
    String date = DateFormat('yyyy-MM-dd').format(selectedDate);
    String fromTime24 = _formatTimeTo24Hour(_fromTime);
    String toTime24 = _formatTimeTo24Hour(_toTime);
    String selectedCourt =
        _selectedCourt1 ?? _selectedCourt2 ?? _allselectedCourt ?? '';

    // Prepare the URL
    final url = Uri.parse(

        // 'http://192.168.29.202:8080/admin/api/check_availability.php');
        '${BASE_URL}check_availability.php');

    // Create the request body
    final Map<String, String> body = {
      'turf_id': widget.turfId.toString(),
      'user_id': widget.userId.toString(),
      'date': date,
      'from_time': fromTime24,
      'to_time': toTime24,
      'court': selectedCourt,
    };

    print('Checking availability with URL: $url$body');

    // Make the POST request
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // if (data['status'] == 'unavailable') {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Unavailable, please choose other time')),
      //   );
      // } else if (data['status'] == 'available') {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Available! Price: ${data['price']}')),
      //   );
      // }

      setState(() {
        if (data['status'] == 'unavailable') {
          availabilityStatus = 'unavailable';
          price = null; // No price for unavailable status
        } else if (data['status'] == 'available') {
          availabilityStatus = 'available';
          price = data['price']; // Set the price if available
          _showContinueButton = true;
        }
      });

      //after you check the availability:
      if (availabilityStatus == 'available') {
        setState(() {
          _showContinueButton = true; // Show button if available
        });
      } else {
        setState(() {
          _showContinueButton = false; // Hide button if unavailable
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to check availability')),
      );
    }
  }

  String _formatTimeTo24Hour(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BackGroundTheme(),
      child: Scaffold(
        backgroundColor: Colors.yellow.shade50.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Text(
            // 'Turf Name',
            '${widget.turfName}',
            // 'Turf ID: ${widget.turfId ?? 'N/A'}',
            style: TextStyle(
                color: Colors.green.shade900,
                fontSize: 30,
                fontFamily: 'FontTitle'),
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
            // padding: const EdgeInsets.symmetric(horizontal: 8.0),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            //   children: [
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       // Text('User ID: ${widget.userId}',
                //       //     style: TextStyle(fontSize: 16)),
                //       // Text('Turf ID: ${widget.turfId}',
                //       //     style: TextStyle(fontSize: 16)),
                //       // Text('Truf Name: ${widget.turfName}',
                //       //     style: TextStyle(fontSize: 16)),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 365, // Show up to one year of dates
                    itemBuilder: (BuildContext context, int index) {
                      DateTime date = getDateByIndex(index);
                      String weekday = DateFormat('EEE').format(date);
                      String day = DateFormat('dd').format(date);
                      String month = DateFormat('MMM').format(date);

                      bool isSelected = index == _selectedDateIndex;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected
                                ? Colors.white // Selected date color
                                : Colors.green, // Unselected date color
                            foregroundColor: isSelected
                                ? Colors.green.shade900 // Selected text color
                                : Colors.white, // Unselected text color
                            elevation: isSelected ? 0 : 5,
                            shadowColor:
                                isSelected ? Colors.transparent : Colors.green,
                          ),
                          onPressed: () {
                            _selectDate(index); // Update selected date
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(weekday),
                              Text(day),
                              Text(month),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      'Court :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 10), // Adjust spacing as needed
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Dropdown for 1 Court
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: _selectedCourt1 == null
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.zero,
                              child: DropdownButton<String>(
                                underline: const SizedBox.shrink(),
                                value: _selectedCourt1,
                                hint: const Text(
                                  '1 Court',
                                  style: TextStyle(color: Colors.white),
                                ),
                                items: _1courtSelected.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          color: Colors.green.shade900),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    // When selecting 1 Court, deselect the others
                                    _selectedCourt1 = newValue;
                                    _selectedCourt2 = null;
                                    _allselectedCourt = null;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Dropdown for 2 Courts
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: _selectedCourt2 == null
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.zero,
                              child: DropdownButton<String>(
                                underline: const SizedBox.shrink(),
                                value: _selectedCourt2,
                                hint: const Text(
                                  '2 Courts',
                                  style: TextStyle(color: Colors.white),
                                ),
                                items: _2courtSelected.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          color: Colors.green.shade900),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    // When selecting 2 Courts, deselect the others
                                    _selectedCourt2 = newValue;
                                    _selectedCourt1 = null;
                                    _allselectedCourt = null;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Dropdown for All Courts
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: _allselectedCourt == null
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.zero,
                              child: DropdownButton<String>(
                                underline: const SizedBox.shrink(),
                                value: _allselectedCourt,
                                hint: const Text(
                                  'All Courts',
                                  style: TextStyle(color: Colors.white),
                                ),
                                items: _allcourtSelected.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          color: Colors.green.shade900),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    // When selecting All Courts, deselect the others
                                    _allselectedCourt = newValue;
                                    _selectedCourt1 = null;
                                    _selectedCourt2 = null;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.green.shade700,
                  thickness: 2,
                ),
                Center(
                  child: Text(
                    'Choose Time:',
                    style: TextStyle(
                        color: Colors.green.shade900,
                        fontSize: 30,
                        fontFamily: 'FontTitle'),
                  ),
                ),

                const SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'From:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _selectTime(_fromTime, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green, // Change the button color to green
                        ),
                        child: Text(_fromTime.format(context)),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'To:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _selectTime(_toTime, false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green, // Change the button color to green
                        ),
                        child: Text(_toTime.format(context)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // New Button Below Time Selection
                Center(
                  child: ElevatedButton(
                    onPressed: _checkAvailability,
                    // Define the action for this button

                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // Text color
                    ),
                    child: const Text(
                      'Check Avilablity',
                      // style: TextStyle(fontSize: 16),
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'FontText',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (availabilityStatus != null)
                  GestureDetector(
                    onTap: () {
                      _checkAvailability();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: availabilityStatus == 'available'
                            ? Colors.green
                            : Colors.red[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: availabilityStatus == 'available'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                availabilityStatus == 'available'
                                    ? 'Turf Available'
                                    : 'Turf Unavailable',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'FontText',
                                  fontWeight: FontWeight.w600,
                                  color: availabilityStatus == 'available'
                                      ? Colors.white
                                      : Colors.red,
                                ),
                              ),
                            ),
                            if (availabilityStatus == 'available')
                              Center(
                                child: Text(
                                  'Price: ₹${price}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'FontText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // Continue button at the bottom of the screen
                if (_showContinueButton)
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        // width: double.infinity, // Full width of the screen
                        width: double.infinity, // Full width of the screen
                        height: 60, // Adjust height to match the design
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to PaymentScreen with required data
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                  // Pass the price or other necessary data
                                  turfId: widget.turfId,
                                  userId: widget.userId,
                                  postImg: widget.postImg,
                                  turfName: widget.turfName,
                                  customerId: widget.customerId,
                                  customerName: widget.customerName,
                                  mobileNum: widget.mobileNum,
                                  selectedDate:
                                      getDateByIndex(_selectedDateIndex),
                                  selectedCourt: _selectedCourt1 ??
                                      _selectedCourt2 ??
                                      _allselectedCourt,
                                  fromTime: _fromTime,
                                  toTime: _toTime,
                                  price: price!,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text(
                            'Continue To Pay',
                            // style: TextStyle(fontSize: 18),
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'FontText',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
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

DateTime getDateByIndex(int index) {
  DateTime baseDate = DateTime.now();
  return baseDate.add(Duration(days: index));
}
