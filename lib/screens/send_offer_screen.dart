import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/agency_bottom_nav.dart';
import '../widgets/components.dart';

class SendOfferScreen extends StatefulWidget {
  const SendOfferScreen({super.key});

  @override
  State<SendOfferScreen> createState() => _SendOfferScreenState();
}

class _SendOfferScreenState extends State<SendOfferScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    _dateController.text = "${_formatDate(now)} - ${_formatDate(tomorrow)}";
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Future<void> _pickDateRange() async {
    final DateTime now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
      initialDateRange: DateTimeRange(
        start: now,
        end: now.add(const Duration(days: 1)),
      ),
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

  Future<void> _pickImageFromGallery() async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      if (await Permission.storage.isGranted ||
          await Permission.photos.isGranted ||
          await Permission.mediaLibrary.isGranted) {
        status = PermissionStatus.granted;
      } else {
        if (Platform.operatingSystemVersion.contains("13") ||
            Platform.operatingSystemVersion.contains("14")) {
          status = await Permission.photos.request();
        } else {
          status = await Permission.storage.request();
        }
      }
    } else {
      status = await Permission.photos.request();
    }

    if (!status.isGranted) {
      Get.snackbar("Permission Denied", "Please allow access to photos");
      return;
    }

    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  void _sendOffer() {
    if (_formKey.currentState!.validate()) {
      Get.snackbar(
        "Offer Sent",
        "Your travel offer has been submitted successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
      );
    } else {
      Get.snackbar(
        "Error",
        "Please fill in all required fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcdcc00),
      body: Stack(
        children: [
          // Background image
          Opacity(
            opacity: 0.25,
            child: Image.network(
              'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/5320a810acd3f7b9e7bf278b1f459970e6fdb712.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Logo
                  Center(
                    child: Image.network(
                      'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/248cd0554d0da56d81aece5474bbcdfb9f21ec3a.png',
                      width: 160,
                      height: 55,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Center(
                              child: Text(
                                'Send Travel Offer',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 4,
                                      offset: const Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),

                            // Destination
                            const _SectionTitle(
                              icon: Icons.location_on,
                              title: 'Destination in Egypt',
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              controller: _destinationController,
                              label: "Destination",
                              hintText: "Enter destination",
                              keyboardType: TextInputType.name,
                              prefixIcon: Icons.location_on,
                              validator: (value) =>
                              value == null || value.isEmpty
                                  ? "Destination is required"
                                  : null,
                            ),
                            const SizedBox(height: 20),

                            // Travel Dates
                            const _SectionTitle(
                              icon: Icons.date_range,
                              title: 'Travel Dates',
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: _pickDateRange,
                              child: AbsorbPointer(
                                child: CustomTextField(
                                  controller: _dateController,
                                  label: "Travel Dates",
                                  hintText: "Select travel dates",
                                  prefixIcon: Icons.calendar_today,
                                  readOnly: true,
                                  validator: (value) =>
                                  value == null || value.isEmpty
                                      ? "Travel dates are required"
                                      : null,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Budget
                            const _SectionTitle(
                              icon: Icons.attach_money,
                              title: 'Cost',
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              controller: _budgetController,
                              label: "Budget",
                              hintText: "Enter cost",
                              keyboardType: TextInputType.number,
                              prefixIcon: Icons.attach_money,
                              validator: (value) =>
                              value == null || value.isEmpty
                                  ? "Budget is required"
                                  : null,
                            ),
                            const SizedBox(height: 20),

                            // Image Attachment (Optional)
                            const _SectionTitle(
                              icon: Icons.image,
                              title: 'Attach Image (Optional)',
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: _pickImageFromGallery,
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                                child: _selectedImage != null
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                )
                                    : const Center(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_a_photo,
                                          size: 40, color: Colors.white),
                                      SizedBox(height: 8),
                                      Text(
                                        "Tap to attach image (optional)",
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // send offer button
                            Center(
                              child: CustomElevatedButton(
                                text: "Send Offer",
                                onPressed: _sendOffer,
                                fullWidth: true,
                                backgroundColor: const Color(0xFFcdcc00),
                                textColor: Colors.white,
                                icon: Icons.send,
                                iconRight: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // bottom nav (agency)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: const AgencyBottomNav(currentIndex: 1),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionTitle({required this.icon, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
