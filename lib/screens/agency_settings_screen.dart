import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared_preference.dart';
import '../widgets/agency_bottom_nav.dart';

class AgencySettingsController extends GetxController {
  RxBool notificationsEnabled = true.obs;
  RxString selectedLanguage = 'English'.obs;
  RxBool backupEnabled = false.obs;
  RxBool locationAccess = true.obs;

  Future<void> logout() async {
    await SharedPreferenceHelper.setRememberMe(false);
    Get.offAllNamed('/role-selection');
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  void changeLanguage(String language) {
    selectedLanguage.value = language;
  }

  void toggleBackup(bool value) {
    backupEnabled.value = value;
  }

  void toggleLocation(bool value) {
    locationAccess.value = value;
  }
}

class AgencySettingsScreen extends StatelessWidget {
  AgencySettingsScreen({super.key});

  final AgencySettingsController controller = Get.put(AgencySettingsController());

  final RxInt currentIndex = 2.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.defaultDialog(
                title: 'Log out',
                middleText: 'Are you sure you want to log out?',
                textCancel: 'Cancel',
                textConfirm: 'Log out',
                confirmTextColor: Colors.white,
                cancelTextColor: Colors.black,
                backgroundColor: Colors.white,
                onCancel: () => Get.back(),
                onConfirm: () async {
                  await controller.logout();
                  Get.back();
                },
              );
            },
            tooltip: 'Log out',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            const Text('Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.business)),
              title: const Text('EgyTrips Agency'),
              subtitle: const Text('EgyTripsy@gmail.com'),
            ),
            const Divider(height: 32),

            // Preferences Section
            const Text('Preferences', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Obx(() => SwitchListTile(
              title: const Text('Enable Notifications'),
              value: controller.notificationsEnabled.value,
              onChanged: controller.toggleNotifications,
              secondary: const Icon(Icons.notifications),
            )),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              trailing: Obx(() => Text(controller.selectedLanguage.value)),
              onTap: () {
                Get.defaultDialog(
                  title: 'Select Language',
                  content: Column(
                    children: [
                      ListTile(
                        title: const Text('English'),
                        onTap: () {
                          controller.changeLanguage('English');
                          Get.back();
                        },
                      ),
                      ListTile(
                        title: const Text('Arabic'),
                        onTap: () {
                          controller.changeLanguage('Arabic');
                          Get.back();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(height: 32),

            // Security Section
            const Text('Security', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              onTap: () {
                // Navigate to change password screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy & Security'),
              onTap: () {
                // Navigate to privacy screen
              },
            ),
            Obx(() => SwitchListTile(
              title: const Text('Location Access'),
              value: controller.locationAccess.value,
              onChanged: controller.toggleLocation,
              secondary: const Icon(Icons.location_on),
            )),
            const Divider(height: 32),

            // Backup & Sync Section
            const Text('Backup & Sync', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Obx(() => SwitchListTile(
              title: const Text('Enable Backup'),
              value: controller.backupEnabled.value,
              onChanged: controller.toggleBackup,
              secondary: const Icon(Icons.cloud),
            )),
            const Divider(height: 32),

            // Support Section
            const Text('Support', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & FAQ'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.contact_support),
              title: const Text('Contact Support'),
              onTap: () {},
            ),
            const Divider(height: 32),

            // About Section
            const Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('App Version'),
              subtitle: const Text('v1.0.0'),
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Terms of Service'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy Policy'),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => AgencyBottomNav(currentIndex: currentIndex.value)),
    );
  }
}
