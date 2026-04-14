
// lib/models/user_model.dart
import 'package:hive/hive.dart';
part 'user_model.g.dart';
@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String phoneNumber;

  @HiveField(3)
  final String password; // مشفر

  @HiveField(4)
  final bool isLoggedIn;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.isLoggedIn = false,
  });

  UserModel copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? password,
    bool? isLoggedIn,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}