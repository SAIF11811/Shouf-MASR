import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/agency_bottom_nav.dart';
import '../widgets/components.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> with SingleTickerProviderStateMixin {
  int _tappedIndex = -1;

  final RxInt currentIndex = 0.obs;

  final List<Map<String, dynamic>> requests = [
    {
      'traveler': 'Ahmed Ali',
      'dest': 'Cairo - Alexandria',
      'days': '5 days',
      'budget': '1500 \$',
    },
    {
      'traveler': 'Sara Mohamed',
      'dest': 'Luxor - Aswan',
      'days': '7 days',
      'budget': '2200 \$',
    },
    {
      'traveler': 'John Smith',
      'dest': 'Sharm El-Sheikh',
      'days': '4 days',
      'budget': '1800 \$',
    },
    {
      'traveler': 'Fatma Hassan',
      'dest': 'Hurghada',
      'days': '6 days',
      'budget': '2500 \$',
    },
    {
      'traveler': 'Michael Brown',
      'dest': 'Giza Pyramids',
      'days': '2 days',
      'budget': '800 \$',
    },
    {
      'traveler': 'Noha Samir',
      'dest': 'Siwa Oasis',
      'days': '8 days',
      'budget': '3000 \$',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Opacity(
            opacity: 1,
            child: Image.network(
              'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/5320a810acd3f7b9e7bf278b1f459970e6fdb712.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Center(
                    child: Text(
                      'Requests',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Requests list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: requests.length,
                      itemBuilder: (context, i) {
                        final req = requests[i];
                        return GestureDetector(
                          onTapDown: (_) => setState(() => _tappedIndex = i),
                          onTapUp: (_) => setState(() => _tappedIndex = -1),
                          onTapCancel: () => setState(() => _tappedIndex = -1),
                          child: AnimatedScale(
                            scale: _tappedIndex == i ? 0.97 : 1.0,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeInOut,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    req['traveler'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text('Destination: ${req['dest']}'),
                                  Text('Duration: ${req['days']}'),
                                  Text('Budget: ${req['budget']}'),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: List.generate(
                                      5,
                                          (j) => Icon(
                                        j < (req['rating'] as int)
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: j < (req['rating'] as int)
                                            ? Colors.amber
                                            : Colors.grey,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomElevatedButton(
                                        text: 'Accept',
                                        onPressed: () {
                                          Get.snackbar(
                                            'Accepted',
                                            '${req['traveler']}\'s request accepted',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.green[100],
                                          );
                                        },
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fullWidth: false,
                                      ),
                                      const SizedBox(width: 8),
                                      CustomElevatedButton(
                                        text: 'Refuse',
                                        onPressed: () {
                                          Get.snackbar(
                                            'Refused',
                                            '${req['traveler']}\'s request refused',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.red[100],
                                          );
                                        },
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fullWidth: false,
                                      ),
                                    ],
                                  ),
                                ],
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

          // Nav bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Obx(() => AgencyBottomNav(currentIndex: currentIndex.value)),
          ),
        ],
      ),
    );
  }
}
