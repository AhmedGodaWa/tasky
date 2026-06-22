import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Guest';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final pref = await SharedPreferences.getInstance();

    final savedName = pref.getString('userName');

    if (savedName != null) {
      setState(() {
        userName = savedName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                const Text(
                  'One task at a time. One step closer.',
                  style: TextStyle(color: Color(0xFFC6C6C6), fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Profile Info',
            style: TextStyle(fontSize: 20, color: Color(0xFFFFFCFC)),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/profile_icon.svg',
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFFFCFC),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'User Details',
                  style: TextStyle(fontSize: 16, color: Color(0xFFFFFCFC)),
                ),
              ),
              const Icon(Icons.arrow_forward_outlined, color: Colors.white),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Color(0xFF6E6E6E), thickness: 1),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(
              'assets/images/dark_mode.svg',
              colorFilter: const ColorFilter.mode(
                Color(0xFFFFFCFC),
                BlendMode.srcIn,
              ),
            ),
            title: const Text(
              'Dark Mode',
              style: TextStyle(fontSize: 16, color: Color(0xFFFFFCFC)),
            ),
            trailing: Switch(
              activeTrackColor: const Color(0xFF15B86C),
              value: true,
              onChanged: (value) {},
            ),
          ),
          const Divider(color: Color(0xFF6E6E6E), thickness: 1),
          ListTile(
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
    );
  }
}
