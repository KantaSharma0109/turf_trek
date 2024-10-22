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
      // final name = _controllers[0].text;
      // final mobile = _controllers[1].text;

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
