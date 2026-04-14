import 'package:hive_flutter/hive_flutter.dart';
import '../model/user_model.dart';

class HiveService {
  static const String _userBoxName = 'userBox';
  static const String _currentUserKey = 'currentUser';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>(_userBoxName);
  }

  // ✅ حذفنا hashPassword خالص

  Future<Map<String, dynamic>> register(UserModel user) async {
    try {
      final box = Hive.box<UserModel>(_userBoxName);

      final existingUser = box.values.firstWhere(
            (u) => u.email == user.email,
        orElse: () => UserModel(
          fullName: '', email: '', phoneNumber: '', password: '',
        ),
      );

      if (existingUser.email.isNotEmpty) {
        return {'success': false, 'error': 'البريد الإلكتروني مسجل بالفعل'};
      }

      final existingPhone = box.values.firstWhere(
            (u) => u.phoneNumber == user.phoneNumber,
        orElse: () => UserModel(
          fullName: '', email: '', phoneNumber: '', password: '',
        ),
      );

      if (existingPhone.phoneNumber.isNotEmpty) {
        return {'success': false, 'error': 'رقم الهاتف مسجل بالفعل'};
      }

      // ✅ بنحفظ الباسورد عادي من غير تشفير
      final newUser = UserModel(
        fullName: user.fullName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        password: user.password,
        isLoggedIn: false,
      );

      await box.add(newUser);

      return {'success': true, 'message': 'تم التسجيل بنجاح'};
    } catch (e) {
      return {'success': false, 'error': 'حدث خطأ أثناء التسجيل: ${e.toString()}'};
    }
  }

  Future<Map<String, dynamic>> login(String identifier, String password) async {
    try {
      final box = Hive.box<UserModel>(_userBoxName);

      // ✅ بنقارن الباسورد مباشرة من غير تشفير
      UserModel? foundUser;
      int? userIndex;

      for (var i = 0; i < box.length; i++) {
        final user = box.getAt(i);
        if (user != null &&
            (user.email == identifier || user.phoneNumber == identifier) &&
            user.password == password) {
          foundUser = user;
          userIndex = i;
          break;
        }
      }

      if (foundUser == null) {
        return {
          'success': false,
          'error': 'البريد الإلكتروني أو رقم الهاتف أو كلمة المرور غير صحيحة',
        };
      }

      final updatedUser = foundUser.copyWith(isLoggedIn: true);
      await box.putAt(userIndex!, updatedUser);

      final currentBox = await Hive.openBox(_currentUserKey);
      await currentBox.put('userId', userIndex);

      return {'success': true, 'user': updatedUser, 'message': 'تم تسجيل الدخول بنجاح'};
    } catch (e) {
      return {'success': false, 'error': 'حدث خطأ أثناء تسجيل الدخول: ${e.toString()}'};
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final currentBox = await Hive.openBox(_currentUserKey);
      final userId = currentBox.get('userId');
      if (userId == null) return null;

      final box = Hive.box<UserModel>(_userBoxName);
      final user = box.getAt(userId);

      if (user != null && user.isLoggedIn) return user;
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    try {
      final currentBox = await Hive.openBox(_currentUserKey);
      final userId = currentBox.get('userId');

      if (userId != null) {
        final box = Hive.box<UserModel>(_userBoxName);
        final user = box.getAt(userId);
        if (user != null) {
          final updatedUser = user.copyWith(isLoggedIn: false);
          await box.putAt(userId, updatedUser);
        }
      }

      await currentBox.delete('userId');
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  // ✅ دالة جديدة عشان نجيب الباسورد في forgot password
  Box<UserModel> getUsersBox() => Hive.box<UserModel>(_userBoxName);

  Future<void> clearAll() async {
    final box = Hive.box<UserModel>(_userBoxName);
    await box.clear();
    final currentBox = await Hive.openBox(_currentUserKey);
    await currentBox.clear();
  }
}