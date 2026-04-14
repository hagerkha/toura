// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritePlaceAdapter extends TypeAdapter<FavoritePlace> {
  @override
  final int typeId = 2;

  @override
  FavoritePlace read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoritePlace(
      id: fields[0] as String,
      name: fields[1] as String,
      category: fields[2] as String,
      location: fields[3] as String,
      rating: fields[4] as double,
      price: fields[5] as String,
      imageUrl: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoritePlace obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritePlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
