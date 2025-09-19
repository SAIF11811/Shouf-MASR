import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/agency_bottom_nav.dart';

class SendOfferScreen extends StatelessWidget {
  SendOfferScreen({super.key});

  final RxInt currentIndex = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Offer')),
      body: const Center(child: Text('Send offer form')),
      bottomNavigationBar: Obx(() => AgencyBottomNav(currentIndex: currentIndex.value)),
    );
  }
}
