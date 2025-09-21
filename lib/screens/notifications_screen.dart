import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../widgets/traveler_bottom_nav.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final RxInt currentIndex = 3.obs;

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
                image: NetworkImage(
                  'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/5320a810acd3f7b9e7bf278b1f459970e6fdb712.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                  _notificationCard(
                    logoUrl:
                        'https://images.unsplash.com/photo-1602934445884-da0fa1c9d3b3?q=80&w=958&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    text: 'Eagle company Sent you an offer',
                  ),
                  const SizedBox(height: 16),
                  _notificationCard(),
                  const SizedBox(height: 16),
                  _notificationCard(),
                  const SizedBox(height: 16),
                  _notificationCard(),
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

Widget _notificationCard({String? logoUrl, String? text}) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        if (logoUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              logoUrl,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        if (logoUrl != null) const SizedBox(width: 12),
        Expanded(child: Text(text ?? '', style: const TextStyle(fontSize: 15))),
      ],
    ),
  );
}
