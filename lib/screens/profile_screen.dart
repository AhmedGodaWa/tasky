import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
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
            Text('My Profile', style: Theme.of(context).textTheme.titleLarge),
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
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Theme.of(context).colorScheme.onSurface,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(userName, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(
                    motivation,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Profile Info', style: Theme.of(context).textTheme.titleLarge),
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
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
              title: Text(
                'User Details',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Icon(
                Icons.arrow_forward_outlined,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Divider(color: Theme.of(context).colorScheme.outline, thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/dark_mode.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Dark Mode',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: ThemeController.themeMode,
                    builder: (context, themeMode, child) => Switch(
                      // activeTrackColor: const Color(0xFF15B86C),
                      value: themeMode == ThemeMode.dark,
                      onChanged: ThemeController.toggleTheme,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Theme.of(context).colorScheme.outline, thickness: 1),
            ListTile(
              onTap: _logout,
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(
                'assets/images/log_out.svg',
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
              title: Text(
                'Log Out',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Icon(
                Icons.arrow_forward_outlined,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
