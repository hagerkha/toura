import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/app_model.dart';

part 'favourite.g.dart';

// ─── Hive Model ────────────────────────────────────────────────────────────
@HiveType(typeId: 2)
class FavoritePlace extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String location;

  @HiveField(4)
  final double rating;

  @HiveField(5)
  final String price;

  @HiveField(6)
  final String imageUrl;

  FavoritePlace({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.rating,
    required this.price,
    required this.imageUrl,
  });
}

// ─── Helper ────────────────────────────────────────────────────────────────
class FavoritesHelper {
  static const _boxName = 'favoritesBox';

  static Box<FavoritePlace> get _box => Hive.box<FavoritePlace>(_boxName);

  static bool isFavorite(String placeId) => _box.containsKey(placeId);

  static Future<void> toggle(PlaceModel place) async {
    final key = place.name;
    if (_box.containsKey(key)) {
      await _box.delete(key);
    } else {
      await _box.put(
        key,
        FavoritePlace(
          id: key,
          name: place.name,
          category: place.category,
          location: place.location,
          rating: place.rating,
          price: place.price,
          imageUrl: place.images.isNotEmpty ? place.images.first : '',
        ),
      );
    }
  }

  static List<FavoritePlace> getAll() => _box.values.toList();
}

// ─── FavoritesScreen ───────────────────────────────────────────────────────
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text(
            'المفضلة',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: ValueListenableBuilder(
          valueListenable:
          Hive.box<FavoritePlace>('favoritesBox').listenable(),
          builder: (context, Box<FavoritePlace> box, _) {
            final favorites = box.values.toList();

            if (favorites.isEmpty) {
              return _buildEmptyState();
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final fav = favorites[index];
                return _FavoriteCard(
                  favorite: fav,
                  onRemove: () async {
                    await box.delete(fav.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم حذف "${fav.name}" من المفضلة'),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.amber.shade300),
          const SizedBox(height: 16),
          const Text(
            'قائمة المفضلة فارغة',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'أضف أماكنك المفضلة بالضغط على ❤️',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

// ─── FavoriteCard (تم التعديل ليدعم الـ Assets) ──────────────────────────────
class _FavoriteCard extends StatelessWidget {
  final FavoritePlace favorite;
  final VoidCallback onRemove;

  const _FavoriteCard({required this.favorite, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          // صورة المكان - تم التغيير لـ Image.asset ✅
          ClipRRect(
            borderRadius:
            const BorderRadius.horizontal(right: Radius.circular(20)),
            child: Image.asset(
              favorite.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 100,
                height: 100,
                color: Colors.amber.shade100,
                child: const Icon(Icons.image_not_supported,
                    color: Colors.amber, size: 36),
              ),
            ),
          ),

          // المعلومات
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    favorite.name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 13, color: Colors.grey),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          favorite.location,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 13, color: Colors.amber),
                      const SizedBox(width: 3),
                      Text(
                        favorite.rating.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      Flexible(
                        child: Text(
                          '${favorite.price} ج.م',
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
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

          // زر الحذف
          SizedBox(
            width: 40,
            child: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.redAccent, size: 22),
              onPressed: onRemove,
              padding: EdgeInsets.zero,
              tooltip: 'إزالة من المفضلة',
            ),
          ),
        ],
      ),
    );
  }
}