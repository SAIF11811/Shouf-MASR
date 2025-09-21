import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/traveler_bottom_nav.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final RxInt currentIndex = 3.obs;

  final List<Map<String, String>> notifications = [
    {
      "title": "Pharaoh Travels",
      "message": "Exclusive discount for a Giza Pyramids tour this weekend!",
      "time": "2m ago"
    },
    {
      "title": "Nile Star Cruises",
      "message": "Your luxury cruise booking has been confirmed.",
      "time": "15m ago"
    },
    {
      "title": "Desert Horizon",
      "message": "Join our safari adventure to the White Desert.",
      "time": "1h ago"
    },
    {
      "title": "Red Sea Voyages",
      "message": "Snorkeling and diving packages are now available.",
      "time": "3h ago"
    },
    {
      "title": "Cairo Heritage Tours",
      "message": "Don’t miss the new exhibition at the Egyptian Museum.",
      "time": "Yesterday"
    },
    {
      "title": "Lotus Travel Agency",
      "message": "Enjoy a guided tour of Luxor and Karnak temples.",
      "time": "2d ago"
    },
    {
      "title": "Oasis Explorer",
      "message": "Experience Siwa Oasis with our special package.",
      "time": "3d ago"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background image
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.55,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Notifications',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      itemCount: notifications.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final n = notifications[index];
                        return _notificationCard(
                          title: n["title"],
                          message: n["message"],
                          time: n["time"],
                          colorIndex: index,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
            () => TravelerBottomNav(currentIndex: currentIndex.value),
      ),
    );
  }
}

Widget _notificationCard({
  String? title,
  String? message,
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

  return InkWell(
    onTap: () {},
    borderRadius: BorderRadius.circular(16),
    child: Container(
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
          // Profile icon
          CircleAvatar(
            radius: 24,
            backgroundColor: bgColor,
            child: const Icon(Icons.person, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 12),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                if (message != null)
                  Text(
                    message,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
              ],
            ),
          ),

          // Time label
          if (time != null)
            Text(
              time,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
        ],
      ),
    ),
  );
}
