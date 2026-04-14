import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/logic/auth_provider.dart';
// افترضنا إن شاشة اللوجن اسمها LoginScreen
import '../../../auth/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// دالة تسجيل الخروج + التوجيه لشاشة اللوجن بدون إمكانية الرجوع
  Future<void> _handleLogout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // نفذ عملية تسجيل الخروج
    await authProvider.logout();  // ← تأكدي إنها موجودة وشغالة في AuthProvider

    // اذهب لشاشة اللوجن وحذف كل الشاشات السابقة من الـ stack
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,  // ← ده اللي بيمنع الرجوع نهائيًا
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('حسابي'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.amber,
          foregroundColor: Colors.white,
        ),
        body: user == null
            ? const Center(child: CircularProgressIndicator())
            : FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.amber.shade100,
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: Colors.amber.shade800,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'مرحباً بك!',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    user.fullName ?? 'مستخدم',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.amber.shade800,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            icon: Icons.email_outlined,
                            title: 'البريد الإلكتروني',
                            value: user.email ?? 'غير متوفر',
                          ),
                          const Divider(height: 30),
                          _buildInfoRow(
                            icon: Icons.phone_outlined,
                            title: 'رقم الهاتف',
                            value: user.phoneNumber ?? 'غير متوفر',
                          ),
                          // لو عايزة تعرضي الإيميل كمعرف (بدل id)
                          if (user.email != null) ...[
                            const Divider(height: 30),
                            _buildInfoRow(
                              icon: Icons.numbers,
                              title: 'معرف الحساب',
                              value: user.email!.substring(0, 10) + '...',
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // زر تسجيل الخروج
                  OutlinedButton.icon(
                    onPressed: _handleLogout,
                    icon: const Icon(Icons.logout, color: Colors.redAccent),
                    label: const Text(
                      'تسجيل الخروج',
                      style: TextStyle(color: Colors.redAccent, fontSize: 16),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.redAccent, width: 1.5),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.amber.shade700, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}