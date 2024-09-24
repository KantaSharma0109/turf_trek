// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';

// import 'package:turf_trek/Widgets/background_theme.dart';

// class EditProfile extends StatefulWidget {
//   final String? customerId;
//   final String? customerName;
//   final String? mobileNum;
//   const EditProfile({
//     super.key,
//     this.customerId,
//     this.customerName,
//     this.mobileNum,
//   });

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   final _formKey = GlobalKey<FormState>();
//   final List<TextEditingController> _controllers =
//       List.generate(4, (index) => TextEditingController());
//   final List<String> _labels = ['Name', 'Email', 'Mobile', 'Password'];
//   final List<TextInputType> _inputTypes = [
//     TextInputType.text,
//     TextInputType.emailAddress,
//     TextInputType.phone,
//     TextInputType.text
//   ];
//   final List<IconData> _icons = [
//     Icons.person,
//     Icons.email,
//     Icons.phone,
//     Icons.lock
//   ];
//   @override
//   void initState() {
//     super.initState();
//     // Set initial values for name and mobile number
//     _controllers[0].text = widget.customerName ?? ''; // Name
//     _controllers[2].text = widget.mobileNum ?? ''; // Mobile
//   }

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       // Process data
//       final name = _controllers[0].text;
//       final email = _controllers[1].text;
//       final mobile = _controllers[2].text;
//       final password = _controllers[3].text;
//       Navigator.pop(context);
//     }
//   }

//   String? _validateInput(int index, String value) {
//     switch (index) {
//       case 0:
//         if (value.isEmpty) return 'Please enter your name';
//         break;
//       case 1:
//         if (value.isEmpty) return 'Please enter your email';
//         //if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Please enter a valid email address';
//         break;
//       case 2:
//         if (value.isEmpty) return 'Please enter your mobile number';
//         //if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) return 'Please enter a valid 10-digit mobile number';
//         break;
//       case 3:
//         if (value.isEmpty) return 'Please enter a password';
//         //if (value.length < 6) return 'Password must be at least 6 characters long';
//         break;
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BackGroundTheme(),
//       child: Scaffold(
//         backgroundColor: Colors.yellow.shade50.withOpacity(0.9),
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           elevation: 0,
//           //bottomOpacity: 0.0,
//           backgroundColor: Colors.transparent,
//           title: Text(
//             'Profile',
//             style: TextStyle(color: Colors.green.shade900),
//           ),
//           // Text('User ID: ${widget.userId}',
//           //       //     style: TextStyle(fontSize: 16)),
//           //       // Text('Turf ID: ${widget.turfId}',
//           //       //     style: TextStyle(fontSize: 16)),
//           //       // Text('Truf Name: ${widget.turfName}',
//           //       //     style: TextStyle(fontSize: 16)),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: ListView.builder(
//               itemCount: _controllers.length + 3,
//               itemBuilder: (context, index) {
//                 index--;
//                 if (index == -1) {
//                   index++;
//                   return CircleAvatar(
//                     backgroundColor: Colors.green,
//                     radius: 80,
//                     child: ClipOval(
//                       child: Image.asset(
//                         'assets/images/user.png',
//                       ),
//                     ),
//                   );
//                 }
//                 if (index < _controllers.length) {
//                   return Container(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 20,
//                     ),
//                     child: TextFormField(
//                       controller: _controllers[index],
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.yellow.shade50,
//                         hintText: _labels[index],
//                         suffixIcon: Icon(
//                           _icons[index],
//                           color: Colors.green,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.green.shade200,
//                             width: 2,
//                           ),
//                         ),
//                         focusedBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.green, width: 2),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Colors.green,
//                             width: 5,
//                           ),
//                           borderRadius: BorderRadius.circular(25.0),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Colors.red,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(25.0),
//                         ),
//                       ),
//                       keyboardType: _inputTypes[index],
//                       obscureText: index == 3,
//                       //validator: (value) => _validateInput(index, value!),
//                     ),
//                   );
//                 } else if (index == _controllers.length) {
//                   return Container(
//                     margin: const EdgeInsets.symmetric(vertical: 50),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color(0xFF326A1A),
//                           Color(0xFF499B26),
//                           Color(0xFF63D033),
//                         ],
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                       ),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     // child: ElevatedButton(
//                     //   onPressed: _submitForm,
//                     //   style: ElevatedButton.styleFrom(
//                     //     elevation: 0.0,
//                     //     backgroundColor: Colors.transparent,
//                     //   ),
//                     //   child: const Padding(
//                     //     padding: EdgeInsets.symmetric(
//                     //       vertical: 20.0,
//                     //       horizontal: 20.0,
//                     //     ),
//                     //     child: Text(
//                     //       'Sign Up',
//                     //       style: TextStyle(color: Colors.white),
//                     //     ),
//                     //   ),
//                     // ),
//                   );
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ApiService {
//   final String baseUrl;

//   ApiService({required this.baseUrl});

//   Future<Map<String, dynamic>> fetchData(String endpoint) async {
//     final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   Future<Map<String, dynamic>> postData(
//       String endpoint, Map<String, dynamic> data) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/$endpoint'),
//       headers: {"Content-Type": "application/json"},
//       body: json.encode(data),
//     );

//     if (response.statusCode == 201) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to post data');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:turf_trek/Widgets/background_theme.dart';

class EditProfile extends StatefulWidget {
  final String? customerId;
  final String? customerName;
  final String? mobileNum;

  const EditProfile({
    super.key,
    this.customerId,
    this.customerName,
    this.mobileNum,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = [
    TextEditingController(), // Name
    TextEditingController() // Mobile
  ];

  final List<String> _labels = ['Name', 'Mobile'];
  final List<TextInputType> _inputTypes = [
    TextInputType.text,
    TextInputType.phone,
  ];

  final List<IconData> _icons = [
    Icons.person,
    Icons.phone,
  ];

  @override
  void initState() {
    super.initState();
    // Set initial values for name and mobile number
    _controllers[0].text = widget.customerName ?? ''; // Name
    _controllers[1].text = widget.mobileNum ?? ''; // Mobile
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process data
      final name = _controllers[0].text;
      final mobile = _controllers[1].text;

      // Navigate to sign-up page or process the data as needed
      Navigator.pushNamed(
          context, '/signUpPage'); // Replace with your actual route
    }
  }

  String? _validateInput(int index, String value) {
    if (value.isEmpty) {
      return 'Please enter your ${_labels[index].toLowerCase()}';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BackGroundTheme(),
      child: Scaffold(
        backgroundColor: Colors.yellow.shade50.withOpacity(0.9),
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.green.shade900),
          backgroundColor: Colors.transparent,
          title: Text(
            'Profile',
            style: TextStyle(
                color: Colors.green.shade900,
                fontFamily: 'FontText',
                fontSize: 25),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView.builder(
              itemCount:
                  _controllers.length + 2, // Adjust for the avatar and button
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 80,
                    child: ClipOval(
                      child: Image.asset('assets/images/user.png'),
                    ),
                  );
                }
                if (index <= _controllers.length) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      controller: _controllers[index - 1],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow.shade50,
                        hintText: _labels[index - 1],
                        suffixIcon:
                            Icon(_icons[index - 1], color: Colors.green),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green.shade200, width: 2),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 5),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      keyboardType: _inputTypes[index - 1],
                      validator: (value) => _validateInput(index - 1, value!),
                    ),
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 50),
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
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // child: ElevatedButton(
                    //   onPressed: _submitForm,
                    //   style: ElevatedButton.styleFrom(
                    //     elevation: 0.0,
                    //     backgroundColor: Colors.transparent,
                    //   ),
                    //   child: const Padding(
                    //     padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    //     child: Text(
                    //       'Sign Up',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //   ),
                    // ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> postData(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
