import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' show LaunchMode, launchUrl;

import '../model/app_model.dart';
import 'homescreenex.dart';
import 'avilable services/ServicesOverviewScreen.dart';
import 'nav_bar/favourite.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final PlaceModel place;
  const PlaceDetailsScreen({Key? key, required this.place}) : super(key: key);

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  late bool _isFav;

  @override
  void initState() {
    super.initState();
    _isFav = FavoritesHelper.isFavorite(widget.place.name);
  }

  // ── المفضلة ─────────────────────────────────────────────────────
  Future<void> _toggleFavorite() async {
    await FavoritesHelper.toggle(widget.place);
    final newState = FavoritesHelper.isFavorite(widget.place.name);
    if (mounted) {
      setState(() => _isFav = newState);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              newState ? 'تم الإضافة إلى المفضلة ❤️' : 'تم الحذف من المفضلة'),
          backgroundColor: newState ? Colors.redAccent : Colors.grey,
          behavior: SnackBarBehavior.floating,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // ── فتح الخريطة بالرابط المباشر ────────────────────────────────
  Future<void> _openMap() async {
    final String? url = widget.place.googleMapsUrl;

    if (url == null || url.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يوجد موقع متاح لهذا المكان')),
        );
      }
      return;
    }

    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تعذّر فتح الخريطة')),
        );
      }
    }
  }

  // ── الرجوع للصفحة الرئيسية ──────────────────────────────────────
  void _goHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreenex()),
          (route) => false,
    );
  }

  // ── تحويل النص إلى نقاط ─────────────────────────────────────────
  List<String> _parseBullets(String text) {
    return text
        .split('.')
        .map((s) => s.trim())
        .where((s) => s.length > 5)
        .toList();
  }

  // ── عرض الصورة (network أو asset) ───────────────────────────────
  Widget _buildImage(String path) {
    final isNetwork =
        path.startsWith('http://') || path.startsWith('https://');
    if (isNetwork) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: Colors.grey[200],
            child: const Center(
                child: CircularProgressIndicator(color: Colors.amber)),
          );
        },
        errorBuilder: (_, __, ___) => _buildErrorPlaceholder(),
      );
    } else {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (_, __, ___) => _buildErrorPlaceholder(),
      );
    }
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
          child:
          Icon(Icons.image_not_supported, color: Colors.grey, size: 50)),
    );
  }

  // ── البناء الرئيسي ───────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final bullets = _parseBullets(widget.place.description2);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [

            // ── App Bar ──────────────────────────────────────────────
            SliverAppBar(
              expandedHeight: 300,
              floating: false,
              pinned: true,
              backgroundColor: Colors.teal,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.home_rounded, color: Colors.white),
                  onPressed: _goHome,
                ),
                IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      _isFav ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey(_isFav),
                      color: _isFav ? Colors.redAccent : Colors.white,
                    ),
                  ),
                  onPressed: _toggleFavorite,
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.place.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                  ),
                ),
                background: widget.place.images.isEmpty
                    ? _buildErrorPlaceholder()
                    : PageView.builder(
                  itemCount: widget.place.images.length,
                  itemBuilder: (context, index) =>
                      _buildImage(widget.place.images[index]),
                ),
              ),
            ),

            // ── المحتوى ──────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // تقييم + سعر
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${widget.place.rating} • ${widget.place.category}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                        ),
                        Text(
                          widget.place.price,
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      'معلومات عن المكان',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    // النقاط
                    ...bullets.map((point) => _BulletPoint(text: point)),


                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),

        // ── الأزرار السفلية ─────────────────────────────────────────
        bottomSheet: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              )
            ],
          ),
          child: Row(
            children: [
              // زر الخدمات
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.room_service),
                  label: const Text('الخدمات المتاحة'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ServicesOverviewScreen(place: widget.place),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // زر عرض الموقع
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.map),
                  label: const Text('عرض الموقع'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blueAccent,
                    side: const BorderSide(
                        color: Colors.blueAccent, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _openMap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── مكوّن نقطة الوصف ────────────────────────────────────────────────────────
class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Image.asset(
              'assets/images/img.jpeg',
              width: 20,
              height: 20,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.circle, size: 8, color: Colors.amber),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 15, height: 1.4, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}