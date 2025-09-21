import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/traveler_bottom_nav.dart';
import 'article_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _tappedIndex = -1;

  final List<Map<String, String>> articles = [
    {
      "image": "https://images.pexels.com/photos/32902076/pexels-photo-32902076.jpeg",
      "title": "Unveiling the Mysteries of the Pyramids",
      "author": "By Eagle Travel",
    },
    {
      "image": "https://images.pexels.com/photos/16535883/pexels-photo-16535883.jpeg",
      "title": "Walking Through the Temples of Luxor",
      "author": "By Ancient Trails",
    },
    {
      "image": "https://images.pexels.com/photos/5727263/pexels-photo-5727263.jpeg",
      "title": "A Timeless Journey Sailing the Nile",
      "author": "By Nile Cruises",
    },
    {
      "image": "https://images.pexels.com/photos/6405483/pexels-photo-6405483.jpeg",
      "title": "Discovering Peace at Siwa Oasis",
      "author": "By Desert Explorer",
    },
    {
      "image": "https://images.pexels.com/photos/3390587/pexels-photo-3390587.jpeg",
      "title": "Exploring the Underwater Wonders of the Red Sea",
      "author": "By Ocean Explorer",
    },
    {
      "image": "https://images.pexels.com/photos/6177483/pexels-photo-6177483.jpeg",
      "title": "Inside the Egyptian Museum of Cairo",
      "author": "By Heritage Guide",
    },
  ];

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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Welcome Section
                          const _SectionTitle(
                            icon: Icons.waving_hand,
                            title: 'Welcome',
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Hello ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: 'Sophia!',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Articles Section
                          const _SectionTitle(
                            icon: Icons.article,
                            title: 'Articles',
                          ),
                          const SizedBox(height: 12),

                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.75,
                            children: List.generate(
                              articles.length,
                                  (i) => _articleCard(
                                i,
                                articles[i],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),

          // Bottom navigation
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: TravelerBottomNav(currentIndex: 0),
          ),
        ],
      ),
    );
  }

  Widget _articleCard(int i, Map<String, String> article) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _tappedIndex = i),
      onTapUp: (_) => setState(() => _tappedIndex = -1),
      onTapCancel: () => setState(() => _tappedIndex = -1),
      onTap: () => Get.to(() => ArticleScreen(article: article)),
      child: AnimatedScale(
        scale: _tappedIndex == i ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    article["image"]!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
                child: Column(
                  children: [
                    Text(
                      article["title"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
