import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPlaceholderScreen extends StatelessWidget {
  final String placeName;
  final double latitude;
  final double longitude;

  const MapPlaceholderScreen({
    super.key,
    required this.placeName,
    required this.latitude,
    required this.longitude,
  });

  /// يفتح Google Maps على الجوال مباشرة بخطوط الطول ودوائر العرض
  Future<void> _openGoogleMaps() async {
    // يحاول يفتح تطبيق Google Maps الأصلي أولاً
    final Uri googleMapsApp = Uri.parse(
      'geo:$latitude,$longitude?q=$latitude,$longitude($placeName)',
    );

    // إذا ما اشتغل يفتح الموقع في المتصفح
    final Uri googleMapsWeb = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );

    if (await canLaunchUrl(googleMapsApp)) {
      await launchUrl(googleMapsApp);
    } else if (await canLaunchUrl(googleMapsWeb)) {
      await launchUrl(googleMapsWeb, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final LatLng center = LatLng(latitude, longitude);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('موقع $placeName'),
          centerTitle: true,
          backgroundColor: Colors.amber,
          foregroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            // ── الخريطة ──────────────────────────────────────────
            FlutterMap(
              options: MapOptions(
                initialCenter: center,
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: center,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // ── بطاقة المعلومات + زر فتح Google Maps ─────────────
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم المكان
                    Row(
                      children: [
                        const Icon(Icons.place, color: Colors.red, size: 22),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            placeName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // الإحداثيات
                    Text(
                      'خط العرض: ${latitude.toStringAsFixed(6)}',
                      style:
                      TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                    Text(
                      'خط الطول: ${longitude.toStringAsFixed(6)}',
                      style:
                      TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),

                    const SizedBox(height: 14),

                    // زر فتح Google Maps
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _openGoogleMaps,
                        icon: const Icon(Icons.map_rounded, size: 20),
                        label: const Text(
                          'فتح في Google Maps',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.white,
                          padding:
                          const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}