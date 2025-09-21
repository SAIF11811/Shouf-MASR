import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tourism in Egypt')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // Add an image at the top
              Center(
                child: Image(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
                  ),
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Discover Egypt',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Egypt is one of the world\'s most fascinating travel destinations, '
                'famous for its ancient civilization and some of the world\'s most '
                'famous monuments, including the Giza Pyramids, the Great Sphinx, '
                'and the temples of Luxor and Aswan. Visitors can explore the rich '
                'history along the Nile, enjoy the vibrant culture, and relax on the '
                'beautiful beaches of the Red Sea. Whether you are interested in history, '
                'adventure, or relaxation, Egypt offers something for everyone.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                'Top Attractions:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '• The Pyramids of Giza\n'
                '• The Egyptian Museum in Cairo\n'
                '• Karnak Temple in Luxor\n'
                '• Valley of the Kings\n'
                '• Abu Simbel Temples\n'
                '• Red Sea Resorts (Sharm El-Sheikh, Hurghada)',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
