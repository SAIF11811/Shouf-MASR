import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/agency_notifications_controller.dart';
import '../widgets/agency_bottom_nav.dart';

class AgencyNotificationsScreen extends StatefulWidget {
  AgencyNotificationsScreen({super.key});

  @override
  State<AgencyNotificationsScreen> createState() => _AgencyNotificationsScreenState();
}

class _AgencyNotificationsScreenState extends State<AgencyNotificationsScreen> {
  final AgencyNotificationsController controller =
  Get.put(AgencyNotificationsController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Opacity(
            opacity: 1,
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Booked Offers',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Obx(
                          () => ListView.separated(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: controller.agencyOffers.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final offer = controller.agencyOffers[index];
                          return Dismissible(
                            key: Key(offer["person"] + offer["time"]),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.red,
                              child: const Icon(Icons.delete,
                                  color: Colors.white),
                            ),
                            onDismissed: (_) {
                              controller.removeOffer(index);
                            },
                            child: _offerCard(
                              person: offer["person"],
                              destination: offer["destination"],
                              duration: offer["duration"],
                              budget: offer["budget"],
                              members: offer["members"],
                              time: offer["time"],
                              colorIndex: index,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom nav
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AgencyBottomNav(currentIndex: 0),
          ),
        ],
      ),
    );
  }
}

Widget _offerCard({
  String? person,
  String? destination,
  String? duration,
  int? budget,
  int? members,
  String? time,
  int colorIndex = 0,
}) {
  final colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.teal,
  ];
  final bgColor = colors[colorIndex % colors.length];

  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.all(12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: bgColor,
          child: const Icon(Icons.person, color: Colors.white, size: 26),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (person != null)
                Text(
                  person,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              if (destination != null)
                Text(
                  "Destination: $destination",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              if (duration != null)
                Text(
                  "Duration: $duration",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              if (budget != null)
                Text(
                  "Budget: $budget \$",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              if (members != null)
                Text(
                  "Members: $members",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
            ],
          ),
        ),
        if (time != null)
          Text(time, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    ),
  );
}
