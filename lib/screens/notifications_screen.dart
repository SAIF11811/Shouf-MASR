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
      appBar: AppBar(title: const Text('Notifications')),
      body: const Center(child: Text('Notifications')),
      bottomNavigationBar: Obx(
        () => BottomNav(currentIndex: currentIndex.value),
      ),
    );
  }
}
