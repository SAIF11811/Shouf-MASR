import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  const OfferDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> company =
        (article['company'] is Map<String, dynamic>)
        ? article['company'] as Map<String, dynamic>
        : {};

    // star rating
    List<Widget> buildStars(double rating) {
      int fullStars = rating.floor();
      bool halfStar = (rating - fullStars) >= 0.5;
      return List.generate(5, (index) {
        if (index < fullStars)
          return const Icon(Icons.star, color: Colors.amber, size: 18);
        if (index == fullStars && halfStar)
          return const Icon(Icons.star_half, color: Colors.amber, size: 18);
        return const Icon(Icons.star_border, color: Colors.grey, size: 18);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(article['title'] ?? 'Offer Details'),
        backgroundColor: const Color(0xFFcdcc00),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Offer Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                article['image'] ??
                    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              article['title'] ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Days / Price / Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _InfoColumn(
                  icon: Icons.calendar_today,
                  label: article['days'] ?? '-',
                ),
                _InfoColumn(
                  icon: Icons.attach_money,
                  label: article['price'] ?? '-',
                ),
                Column(
                  children: [
                    Row(
                      children: buildStars((article['rating'] ?? 0).toDouble()),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      (article['rating'] ?? '-').toString(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Company Info
            if (company.isNotEmpty)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Organized by ${company['name'] ?? '-'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        company['description'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            'Rating: ${company['rating'] ?? '-'}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            // What's Included
            const SizedBox(height: 12),
            const Text(
              'What\'s Included:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 6),
            if (company['trips'] != null && company['trips'] is List)
              ...List.generate(
                (company['trips'] as List).length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '• ${(company['trips'] as List)[index].toString()}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),

            // Packages
            if (company['packages'] != null && company['packages'] is List) ...[
              const SizedBox(height: 16),
              const Text(
                'Packages:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(height: 6),
              ...List.generate(
                (company['packages'] as List).length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '• ${(company['packages'] as List)[index]}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],

            // Reviews
            if (company['reviews'] != null && company['reviews'] is List) ...[
              const SizedBox(height: 16),
              const Text(
                'Reviews:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(height: 6),
              ...List.generate(
                (company['reviews'] as List).length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '• ${(company['reviews'] as List)[index]}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),
            Text(
              'Price: ${article['price'] ?? '-'} per person',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFFcdcc00),
              ),
            ),
            const SizedBox(height: 30),

            // Book Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFcdcc00),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  const action = "Your request is sent";
                  final offer = article['title'] ?? "Booking";

                  Get.snackbar(
                    action,
                    "$offer booking sent",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green[100],
                    colorText: Colors.black,
                    duration: const Duration(seconds: 2),
                  );
                },
                child: const Text('Book Now', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? iconColor;

  const _InfoColumn({required this.icon, required this.label, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor ?? Colors.black54),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
