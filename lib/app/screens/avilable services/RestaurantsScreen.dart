import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/app_model.dart';

class RestaurantsScreen extends StatefulWidget {
  final PlaceModel place;
  const RestaurantsScreen({Key? key, required this.place}) : super(key: key);

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  int _selectedSort = 0;
  final TextEditingController _searchController = TextEditingController();
  late List<Restaurant> _displayed;

  @override
  void initState() {
    super.initState();
    _displayed = _sorted(0, widget.place.nearbyRestaurants);
  }

  List<Restaurant> _sorted(int mode, List<Restaurant> src) {
    final list = List<Restaurant>.from(src);
    if (mode == 0) list.sort((a, b) => b.rating.compareTo(a.rating));
    if (mode == 1) list.sort((a, b) => a.distance.compareTo(b.distance));
    return list;
  }

  void _onSearch(String v) {
    final src = widget.place.nearbyRestaurants;
    final filtered = src
        .where((r) => r.name.toLowerCase().contains(v.toLowerCase()))
        .toList();
    setState(() => _displayed = _sorted(_selectedSort, filtered));
  }

  void _onSort(int mode) {
    setState(() {
      _selectedSort = mode;
      _displayed = _sorted(mode, _displayed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF8E1),
        body: SafeArea(
          child: Column(
            children: [
              // ── Header ──────────────────────────────────
              Container(
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
                        _iconBtn(Icons.arrow_back,
                                () => Navigator.pop(context)),
                        const SizedBox(width: 12),
                        Expanded(child: _searchBar()),
                        const SizedBox(width: 12),
                        _iconBtn(Icons.notifications_none, () {}),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                            child: _sortBtn(
                                'ترتيب حسب الجودة', Icons.sort, 0)),
                        const SizedBox(width: 8),
                        Expanded(
                            child: _sortBtn('ترتيب حسب الأقرب',
                                Icons.location_on, 1)),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'المطاعم القريبة من ${widget.place.name}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                  textAlign: TextAlign.center,
                ),
              ),

              Expanded(
                child: _displayed.isEmpty
                    ? const Center(
                    child: Text('لا توجد مطاعم',
                        style: TextStyle(color: Colors.grey)))
                    : ListView.builder(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _displayed.length,
                  itemBuilder: (_, i) =>
                      _restaurantCard(_displayed[i]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _restaurantCard(Restaurant r) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => RestaurantDetailsScreen(
                  restaurant: r, placeName: widget.place.name))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: r.image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      height: 180,
                      color: Colors.amber.shade50,
                      child: const Center(child: CircularProgressIndicator(color: Colors.amber, strokeWidth: 2)),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      height: 180,
                      color: Colors.amber.shade100,
                      child: const Icon(Icons.restaurant,
                          size: 60, color: Colors.amber),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(children: [
                        const Icon(Icons.star,
                            size: 14, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(r.rating.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r.name,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber)),
                        const SizedBox(height: 4),
                        Text('على بُعد ${r.distance}',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13)),
                        // ── معاينة رقم الهاتف في البطاقة ──
                        if (r.phone != null && r.phone!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Row(children: [
                            const Icon(Icons.phone,
                                size: 13, color: Colors.green),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(r.phone!,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.green),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ]),
                        ],
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      color: Colors.amber, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sortBtn(String title, IconData icon, int index) {
    final selected = _selectedSort == index;
    return GestureDetector(
      onTap: () => _onSort(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color:
          selected ? Colors.white : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: TextStyle(
                      color: selected ? Colors.amber : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              Icon(icon,
                  size: 14,
                  color: selected ? Colors.amber : Colors.white),
            ]),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25)),
      child: Row(children: [
        Expanded(
            child: TextField(
                controller: _searchController,
                onChanged: _onSearch,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                    hintText: 'ابحث عن مطعم...',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero),
                style: const TextStyle(fontSize: 14))),
        const Icon(Icons.search, color: Colors.amber, size: 20),
      ]),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// ════════════════════════════════════════════
// RestaurantDetailsScreen
// ════════════════════════════════════════════
class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;
  final String placeName;
  const RestaurantDetailsScreen(
      {Key? key, required this.restaurant, required this.placeName})
      : super(key: key);

  Future<void> _call(String phone) async {
    final first = phone.split(RegExp(r'[–\-]')).first.trim();
    final uri = Uri.parse('tel:$first');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF8E1),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // ── AppBar ──────────────────────────────
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    backgroundColor: Colors.amber,
                    leading: IconButton(
                      icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_back,
                              color: Colors.black)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: CachedNetworkImage(
                        imageUrl: restaurant.image,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                            color: Colors.amber.shade50,
                            child: const Center(child: CircularProgressIndicator(color: Colors.amber))),
                        errorWidget: (_, __, ___) => Container(
                            color: Colors.amber.shade100,
                            child: const Icon(Icons.restaurant,
                                size: 80, color: Colors.amber)),
                      ),
                    ),
                  ),

                  // ── Body ────────────────────────────────
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // الاسم
                          Text(restaurant.name,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber)),
                          const SizedBox(height: 8),

                          // الموقع
                          Row(children: [
                            const Icon(Icons.location_on,
                                color: Colors.amber, size: 16),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Text(
                                    'بالقرب من $placeName – ${restaurant.distance}',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13))),
                          ]),
                          const SizedBox(height: 12),

                          // التقييم
                          Row(
                              children: List.generate(
                                  5,
                                      (i) => Icon(
                                      i < restaurant.rating.floor()
                                          ? Icons.star
                                          : Icons.star_border,
                                      size: 18,
                                      color: Colors.amber))),

                          // ── رقم الهاتف ───────────────────
                          if (restaurant.phone != null &&
                              restaurant.phone!.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            const Text('التواصل',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () => _call(restaurant.phone!),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                                decoration: BoxDecoration(
                                    color:
                                    Colors.green.withOpacity(0.08),
                                    borderRadius:
                                    BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.green
                                            .withOpacity(0.25))),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.phone,
                                        size: 18, color: Colors.green),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Text(restaurant.phone!,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.green,
                                              fontWeight:
                                              FontWeight.w600)),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(Icons.open_in_new,
                                        size: 14,
                                        color: Colors.green
                                            .withOpacity(0.6)),
                                  ],
                                ),
                              ),
                            ),
                          ],

                          // ── عن المطعم ────────────────────
                          const SizedBox(height: 20),
                          const Text('عن المطعم',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          const Text(
                            'نقدم لكم تجربة طعام فريدة تجمع بين النكهات التقليدية المصرية واللمسات العصرية. استمتع بأجواء رائعة وخدمة متميزة في قلب المنطقة السياحية.',
                            style: TextStyle(
                                height: 1.6, color: Colors.black87),
                          ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── زر الحجز ────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 10)
                  ]),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding:
                      const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () =>
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(children: [
                            const Icon(Icons.check_circle,
                                color: Colors.white),
                            const SizedBox(width: 10),
                            Text(
                                'تم تأكيد حجزك في ${restaurant.name} بنجاح!'),
                          ]),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                  child: const Text('احجز طاولتك الآن',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}