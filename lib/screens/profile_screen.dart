import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/screens/user_details_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Guest';
  String motivation = 'One task at a time. One step closer.';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {

    setState(() {
      userName = PreferencesManager().getUserName() ?? 'Guest';
      motivation =
          PreferencesManager().getMotivation() ??
          'One task at a time. One step closer.';
    });
  }

  Future<void> _logout() async {
    await PreferencesManager().clearUserData();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Profile',
              style: TextStyle(fontSize: 22, color: Color(0xFFFFFCFC)),
            ),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4, top: 10),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          radius: 75,
                          backgroundImage: AssetImage(
                            'assets/images/profile.png',
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xFF282828),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Color(0xFFFFFCFC),
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Color(0xFFFFFCFC),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    motivation,
                    style: const TextStyle(
                      color: Color(0xFFC6C6C6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Profile Info',
              style: TextStyle(fontSize: 20, color: Color(0xFFFFFCFC)),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () async {
                // Navigate to User Details Screen
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserDetailsScreen(),
                  ),
                );

                if (result == true && result != null) {
                  _loadUserData();
                }
              },
              leading: SvgPicture.asset(
                'assets/images/profile_icon.svg',
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFFFCFC),
                  BlendMode.srcIn,
                ),
              ),
              title: const Text(
                'User Details',
                style: TextStyle(fontSize: 16, color: Color(0xFFFFFCFC)),
              ),
              trailing: const Icon(
                Icons.arrow_forward_outlined,
                color: Colors.white,
              ),
            ),
            const Divider(color: Color(0xFF6E6E6E), thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/dark_mode.svg',
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFFFFCFC),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Dark Mode',
                      style: TextStyle(fontSize: 16, color: Color(0xFFFFFCFC)),
                    ),
                  ),
                  Switch(
                    activeTrackColor: const Color(0xFF15B86C),
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF6E6E6E), thickness: 1),
            ListTile(
              onTap: _logout,
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(
                'assets/images/log_out.svg',
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFFFCFC),
                  BlendMode.srcIn,
                ),
              ),
              title: const Text(
                'Log Out',
                style: TextStyle(fontSize: 16, color: Color(0xFFFFFCFC)),
              ),
              trailing: const Icon(
                Icons.arrow_forward_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
