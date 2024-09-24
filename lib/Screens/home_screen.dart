import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for jsonDecode
import 'package:turf_trek/model/constants.dart';
import 'package:turf_trek/Screens/notifications_screen.dart';
import 'package:turf_trek/Screens/turf_booking_screen.dart';
import 'package:turf_trek/Widgets/background_theme.dart';
import 'package:turf_trek/Widgets/homepage_slider.dart';

class HomeScreen extends StatefulWidget {
  final String? customerId;
  final String? customerName;
  final String? mobileNum;

  const HomeScreen({
    super.key,
    this.customerId,
    this.customerName,
    this.mobileNum,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedSport = 0;
  int selectedCityId = 1; // Default city ID for Bhilwara
  String selectedCityName = 'Bhilwara'; // Default city name
  List<String> sportsItem = ['All'];
  List<Map<String, dynamic>> cities = [];
  List<Map<String, dynamic>> turfs = []; // Store fetched turfs
  Map<String, Map<String, dynamic>> sportDetails = {};

  @override
  void initState() {
    super.initState();
    fetchCities();
    selectedSport = 0; // Set default sport to 'All'
    fetchSportsItems(selectedCityId); // Automatically fetch sports for Bhilwara
    fetchTurfs(selectedCityId); // Fetch all turfs for default city and sport
  }

  Future<void> fetchCities() async {
    try {
      final response = await http.get(Uri.parse('${BASE_URL}get_cities.php'));

      if (response.statusCode == 200) {
        List<dynamic> cityData = jsonDecode(response.body);
        setState(() {
          cities = cityData
              .map((city) => {
                    'city_id': int.parse(city['city_id']),
                    'user_id': int.parse(city['user_id']),
                    'city': city['city'],
                  })
              .toList();

          // Check if 'Bhilwara' exists in the fetched cities
          if (cities.any((city) => city['city'] == 'Bhilwara')) {
            selectedCityName = 'Bhilwara';
            selectedCityId = cities
                .firstWhere((city) => city['city'] == 'Bhilwara')['city_id'];
          } else {
            // Handle the case where 'Bhilwara' is not found
            selectedCityName =
                cities.isNotEmpty ? cities.first['city'] : 'Select City';
            selectedCityId = cities.isNotEmpty ? cities.first['city_id'] : 1;
          }
        });
        fetchSportsItems(
            selectedCityId); // Fetch sports items for the default city
      } else {
        print('Failed to load cities: ${response.statusCode}');
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchSportsItems(int cityId) async {
    try {
      final response = await http.get(
        Uri.parse('${BASE_URL}get_sports.php?city_id=$cityId'),
      );

      if (response.statusCode == 200) {
        List<dynamic> sportsData = jsonDecode(response.body);
        setState(() {
          sportsItem = ['All'];
          sportsItem.addAll(sportsData.map((sport) => sport['category_name']));
          // Store game_id, city_id, and turf_id in a map for later use
          sportDetails.clear(); // Clear previous data
          sportsData.forEach((sport) {
            sportDetails[sport['category_name']] = {
              'game_id': sport['game_id'],
              'city_id': cityId,
              'turf_id': sport['turf_id'],
            };
          });
        });
      } else {
        print('Failed to load sports: ${response.statusCode}');
        throw Exception('Failed to load sports');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchTurfs(int cityId) async {
    try {
      final response = await http.get(
        Uri.parse('${BASE_URL}get_turfs.php?city_id=$cityId'),
      );

      if (response.statusCode == 200) {
        List<dynamic> turfData = jsonDecode(response.body);
        setState(() {
          turfs = turfData
              .map((turf) => {
                    'turf_name': turf['turf_name'],
                    'address': turf['address'],
                    'post_img': turf['post_img'],
                    'turf_id': turf['turf_id'],
                    'user_id': turf['user_id'],
                  })
              .toList();
        });
      } else {
        print('Failed to load turfs: ${response.statusCode}');
        throw Exception('Failed to load turfs');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchTurfsBySport(int cityId, String sportCategory) async {
    final turfId = sportDetails[sportCategory]?['turf_id'];
    if (turfId == null) {
      print('No turf_id found for selected sport');
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            '${BASE_URL}get_turfs_by_sport.php?city_id=$cityId&turf_id=$turfId'),
      );

      if (response.statusCode == 200) {
        List<dynamic> turfData = jsonDecode(response.body);
        setState(() {
          turfs = turfData
              .map((turf) => {
                    'turf_name': turf['turf_name'],
                    'address': turf['address'],
                    'post_img': turf['post_img'],
                    'turf_id': turf['turf_id'],
                    'user_id': turf['user_id'],
                  })
              .toList();
        });
      } else {
        print('Failed to load turfs: ${response.statusCode}');
        throw Exception('Failed to load turfs');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BackGroundTheme(),
      child: Scaffold(
        backgroundColor: Colors.yellow.shade50.withOpacity(0.9),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.yellow.shade50,
              title: Container(
                decoration: BoxDecoration(
                  color: const Color(0xfffffdeb),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.shade900),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.search, color: Colors.green.shade900),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedCityName,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCityName = newValue ?? 'Bhilwara';
                            selectedCityId = cities.firstWhere(
                              (city) => city['city'] == newValue,
                              orElse: () => {'city_id': 1, 'city': 'Bhilwara'},
                            )['city_id'];
                          });
                          fetchSportsItems(
                              selectedCityId); // Fetch sports for selected city
                          fetchTurfs(selectedCityId);
                        },
                        underline: const SizedBox(),
                        isExpanded: true,
                        items: cities.map<DropdownMenuItem<String>>((city) {
                          return DropdownMenuItem<String>(
                            value: city['city'],
                            child: Text(
                              city['city'],
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'FontText',
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.green.shade900,
                  ),
                ),
              ],
            ),
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  HomeSlider(),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sports',
                        style: TextStyle(fontSize: 30, fontFamily: 'FontTitle'),
                      ),
                      SizedBox(
                        height: 45,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sportsItem.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0, vertical: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedSport = index;
                                  });
                                  if (sportsItem[index] == 'All') {
                                    fetchTurfs(
                                        selectedCityId); // Fetch all turfs for selected city
                                  } else {
                                    // If a specific sport is selected, you can filter based on sport category
                                    // Implement a similar fetch function for filtering by sport category if required.
                                    var details =
                                        sportDetails[sportsItem[index]];
                                    if (details != null) {
                                      print('City ID: ${details['city_id']}');
                                      print('Game ID: ${details['game_id']}');
                                      print('Turf ID: ${details['turf_id']}');
                                    }
                                    fetchTurfsBySport(
                                        selectedCityId, sportsItem[index]);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  elevation: selectedSport == index ? 5.0 : 0.0,
                                  backgroundColor: selectedSport == index
                                      ? const Color(0xfffffdeb)
                                      : Colors.green,
                                  foregroundColor: selectedSport == index
                                      ? Colors.green.shade900
                                      : Colors.white,
                                ),
                                child: Text(
                                  sportsItem[index],
                                  style: TextStyle(
                                    fontFamily: 'FontText',
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
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  // Display turf data fetched from the database
                  final turf =
                      turfs[index]; // Get turf data for the current index
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    height: 200,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 200, // Adjust the height as per your design
                          width: double
                              .infinity, // This ensures the image takes full width
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              '${IMG_URL}${turf['post_img']}',
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
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.shade900.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              color: const Color(0xFFFFFDEB),
                            ),
                            child: ListTile(
                              title: Text(
                                turf['turf_name'],
                                style: TextStyle(
                                  fontFamily: 'FontTitle',
                                  color: Colors.green.shade900,
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text(
                                turf['address'],
                                style: TextStyle(
                                  fontFamily: 'FontExtra',
                                  color: Colors.green.shade900,
                                  fontSize: 12,
                                ),
                              ),
                              // subtitle: Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       turf['address'],
                              //       style: TextStyle(
                              //         fontFamily: 'FontExtra',
                              //         color: Colors.green.shade900,
                              //         fontSize: 12,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //         height:
                              //             5), // Space between subtitle and ID
                              //     Text(
                              //       'Turf ID: ${turf['turf_id']}',
                              //       style: TextStyle(
                              //         fontFamily: 'FontExtra',
                              //         color: Colors.green.shade900,
                              //         fontSize: 12,
                              //       ),
                              //     ),
                              //     Text(
                              //       'user ID: ${turf['user_id']}',
                              //       style: TextStyle(
                              //         fontFamily: 'FontExtra',
                              //         color: Colors.green.shade900,
                              //         fontSize: 12,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5.0,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  // shape: const StadiumBorder(),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TurfBookingScreen(
                                        turfName: turf['turf_name'],
                                        turfId: turf['turf_id'],
                                        userId: turf['user_id'],
                                        postImg: turf['post_img'],
                                        customerId: widget.customerId,
                                        customerName: widget.customerName,
                                        mobileNum: widget.mobileNum,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'BOOK',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontText',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: turfs.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 100.0;

  @override
  double get maxExtent => 100.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: overlapsContent ? 4.0 : 0.0,
      child: Container(
        color: Colors.yellow.shade50.withOpacity(0.8),
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
