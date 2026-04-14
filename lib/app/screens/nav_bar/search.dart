import 'package:flutter/material.dart';
import '../../model/app_model.dart';
import '../../services/PlacesService.dart';
import '../PlaceDetailsScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<PlaceModel> _searchResults = [];
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    // عرض كل الأماكن في البداية
    _searchResults = PlacesService.getAllPlaces();
    _searchController.addListener(() {
      _performSearch(_searchController.text);
    });
  }

  void _performSearch(String query) {
    setState(() {
      _hasSearched = query.isNotEmpty;
      _searchResults = PlacesService.searchPlaces(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text(
            'البحث',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            // ─── شريط البحث ───────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              color: Colors.amber,
              child: TextField(
                controller: _searchController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'ابحث عن وجهة، مكان، نشاط...',
                  hintStyle: const TextStyle(fontSize: 14),
                  prefixIcon: const Icon(Icons.search, color: Colors.amber),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      _performSearch('');
                    },
                  )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // ─── النتائج ──────────────────────────────────────────────
            Expanded(
              child: _searchResults.isEmpty && _hasSearched
                  ? _buildEmptyState()
                  : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final place = _searchResults[index];
                  return _SearchCard(place: place);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on_outlined,
              size: 64, color: Colors.amber.shade300),
          const SizedBox(height: 16),
          const Text(
            'هذا المكان غير متاح حالياً',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            'سيتم إضافته قريباً في التحديثات القادمة',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 20),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.construction,
                    size: 16, color: Colors.amber.shade700),
                const SizedBox(width: 6),
                Text(
                  'قيد التطوير',
                  style: TextStyle(
                      color: Colors.amber.shade700,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── كارد نتيجة البحث (تم التعديل ليدعم الـ Assets) ──────────────────────────
class _SearchCard extends StatelessWidget {
  final PlaceModel place;

  const _SearchCard({required this.place});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PlaceDetailsScreen(place: place),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // صورة المكان (استخدام Image.asset بدلاً من Image.network)
            ClipRRect(
              borderRadius:
              const BorderRadius.horizontal(right: Radius.circular(14)),
              child: Image.asset(
                place.images.first, // التأكد أن المسار يبدأ بـ assets/
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 90,
                  height: 90,
                  color: Colors.amber.shade100,
                  child: const Icon(Icons.image_not_supported,
                      color: Colors.amber, size: 36),
                ),
              ),
            ),

            // المعلومات
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.category_outlined,
                            size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            place.category,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            size: 13, color: Colors.amber),
                        const SizedBox(width: 3),
                        Text(
                          place.rating.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Spacer(),
                        Flexible(
                          child: Text(
                            '${place.price} ج.م',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.arrow_forward_ios,
                  size: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}