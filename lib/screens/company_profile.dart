import 'package:flutter/material.dart';

class CompanyProfileScreen extends StatelessWidget {
  final Map<String, dynamic>? company;

  const CompanyProfileScreen({super.key, this.company});

  @override
  Widget build(BuildContext context) {
    final data = company ?? {
      "name": "Unknown Company",
      "description": "No description available.",
      "rating": 0.0,
      "trips": <String>[],
      "packages": <String>[],
      "reviews": <String>[],
    };

    final double rating =
    (data['rating'] is num) ? (data['rating'] as num).toDouble() : 0.0;
    final List trips = (data['trips'] is List) ? data['trips'] : <String>[];
    final List packages = (data['packages'] is List) ? data['packages'] : <String>[];
    final List reviews = (data['reviews'] is List) ? data['reviews'] : <String>[];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Company Profile",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFcdcc00),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFf8f8f8), Color(0xFFe6e6e6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Display company name prominently
            Center(
              child: Text(
                data['name'] ?? "Unknown Company",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 16),

            _sectionCard(
              title: "About",
              child: Text(
                data['description'] ?? "No description available.",
                style: const TextStyle(fontSize: 15, height: 1.4),
              ),
            ),
            _sectionCard(
              title: "Rating",
              child: Row(
                children: [
                  _buildStarRating(rating),
                  const SizedBox(width: 8),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            _sectionCard(
              title: "Previous Trips",
              child: trips.isNotEmpty
                  ? _verticalList(trips, Icons.map)
                  : const Text("No trips available.",
                  style: TextStyle(color: Colors.grey)),
            ),
            _sectionCard(
              title: "Offer Packages",
              child: packages.isNotEmpty
                  ? _verticalList(packages, Icons.card_travel)
                  : const Text("No packages available.",
                  style: TextStyle(color: Colors.grey)),
            ),
            _sectionCard(
              title: "Reviews",
              child: reviews.isNotEmpty
                  ? Column(
                  children:
                  reviews.map((r) => _reviewTile(r.toString())).toList())
                  : const Text("No reviews yet.",
                  style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Colors.amber, size: 20);
        } else if (index < rating) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 20);
        }
      }),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _verticalList(List items, IconData icon) {
    return Column(
      children: items.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black54, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.toString(),
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _reviewTile(String review) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration:
      BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.person, color: Colors.grey, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(review, style: const TextStyle(fontSize: 13, height: 1.3))),
        ],
      ),
    );
  }
}
