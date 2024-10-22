import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:turf_trek/model/constants.dart';
import 'package:turf_trek/Widgets/background_theme.dart';
import 'package:http/http.dart' as http; // Import http package
import 'dart:convert'; // Import for JSON decoding
import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

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
  // bool _isChecked = false;
  bool _isQrCodeVisible = false;

  final ImagePicker _picker = ImagePicker();
  XFile? _receiptImage; // Variable to hold the selected receipt image
  String _enteredPrice = ""; // Variable to hold entered price

  // Future<void> _fetchAndSaveQrCode() async {
  //   // Replace with your API endpoint to get the QR code image name
  //   final response = await http.get(Uri.parse('${BASE_URL}fetch_qr.php'));

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final qrImageName =
  //         data['qr_img']; // Assuming your response has qr_img field

  //     // Construct the full URL of the image
  //     final qrImageUrl = '${IMG_URL}qr/$qrImageName';

  //     // Save the image to gallery
  //     final result = await ImageGallerySaver.saveImage(
  //       await http.readBytes(Uri.parse(qrImageUrl)), // Read the image bytes
  //     );

  //     // Check result and show a confirmation dialog
  //     if (result['isSuccess']) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('QR Code saved to gallery!')));
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Failed to save QR Code.')));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Failed to fetch QR Code.')));
  //   }
  // }
  Future<void> _fetchAndSaveQrCode() async {
    // Replace with your API endpoint to get the QR code image name
    final response = await http.post(
      Uri.parse('${BASE_URL}fetch_qr.php'),
      body: {
        'user_id': '${widget.userId}', // Pass userId
        'turf_id': '${widget.turfId}', // Pass turfId
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final qrImageName =
          data['qr_img']; // Assuming your response has qr_img field

      if (qrImageName != null) {
        // Construct the full URL of the image
        final qrImageUrl = '${IMG_URL}qr/$qrImageName';

        // Save the image to gallery
        final result = await ImageGallerySaver.saveImage(
          await http.readBytes(Uri.parse(qrImageUrl)), // Read the image bytes
        );

        // Check result and show a confirmation dialog
        if (result['isSuccess']) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('QR Code saved to gallery!')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to save QR Code.')));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('No QR code found.')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch QR Code.')));
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _receiptImage = pickedFile; // Set the selected image
      });
    }
  }

  // void _submitReceipt() {
  //   // Handle the receipt submission logic here
  //   if (_receiptImage != null && _enteredPrice.isNotEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Receipt submitted successfully!')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please fill in all fields.')),
  //     );
  //   }
  // }

  Future<void> _submitReceipt() async {
    if (_receiptImage != null && _enteredPrice.isNotEmpty) {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${BASE_URL}submit_booking.php'),
      );

      // Set the fields
      request.fields['userId'] = '${widget.userId}';
      request.fields['turfName'] = '${widget.turfName}';
      request.fields['turfId'] = '${widget.turfId}';
      request.fields['customerId'] = '${widget.customerId}';
      request.fields['date'] =
          DateFormat('yyyy-MM-dd').format(widget.selectedDate);
      request.fields['from_time'] = '${widget.fromTime.format(context)}';
      request.fields['to_time'] = '${widget.toTime.format(context)}';
      request.fields['category'] = '${widget.selectedCourt}';
      request.fields['price'] = _enteredPrice;

      // Debugging: Print all fields
      print("Fields: ${request.fields}");

      // Add file
      request.files.add(
        await http.MultipartFile.fromPath('receiptImage', _receiptImage!.path),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // Print response status and body for debugging
      print("Response Status: ${response.statusCode}");
      print("Response Body: $responseBody");

      //     if (response.statusCode == 200) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(content: Text('Receipt uploaded successfully')),
      //       );
      //     } else {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(content: Text('Failed to upload receipt')),
      //       );
      //     }
      //   } else {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Please fill in all fields.')),
      //     );
      //   }
      // }

      if (response.statusCode == 200) {
        // Show success dialog
        _showDialog('Success', 'Receipt uploaded successfully.');
        setState(() {
          _receiptImage = null; // Clear the image
          _enteredPrice = "";
        });
      } else {
        // Show error dialog
        _showDialog('Error', 'Failed to upload receipt.');
      }
    } else {
      _showDialog('Error', 'Please fill in all fields.');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Text(message),
        );
      },
    );
  }

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
        body: SingleChildScrollView(
          child: Container(
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
                    height: 60,
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
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () {
                        print('Customer ID: ${widget.customerId}');
                        print('Customer Name: ${widget.customerName}');
                        print('Mobile Number: ${widget.mobileNum}');

                        setState(() {
                          _isQrCodeVisible =
                              !_isQrCodeVisible; // Toggle visibility
                        });
                      },
                      child: Text(
                        'Pay: ₹${widget.price}',
                        style: const TextStyle(
                            fontSize: 40,
                            fontFamily: 'FontText',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  if (_isQrCodeVisible) // Show QR Code button conditionally
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, elevation: 0.0,
                            backgroundColor: Colors.green, // Set the text color
                          ),
                          onPressed: _fetchAndSaveQrCode,
                          child: const Text(
                            'Get QR Code for Payment',
                            style: TextStyle(
                              fontSize: 20, // Adjust the font size as needed
                              fontFamily: 'FontText',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_isQrCodeVisible) // Show QR Code button conditionally
                    Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Upload Receipt Image:',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'FontText',
                                color: Colors.green.shade900,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 100,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _receiptImage == null
                                ? const Center(
                                    child: Text(
                                    'Select Image',
                                    style: TextStyle(
                                      fontSize:
                                          20, // Adjust the font size as needed
                                      fontFamily: 'FontText',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ))
                                : Image.file(
                                    File(_receiptImage!.path),
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 250, // Set a fixed width for the TextField
                          height: 50, // Optionally set a fixed height
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Enter Price',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0), // Adjust padding
                            ),
                            onChanged: (value) {
                              setState(() {
                                _enteredPrice = value; // Store entered price
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, elevation: 0.0,
                            backgroundColor: Colors.green, // Set the text color
                          ),
                          onPressed: _submitReceipt,
                          // _submitBooking,
                          child: const Text(
                            'Submit Receipt',
                            style: TextStyle(
                              fontSize: 20, // Adjust the font size as needed
                              fontFamily: 'FontText',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
