import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../model/app_model.dart';
import '../services/PlacesService.dart' hide PlaceModel;
import '../widgits/CustomBottomNav.dart';
import 'PlaceDetailsScreen.dart';
import 'all_places.dart';
import 'nav_bar/ProfileScreen.dart';
import 'nav_bar/favourite.dart';
import 'nav_bar/search.dart';

class HomeScreenex extends StatefulWidget {
  final int initialIndex; // أضفنا هذا المتغير لاستقبال الصفحة المطلوبة

  const HomeScreenex({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<HomeScreenex> createState() => _HomeScreenexState();
}

class _HomeScreenexState extends State<HomeScreenex> {
  // جعلنا الـ index يبدأ بالقيمة المرسلة من الشاشة السابقة
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    // إذا لم نرسل شيئاً سيبدأ من 0 (الهوم)، وإذا أرسلنا 1 سيبدأ من البحث.. وهكذا
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    const HomeContent(),
    const SearchScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: CustomBottomNav(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}
// ─────────────────────────────────────────────────────────────────────────────
class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  void _navigateToDetails(BuildContext context, PlaceModel place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetailsScreen(place: place),
      ),
    );
  }

  /// Smart image widget for both asset and network paths
  Widget _buildSmartImage(String path, {double? height, BoxFit fit = BoxFit.cover}) {
    final isNetwork = path.startsWith('http://') || path.startsWith('https://');
    final widget = isNetwork
        ? Image.network(
      path,
      height: height,
      width: double.infinity,
      fit: fit,
      errorBuilder: (_, __, ___) => _errorBox(height),
    )
        : Image.asset(
      path,
      height: height,
      width: double.infinity,
      fit: fit,
      errorBuilder: (_, __, ___) => _errorBox(height),
    );
    return widget;
  }

  Widget _errorBox(double? height) {
    return Container(
      height: height,
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final popularPlaces = PlacesService.getPopularPlaces();
    final featuredPlace = PlacesService.getAllPlaces().first;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.amber, Color(0xFFFFC107)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'مرحبا بك في الفيوم',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'اكتشف أجمل الأماكن السياحية',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchScreen()),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search, color: Colors.amber),
                          SizedBox(width: 12),
                          Text(
                            'ابحث عن وجهتك...',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Featured Place
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () => _navigateToDetails(context, featuredPlace),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _buildSmartImage(
                        featuredPlace.images.first,
                        height: 220,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(20)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.85)
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              featuredPlace.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 18),
                                const SizedBox(width: 6),
                                Text(
                                  '${featuredPlace.rating} • ${featuredPlace.category}',
                                  style:
                                  const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Popular Places Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'الأماكن الأكثر زيارة',
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AllPlacesScreen()),
                    ),
                    child: const Text('عرض الكل',
                        style: TextStyle(color: Colors.amber)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(right: 20),
                itemCount: popularPlaces.length,
                itemBuilder: (context, index) {
                  return PlaceCard(
                    place: popularPlaces[index],
                    onTap: () =>
                        _navigateToDetails(context, popularPlaces[index]),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
class PlaceCard extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback onTap;

  const PlaceCard({Key? key, required this.place, required this.onTap})
      : super(key: key);

  Widget _buildImage(String path) {
    final isNetwork =
        path.startsWith('http://') || path.startsWith('https://');
    if (isNetwork) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.grey[300],
          child: const Icon(Icons.image_not_supported,
              color: Colors.grey, size: 30),
        ),
      );
    } else {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.grey[300],
          child: const Icon(Icons.image_not_supported,
              color: Colors.grey, size: 30),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              if (place.images.isNotEmpty) _buildImage(place.images.first),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            '${place.rating}',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
class ServicesScreen extends StatelessWidget {
  final PlaceModel place;

  const ServicesScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الخدمات المتاحة في ${place.name}'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: place.services.length,
          itemBuilder: (context, index) {
            final service = place.services[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(service.icon, color: service.color),
                title: Text(service.name),
              ),
            );
          },
        ),
      ),
    );
  }
}