import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/agency_notifications_controller.dart';
import '../widgets/agency_bottom_nav.dart';

class AgencyNotificationsScreen extends StatefulWidget {
  const AgencyNotificationsScreen({super.key});

  @override
  State<AgencyNotificationsScreen> createState() =>
      _AgencyNotificationsScreenState();
}

class _AgencyNotificationsScreenState extends State<AgencyNotificationsScreen> {
  final AgencyNotificationsController controller =
  Get.put(AgencyNotificationsController(), permanent: true);

  final TextEditingController _dateController = TextEditingController();

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Future<void> _pickDateRange() async {
    final DateTime now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
      initialDateRange:
      DateTimeRange(start: now, end: now.add(const Duration(days: 1))),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFcdcc00),
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text =
        "${_formatDate(picked.start)} - ${_formatDate(picked.end)}";
      });
    }
  }

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
                        separatorBuilder: (_, __) =>
                        const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final offer = controller.agencyOffers[index];
                          return Dismissible(
                            key: Key(offer["person"] + offer["time"]),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (_) {
                              controller.removeOffer(index);
                            },
                            child: _offerCard(
                              index: index,
                              dateController: _dateController,
                              onPickDateRange: _pickDateRange,
                              onRemove: () {
                                controller.removeOffer(index);
                              },
                              person: offer["person"],
                              destination: offer["destination"],
                              duration: offer["duration"],
                              budget: offer["budget"],
                              members: offer["members"],
                              time: offer["time"],
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
  required int index,
  required VoidCallback onRemove,
  required TextEditingController dateController,
  required VoidCallback onPickDateRange,
  String? person,
  String? destination,
  String? duration,
  int? budget,
  int? members,
  String? time,
  int colorIndex = 0,
}) {
  final colors = [Colors.blue, Colors.green, Colors.orange, Colors.red, Colors.purple, Colors.teal];
  final bgColor = colors[colorIndex % colors.length];

  final RxBool isRemoved = false.obs;

  return Obx(() {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      offset: isRemoved.value ? const Offset(-1.0, 0) : Offset.zero,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: isRemoved.value ? 0 : 1,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2)),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: bgColor,
                    child:
                    const Icon(Icons.person, color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (person != null)
                          Text(person,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        if (destination != null)
                          Text("Destination: $destination",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700])),
                        if (duration != null)
                          Text("Duration: $duration",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700])),
                        if (budget != null)
                          Text("Budget: $budget \$",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700])),
                        if (members != null)
                          Text("Members: $members",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700])),
                      ],
                    ),
                  ),
                  if (time != null)
                    Text(time,
                        style:
                        TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Get.snackbar(
                        "Accepted",
                        "Offer accepted successfully!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 1),
                      );

                      isRemoved.value = true;

                      await Future.delayed(const Duration(milliseconds: 400));
                      onRemove();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child:
                    const Text("Accept", style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final _formKey = GlobalKey<FormState>();
                      final TextEditingController _destinationController = TextEditingController();
                      final TextEditingController _dateControllerSheet = TextEditingController();
                      final TextEditingController _budgetController = TextEditingController();

                      Future<void> _pickDateRangeSheet() async {
                        final DateTime now = DateTime.now();
                        final picked = await showDateRangePicker(
                          context: Get.context!,
                          firstDate: now,
                          lastDate: DateTime(now.year + 2),
                          initialDateRange: DateTimeRange(
                            start: now,
                            end: now.add(const Duration(days: 1)),
                          ),
                        );
                        if (picked != null) {
                          _dateControllerSheet.text =
                          "${picked.start.day}/${picked.start.month}/${picked.start.year} - "
                              "${picked.end.day}/${picked.end.month}/${picked.end.year}";
                        }
                      }

                      Get.bottomSheet(
                        SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 50,
                                      height: 5,
                                      margin: const EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: const Text(
                                      "The Another Offer",
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  TextFormField(
                                    controller: _destinationController,
                                    decoration: const InputDecoration(
                                      labelText: "Destination",
                                      hintText: "Enter destination",
                                      prefixIcon: Icon(Icons.location_on),
                                      border: UnderlineInputBorder(),
                                    ),
                                    validator: (value) =>
                                    value == null || value.isEmpty ? "Destination is required" : null,
                                  ),
                                  const SizedBox(height: 30),
                                  GestureDetector(
                                    onTap: _pickDateRangeSheet,
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: _dateControllerSheet,
                                        readOnly: true,
                                        decoration: const InputDecoration(
                                          labelText: "Travel Dates",
                                          hintText: "Select travel dates",
                                          prefixIcon: Icon(Icons.calendar_today),
                                          border: UnderlineInputBorder(),
                                        ),
                                        validator: (value) =>
                                        value == null || value.isEmpty ? "Travel dates required" : null,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  TextFormField(
                                    controller: _budgetController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: "Budget",
                                      hintText: "Enter cost",
                                      prefixIcon: Icon(Icons.attach_money),
                                      border: UnderlineInputBorder(),
                                    ),
                                    validator: (value) =>
                                    value == null || value.isEmpty ? "Budget is required" : null,
                                  ),
                                  const SizedBox(height: 50),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        Get.back();
                                        Get.snackbar(
                                          "Offer Sent",
                                          "Your offer has been sent successfully!",
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                          duration: const Duration(seconds: 1),
                                        );

                                        isRemoved.value = true;

                                        await Future.delayed(const Duration(milliseconds: 400));
                                        onRemove();
                                      }
                                    },
                                    icon: const Icon(Icons.send),
                                    label: const Text("Send Offer"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFcdcc00),
                                      foregroundColor: Colors.white,
                                      minimumSize: const Size.fromHeight(50),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        isScrollControlled: true,
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text(
                      "Send Another Offer",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  });
}
