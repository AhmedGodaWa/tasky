import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
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

  final _picker = ImagePicker();
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadProfileImage();
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

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image == null) return;

    final File file = await _saveImagePermanently(image);

    await PreferencesManager().saveProfileImage(file.path);

    setState(() {
      _profileImage = file;
    });
  }

  Future<File> _saveImagePermanently(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();

    final fileName = path.basename(image.path);

    final newImage = await File(
      image.path,
    ).copy(path.join(directory.path, fileName));

    return newImage;
  }

  void _loadProfileImage() {
    final String? imagePath = PreferencesManager().getProfileImage();

    if (imagePath == null) return;

    final File image = File(imagePath);

    setState(() {
      _profileImage = image;
    });
  }

  Future<void> _showImagePickerBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 220,
            child: Column(
              children: [
                Text(
                  "Choose Image",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),

                Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.camera_alt_outlined),
                          const SizedBox(width: 8),
                          Text(
                            'Camera',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.photo_library_outlined),
                          const SizedBox(width: 8),
                          Text(
                            'Gallery',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
                        CircleAvatar(
                          radius: 75,
                          backgroundImage: _profileImage == null
                              ? const AssetImage('assets/images/profile.png')
                              : FileImage(_profileImage!),
                          backgroundColor: Colors.transparent,
                        ),
                        GestureDetector(
                          onTap: _showImagePickerBottomSheet,
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
