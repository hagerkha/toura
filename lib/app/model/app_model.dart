import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlaceModel {
  final String id;
  final String name;
  final String location;
  final List<String> images;
  final double rating;
  final String price;
  final String description;
  final String description2;
  final String category;
  final double latitude;
  final double longitude;
  final String? googleMapsUrl; // ← رابط Google Maps المباشر
  final List<Restaurant> nearbyRestaurants;
  final List<Hotel> nearbyHotels;
  final List<Activity> activities;
  final List<ServiceItem> services;
  final List<Contact> contacts;
  final Map<String, List<String>> videos;

  PlaceModel({
    required this.id,
    required this.name,
    required this.location,
    required this.images,
    required this.rating,
    required this.price,
    required this.description,
    required this.description2,
    required this.category,
    required this.latitude,
    required this.longitude,
    this.googleMapsUrl,
    required this.nearbyRestaurants,
    required this.nearbyHotels,
    required this.activities,
    required this.services,
    required this.contacts,
    this.videos = const {},
  });
}

// ✅ Restaurant مع رقم هاتف اختياري
class Restaurant {
  final String name;
  final String distance;
  final double rating;
  final String image;
  final String? phone;

  Restaurant({
    required this.name,
    required this.distance,
    required this.rating,
    required this.image,
    this.phone,
  });
}

// ✅ Hotel مع قائمة صور ووصف ورقم هاتف وإنستغرام
class Hotel {
  final String name;
  final String distance;
  final double rating;
  final String pricePerNight;
  final String image;
  final List<String> images;
  final String description;
  final String? phone;
  final String? instagramUrl;

  Hotel({
    required this.name,
    required this.distance,
    required this.rating,
    required this.pricePerNight,
    required this.image,
    this.images = const [],
    this.description = '',
    this.phone,
    this.instagramUrl,
  });
}

// ✅ Activity مع صورة
class Activity {
  final String name;
  final String icon;
  final String description;
  final String? image;

  Activity({
    required this.name,
    required this.icon,
    required this.description,
    this.image,
  });
}

// ✅ ServiceItem مع صورة
class ServiceItem {
  final IconData icon;
  final String name;
  final Color color;
  final String? image;

  ServiceItem({
    required this.icon,
    required this.name,
    required this.color,
    this.image,
  });
}

// ✅ Contact مع صورة
class Contact {
  final String type;
  final String value;
  final IconData icon;
  final String? image;

  Contact({
    required this.type,
    required this.value,
    required this.icon,
    this.image,
  });
}

// ================= Booking (Hive) =================
@HiveType(typeId: 0)
class Booking extends HiveObject {
  @HiveField(0)
  final String placeId;
  @HiveField(1)
  final String placeName;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final String time;
  @HiveField(4)
  final int numberOfPeople;
  @HiveField(5)
  final String price;

  Booking({
    required this.placeId,
    required this.placeName,
    required this.date,
    required this.time,
    required this.numberOfPeople,
    required this.price,
  });
}

class BookingAdapter extends TypeAdapter<Booking> {
  @override
  final int typeId = 0;

  @override
  Booking read(BinaryReader reader) => Booking(
    placeId: reader.readString(),
    placeName: reader.readString(),
    date: reader.readString(),
    time: reader.readString(),
    numberOfPeople: reader.readInt(),
    price: reader.readString(),
  );

  @override
  void write(BinaryWriter writer, Booking obj) {
    writer.writeString(obj.placeId);
    writer.writeString(obj.placeName);
    writer.writeString(obj.date);
    writer.writeString(obj.time);
    writer.writeInt(obj.numberOfPeople);
    writer.writeString(obj.price);
  }
}