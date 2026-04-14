import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/app_model.dart';
import '../../widgits/CustomBottomNav.dart';
import '../homescreenex.dart';

class ContactsScreen extends StatefulWidget {
  final PlaceModel place;
  const ContactsScreen({Key? key, required this.place}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  int _navIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  late List<Contact> _displayed;

  @override
  void initState() {
    super.initState();
    _displayed = List.from(widget.place.contacts);
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
      _displayed = widget.place.contacts
          .where((c) =>
      c.type.toLowerCase().contains(v.toLowerCase()) ||
          c.value.toLowerCase().contains(v.toLowerCase()))
          .toList();
    });
  }

  // ── launchers ────────────────────────────────────
  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _handleTap(Contact contact) async {
    final v = contact.value.trim();
    final t = contact.type.toLowerCase();

    if (t.contains('هاتف') || t.contains('موبايل') || t.contains('phone')) {
      // نأخذ أول رقم لو في أرقام متعددة
      final first = v.split(RegExp(r'[–\-]')).first.trim();
      await _launch('tel:$first');
    } else if (t.contains('واتس') || t.contains('whatsapp')) {
      final cleaned = v.replaceAll(RegExp(r'[^0-9+]'), '');
      await _launch('https://wa.me/$cleaned');
    } else if (t.contains('فيسبوك') || t.contains('facebook')) {
      final url = v.startsWith('http') ? v : 'https://$v';
      await _launch(url);
    } else if (t.contains('إنستغرام') || t.contains('انستغرام') || t.contains('instagram')) {
      final url = v.startsWith('http')
          ? v
          : 'https://instagram.com/${v.replaceAll('@', '')}';
      await _launch(url);
    } else if (t.contains('بريد') || t.contains('email') || v.contains('@')) {
      await _launch('mailto:$v');
    } else if (t.contains('موقع') || t.contains('website') || v.startsWith('http')) {
      final url = v.startsWith('http') ? v : 'https://$v';
      await _launch(url);
    }
  }

  // لون بناءً على نوع التواصل
  Color _contactColor(String type) {
    final t = type.toLowerCase();
    if (t.contains('هاتف') || t.contains('موبايل')) return Colors.green;
    if (t.contains('واتس')) return const Color(0xFF25D366);
    if (t.contains('فيسبوك') || t.contains('facebook')) return const Color(0xFF1877F2);
    if (t.contains('إنستغرام') || t.contains('انستغرام')) return Colors.pink;
    if (t.contains('بريد') || t.contains('email')) return Colors.deepOrange;
    if (t.contains('موقع') || t.contains('website')) return Colors.blueAccent;
    return Colors.teal;
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
                    _iconBtn(Icons.arrow_back,
                            () => Navigator.pop(context)),
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
                  'جهات التواصل – ${widget.place.name}',
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
                    child: Text('لا توجد جهات تواصل',
                        style: TextStyle(color: Colors.grey)))
                    : ListView.builder(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _displayed.length,
                  itemBuilder: (_, i) =>
                      _contactCard(_displayed[i]),
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

  Widget _contactCard(Contact contact) {
    final color = _contactColor(contact.type);
    return GestureDetector(
      onTap: () => _handleTap(contact),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // أيقونة ملونة
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14)),
                child: Icon(contact.icon, color: color, size: 26),
              ),
              const SizedBox(width: 14),

              // النوع والقيمة
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contact.type,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text(contact.value,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: color)),
                  ],
                ),
              ),

              // سهم للفتح
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.open_in_new,
                    color: color.withOpacity(0.7), size: 18),
              ),
            ],
          ),
        ),
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
                    hintText: 'ابحث في جهات التواصل...',
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