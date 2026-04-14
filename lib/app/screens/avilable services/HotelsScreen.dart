import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/app_model.dart';
import '../../widgits/CustomBottomNav.dart';
import '../homescreenex.dart';

class HotelsScreen extends StatefulWidget {
  final PlaceModel place;
  const HotelsScreen({Key? key, required this.place}) : super(key: key);

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  int _navIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  late List<Hotel> _displayed;

  @override
  void initState() {
    super.initState();
    _displayed = List.from(widget.place.nearbyHotels);
  }

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => const HomeScreenex()), (_) => false);
    } else {
      setState(() => _navIndex = index);
    }
  }

  void _onSearch(String v) {
    setState(() {
      _displayed = widget.place.nearbyHotels
          .where((h) => h.name.toLowerCase().contains(v.toLowerCase()))
          .toList();
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
                        _iconBtn(
                            Icons.arrow_back, () => Navigator.pop(context)),
                        const SizedBox(width: 12),
                        Expanded(child: _searchBar()),
                        const SizedBox(width: 12),
                        _iconBtn(Icons.notifications_none, () {}),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _displayed
                              .sort((a, b) => b.rating.compareTo(a.rating));
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('ترتيب حسب الجودة',
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                            SizedBox(width: 6),
                            Icon(Icons.sort, size: 16, color: Colors.amber),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'الفنادق القريبة من ${widget.place.name}',
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
                    child: Text('لا توجد فنادق',
                        style: TextStyle(color: Colors.grey)))
                    : ListView.builder(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _displayed.length,
                  itemBuilder: (_, i) => _hotelCard(_displayed[i]),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:
        CustomBottomNav(currentIndex: _navIndex, onTap: _onNavTap),
      ),
    );
  }

  Widget _hotelCard(Hotel hotel) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => HotelDetailsScreen(
                  hotel: hotel, placeName: widget.place.name))),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                children: [
                  CachedNetworkImage(
                      imageUrl: hotel.image,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                          height: 180,
                          color: Colors.amber.shade50,
                          child: const Center(child: CircularProgressIndicator(color: Colors.amber, strokeWidth: 2))),
                      errorWidget: (_, __, ___) => Container(
                          height: 180,
                          color: Colors.amber.shade100,
                          child: const Icon(Icons.hotel,
                              color: Colors.amber, size: 60))),
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
                        Text(hotel.rating.toString(),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hotel.name,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber)),
                  const SizedBox(height: 6),
                  Row(children: [
                    Row(
                        children: List.generate(
                            5,
                                (i) => Icon(
                                i < hotel.rating.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 15,
                                color: Colors.amber))),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text('${hotel.pricePerNight} ج.م / ليلة',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Row(children: [
        Expanded(
            child: TextField(
                controller: _searchController,
                onChanged: _onSearch,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                    hintText: 'ابحث عن فندق...',
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
// HotelDetailsScreen
// ════════════════════════════════════════════
class HotelDetailsScreen extends StatelessWidget {
  final Hotel hotel;
  final String placeName;
  const HotelDetailsScreen(
      {Key? key, required this.hotel, required this.placeName})
      : super(key: key);

  // ── helpers ──────────────────────────────
  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _call(String phone) async {
    // دعم أرقام متعددة مفصولة بـ " – " – نأخذ الأول
    final first = phone.split(RegExp(r'[–\-]')).first.trim();
    await _launch('tel:$first');
  }

  Future<void> _openInstagram(String url) async {
    // قد يكون رابط كامل أو مجرد معرّف @...
    final link = url.startsWith('http') ? url : 'https://instagram.com/${url.replaceAll('@', '')}';
    await _launch(link);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF8E1),
        body: CustomScrollView(
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
                    child: const Icon(Icons.arrow_back, color: Colors.black)),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                    imageUrl: hotel.image,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                        color: Colors.amber.shade50,
                        child: const Center(child: CircularProgressIndicator(color: Colors.amber))),
                    errorWidget: (_, __, ___) => Container(
                        color: Colors.amber.shade100,
                        child: const Icon(Icons.hotel,
                            size: 80, color: Colors.amber))),
              ),
            ),

            // ── Body ────────────────────────────────
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30))),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── الاسم والتقييم ───────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(hotel.name,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold))),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(hotel.rating.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ]),
                        ),
                      ],
                    ),

                    // ── المسافة ─────────────────────
                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Icons.location_on,
                          color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(hotel.distance,
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 13)),
                    ]),

                    // ── الوصف ────────────────────────
                    if (hotel.description.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      _sectionTitle('عن الفندق'),
                      const SizedBox(height: 8),
                      Text(hotel.description,
                          style: TextStyle(
                              color: Colors.grey[700],
                              height: 1.6,
                              fontSize: 14)),
                    ],

                    // ── صور إضافية ───────────────────
                    if (hotel.images.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      _sectionTitle('صور من الفندق'),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 130,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: hotel.images.length,
                          separatorBuilder: (_, __) =>
                          const SizedBox(width: 10),
                          itemBuilder: (_, i) => ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: hotel.images[i],
                              width: 180,
                              height: 130,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Container(
                                  width: 180,
                                  color: Colors.amber.shade50,
                                  child: const Center(child: CircularProgressIndicator(color: Colors.amber, strokeWidth: 2))),
                              errorWidget: (_, __, ___) => Container(
                                  width: 180,
                                  color: Colors.amber.shade100,
                                  child: const Icon(Icons.image,
                                      color: Colors.amber)),
                            ),
                          ),
                        ),
                      ),
                    ],

                    // ── رقم الهاتف ───────────────────
                    if (hotel.phone != null &&
                        hotel.phone!.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      _sectionTitle('التواصل'),
                      const SizedBox(height: 12),
                      _contactTile(
                        icon: Icons.phone,
                        color: Colors.green,
                        label: hotel.phone!,
                        onTap: () => _call(hotel.phone!),
                      ),
                    ],

                    // ── إنستغرام ─────────────────────
                    if (hotel.instagramUrl != null &&
                        hotel.instagramUrl!.isNotEmpty) ...[
                      if (hotel.phone == null || hotel.phone!.isEmpty) ...[
                        const SizedBox(height: 24),
                        _sectionTitle('التواصل'),
                      ],
                      const SizedBox(height: 10),
                      _contactTile(
                        icon: Icons.camera_alt,
                        color: Colors.pink,
                        label: hotel.instagramUrl!,
                        onTap: () => _openInstagram(hotel.instagramUrl!),
                      ),
                    ],

                    // ── المرافق ──────────────────────
                    const SizedBox(height: 24),
                    _sectionTitle('المرافق'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _amenity(Icons.wifi, 'واي فاي مجاني'),
                        _amenity(Icons.pool, 'مسبح'),
                        _amenity(Icons.restaurant, 'مطعم'),
                        _amenity(Icons.fitness_center, 'صالة رياضية'),
                        _amenity(Icons.local_parking, 'موقف سيارات'),
                        _amenity(Icons.room_service, 'خدمة الغرف'),
                      ],
                    ),

                    // ── السعر والحجز ─────────────────
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('السعر لليلة',
                                    style:
                                    TextStyle(color: Colors.grey[600])),
                                Text('${hotel.pricePerNight} ج.م',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber)),
                              ],
                            )),
                        Expanded(
                            child: ElevatedButton(
                              onPressed: () =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('تم الحجز بنجاح!'),
                                          backgroundColor: Colors.green)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(12))),
                              child: const Text('احجز الآن',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            )),
                      ],
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Reusable widgets ─────────────────────────

  Widget _sectionTitle(String text) {
    return Text(text,
        style:
        const TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
  }

  /// بطاقة تواصل (هاتف أو إنستغرام) بنفس ستايل الـ amenities
  Widget _contactTile({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.25))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 8),
            Flexible(
              child: Text(label,
                  style: TextStyle(
                      fontSize: 13,
                      color: color,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 8),
            Icon(Icons.open_in_new, size: 14, color: color.withOpacity(0.6)),
          ],
        ),
      ),
    );
  }

  Widget _amenity(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 16, color: Colors.amber),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ]),
    );
  }
}