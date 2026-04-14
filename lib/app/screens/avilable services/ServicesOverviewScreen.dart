import 'package:flutter/material.dart';
import '../../model/app_model.dart';
import '../../widgits/CustomBottomNav.dart';
import '../homescreenex.dart';
import 'RestaurantsScreen.dart';
import 'HotelsScreen.dart';
import 'ActivitiesScreen.dart';
import 'ContactsScreen.dart';
import 'videos.dart';

class ServicesOverviewScreen extends StatefulWidget {
  final PlaceModel place;

  const ServicesOverviewScreen({super.key, required this.place});

  @override
  State<ServicesOverviewScreen> createState() =>
      _ServicesOverviewScreenState();
}

class _ServicesOverviewScreenState extends State<ServicesOverviewScreen> {
  int _selectedTab = 0;
  int _navIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      if (mounted) {
        setState(
                () => _searchQuery = _searchController.text.trim().toLowerCase());
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // دالة التعامل مع شريط التنقل السفلي
  void _onNavTap(int index) {
    // سيقوم بحذف كل الصفحات المفتوحة والعودة للهوم
    // مع فتح الصفحة (بحث أو مفضلة أو بروفايل) بناءً على الـ index
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreenex(initialIndex: index),
      ),
          (route) => false,
    );
  }

  void _openGeneralVideos() {
    final generalVideos = widget.place.videos['general'] ?? [];
    if (generalVideos.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ServiceVideosScreen(
            title: 'الفيديوهات العامة',
            videos: generalVideos,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا توجد فيديوهات متاحة حالياً')),
      );
    }
  }

  bool _matchesSearch(String text) {
    if (_searchQuery.isEmpty) return true;
    return text.toLowerCase().contains(_searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF8E1),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _buildBackButton(),
                          const SizedBox(width: 12),
                          Expanded(child: _buildSearchField()),
                          const SizedBox(width: 12),
                          _buildNotificationButton(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTabBar(),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'خدمات ${widget.place.name}',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(_buildFilteredCards()),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNav(
          currentIndex: _navIndex,
          onTap: _onNavTap,
        ),
      ),
    );
  }

  // ── Header widgets ────────────────────────────────────────────────────────

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.35),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.35),
        borderRadius: BorderRadius.circular(12),
      ),
      child:
      const Icon(Icons.notifications_none, color: Colors.white, size: 26),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                hintText: 'ابحث في الخدمات...',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const Icon(Icons.search, color: Colors.amber, size: 22),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = [
      ('الكل', Icons.apps, 0),
      ('مطاعم', Icons.restaurant, 1),
      ('فنادق', Icons.hotel, 2),
      ('أنشطة', Icons.directions_run, 3),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: tabs.map((tab) {
        final isSelected = _selectedTab == tab.$3;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTab = tab.$3),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tab.$1,
                    style: TextStyle(
                      color: isSelected ? Colors.amber[800] : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(tab.$2,
                      size: 19,
                      color: isSelected ? Colors.amber[800] : Colors.white),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Cards ─────────────────────────────────────────────────────────────────

  List<Widget> _buildFilteredCards() {
    final cards = <Widget>[];

    // مطاعم
    if (_selectedTab == 0 || _selectedTab == 1) {
      if (_matchesSearch('مطاعم')) {
        final count = widget.place.nearbyRestaurants.length;
        cards.add(_buildServiceCard(
          title: 'المطاعم القريبة',
          subtitle: '$count مطعم متاح',
          icon: Icons.restaurant,
          color: Colors.deepOrange,
          imageUrl: count > 0 ? widget.place.nearbyRestaurants.first.image : null,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RestaurantsScreen(place: widget.place)),
          ),
        ));
      }
    }

    // فنادق
    if (_selectedTab == 0 || _selectedTab == 2) {
      if (_matchesSearch('فنادق')) {
        final count = widget.place.nearbyHotels.length;
        cards.add(_buildServiceCard(
          title: 'الفنادق والإقامة',
          subtitle: '$count خيار إقامة',
          icon: Icons.hotel,
          color: Colors.blueAccent,
          imageUrl: count > 0 ? widget.place.nearbyHotels.first.image : null,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => HotelsScreen(place: widget.place)),
          ),
        ));
      }
    }

    // أنشطة
    if (_selectedTab == 0 || _selectedTab == 3) {
      if (_matchesSearch('أنشطة')) {
        final count = widget.place.activities.length;
        final firstImage = count > 0 ? (widget.place.activities.first.image ?? '') : '';
        cards.add(_buildServiceCard(
          title: 'الأنشطة والترفيه',
          subtitle: '$count نشاط متاح',
          icon: Icons.directions_run,
          color: Colors.green[700]!,
          imageUrl: firstImage.isNotEmpty ? firstImage : null,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ActivitiesScreen(place: widget.place)),
          ),
        ));
      }
    }

    // جهات تواصل
    if (_selectedTab == 0) {
      if (_matchesSearch('تواصل')) {
        final count = widget.place.contacts.length;
        cards.add(_buildServiceCard(
          title: 'جهات التواصل',
          subtitle: '$count وسيلة تواصل',
          icon: Icons.contact_mail,
          color: Colors.teal[600]!,
          imageUrl: null,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ContactsScreen(place: widget.place)),
          ),
        ));
      }
    }

    // فيديوهات
    final generalVideos = widget.place.videos['general'] ?? [];
    if (generalVideos.isNotEmpty &&
        (_selectedTab == 0 || _matchesSearch('فيديو'))) {
      cards.add(_buildVideoCard(generalVideos.length));
    }

    if (cards.isEmpty) {
      cards.add(
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: Text('لا توجد نتائج مطابقة',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
          ),
        ),
      );
    }

    return cards;
  }

  Widget _buildServiceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    String? imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            if (imageUrl != null && imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: (imageUrl.startsWith('http') || imageUrl.startsWith('https'))
                    ? Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _imageFallback(color, icon),
                )
                    : Image.asset( // يدعم الـ Assets الآن
                  imageUrl,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _imageFallback(color, icon),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: color, size: 34),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text(subtitle,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[700])),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.grey[400], size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageFallback(Color color, IconData icon) {
    return Container(
      height: 150,
      color: color.withOpacity(0.15),
      child: Center(child: Icon(icon, color: color, size: 70)),
    );
  }

  Widget _buildVideoCard(int count) {
    return GestureDetector(
      onTap: _openGeneralVideos,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Container(
                width: double.infinity,
                height: 150,
                color: Colors.grey[900],
                child: const Center(
                  child: Icon(Icons.play_circle_fill_rounded,
                      color: Colors.amber, size: 80),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.videocam_rounded,
                        color: Colors.amber, size: 34),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('فيديوهات المكان',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text('$count فيديو متاح',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[700])),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.grey[400], size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}