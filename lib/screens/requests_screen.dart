import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/agency_bottom_nav.dart';
import '../widgets/components.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen>
    with SingleTickerProviderStateMixin {
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

  final Map<int, bool> _isSlidingOut = {};
  final Map<int, bool> _slideRight = {};

  void _handleAction(int index, String action) {
    final traveler = requests[index]['traveler'];

    setState(() {
      _isSlidingOut[index] = true;
      _slideRight[index] = action == "Accepted"; // slide right if accepted
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (index < requests.length) {
        setState(() {
          requests.removeAt(index);
          _isSlidingOut.remove(index);
          _slideRight.remove(index);
        });

        Get.snackbar(
          action,
          "$traveler's request ${action.toLowerCase()}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:
          action == "Accepted" ? Colors.green[100] : Colors.red[100],
        );
      }
    });
  }

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
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
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
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black54,
                            blurRadius: 6,
                            offset: Offset(1, 1),
                          ),
                        ],
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
                        final isSliding = _isSlidingOut[i] ?? false;
                        final slideRight = _slideRight[i] ?? false;

                        return AnimatedSlide(
                          offset: isSliding
                              ? (slideRight
                              ? const Offset(2, 0)
                              : const Offset(-2, 0))
                              : Offset.zero,
                          duration: const Duration(milliseconds: 300),
                          child: AnimatedOpacity(
                            opacity: isSliding ? 0 : 1,
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 6,
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
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomElevatedButton(
                                        text: 'Accept',
                                        onPressed: () =>
                                            _handleAction(i, "Accepted"),
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fullWidth: false,
                                      ),
                                      const SizedBox(width: 8),
                                      CustomElevatedButton(
                                        text: 'Refuse',
                                        onPressed: () =>
                                            _handleAction(i, "Refused"),
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
