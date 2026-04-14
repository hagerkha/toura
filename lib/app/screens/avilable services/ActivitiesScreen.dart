import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../model/app_model.dart';
import '../../widgits/CustomBottomNav.dart';
import '../homescreenex.dart';

class ActivitiesScreen extends StatefulWidget {
  final PlaceModel place;
  const ActivitiesScreen({Key? key, required this.place}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  int _navIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  late List<Activity> _displayed;

  @override
  void initState() {
    super.initState();
    _displayed = List.from(widget.place.activities);
  }

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => const HomeScreenex()),
              (_) => false);
    } else {
      setState(() => _navIndex = index);
    }
  }

  void _onSearch(String v) {
    setState(() {
      _displayed = widget.place.activities
          .where((a) => a.name.toLowerCase().contains(v.toLowerCase()) ||
          a.description.toLowerCase().contains(v.toLowerCase()))
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
                child: Row(
                  children: [
                    _iconBtn(
                        Icons.arrow_back, () => Navigator.pop(context)),
                    const SizedBox(width: 12),
                    Expanded(child: _searchBar()),
                    const SizedBox(width: 12),
                    _iconBtn(Icons.notifications_none, () {}),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'الأنشطة في ${widget.place.name}',
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
                    child: Text('لا توجد أنشطة',
                        style: TextStyle(color: Colors.grey)))
                    : ListView.builder(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _displayed.length,
                  itemBuilder: (_, i) =>
                      _activityCard(_displayed[i]),
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

  Widget _activityCard(Activity activity) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ActivityDetailsScreen(
                  activity: activity,
                  placeName: widget.place.name))),
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
            // ── صورة النشاط ─────────────────────────
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(20)),
              child: activity.image != null && activity.image!.isNotEmpty
                  ? CachedNetworkImage(
                imageUrl: activity.image!,
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                    height: 170,
                    color: Colors.amber.shade50,
                    child: const Center(child: CircularProgressIndicator(color: Colors.amber, strokeWidth: 2))),
                errorWidget: (_, __, ___) =>
                    _imagePlaceholder(activity.icon),
              )
                  : _imagePlaceholder(activity.icon),
            ),

            // ── تفاصيل النشاط ───────────────────────
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  // أيقونة إيموجي
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14)),
                    child: Center(
                      child: Text(activity.icon,
                          style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(activity.name,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber)),
                        const SizedBox(height: 4),
                        Text(activity.description,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
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

  Widget _imagePlaceholder(String emoji) {
    return Container(
      height: 170,
      width: double.infinity,
      color: Colors.amber.shade50,
      child: Center(
        child: Text(emoji, style: const TextStyle(fontSize: 64)),
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
                    hintText: 'ابحث عن نشاط...',
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
// ActivityDetailsScreen
// ════════════════════════════════════════════
class ActivityDetailsScreen extends StatelessWidget {
  final Activity activity;
  final String placeName;
  const ActivityDetailsScreen(
      {Key? key, required this.activity, required this.placeName})
      : super(key: key);

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
                    child: const Icon(Icons.arrow_back,
                        color: Colors.black)),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: activity.image != null &&
                    activity.image!.isNotEmpty
                    ? CachedNetworkImage(
                    imageUrl: activity.image!,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                        color: Colors.amber.shade50,
                        child: const Center(child: CircularProgressIndicator(color: Colors.amber))),
                    errorWidget: (_, __, ___) => _heroPlaceholder(activity.icon))
                    : _heroPlaceholder(activity.icon),
              ),
            ),

            // ── Body ────────────────────────────────
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30))),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الاسم والإيموجي
                    Row(
                      children: [
                        Text(activity.icon,
                            style: const TextStyle(fontSize: 32)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(activity.name,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // الموقع
                    Row(children: [
                      const Icon(Icons.location_on,
                          color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(placeName,
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 13)),
                    ]),

                    // الوصف
                    const SizedBox(height: 20),
                    const Text('عن النشاط',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(activity.description,
                        style: TextStyle(
                            color: Colors.grey[700],
                            height: 1.7,
                            fontSize: 14)),

                    // ── معلومات إضافية ───────────────
                    const SizedBox(height: 24),
                    const Text('معلومات مفيدة',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _infoChip(Icons.access_time, 'متاح طوال اليوم'),
                        _infoChip(Icons.family_restroom, 'مناسب للعائلات'),
                        _infoChip(Icons.camera_alt, 'مكان رائع للتصوير'),
                        _infoChip(Icons.accessibility_new,
                            'مناسب لجميع الأعمار'),
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

  Widget _heroPlaceholder(String emoji) {
    return Container(
      color: Colors.amber.shade50,
      child: Center(
        child: Text(emoji, style: const TextStyle(fontSize: 80)),
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 15, color: Colors.amber),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ]),
    );
  }
}