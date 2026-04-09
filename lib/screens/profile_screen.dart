import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manger.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/screens/user_details_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String motivationQuote;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() {
      username = PreferencesManger().getString('username')!;
      motivationQuote =
          PreferencesManger().getString('motivation_quote') ??
          'One task at a time. One step closer.';

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "My Profile",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/person.png',
                            ),
                            radius: 60,
                            backgroundColor: Colors.transparent,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                ),
                                child: Icon(Icons.camera_alt, size: 26),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        username,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        motivationQuote,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Profile Info',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 24),

                ListTile(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return UserDetailsScreen(
                            userName: username,
                            motivationQuote: motivationQuote,
                          );
                        },
                      ),
                    );
                    if (result) {
                      _loadData();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'User Details',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  leading: CustomSvgPicture(
                    path: 'assets/icons/userDetailsOnProfile.svg',
                    withColorFilter: true,
                  ),
                  trailing: CustomSvgPicture(
                    path: 'assets/icons/rightArrow.svg',
                    withColorFilter: true,
                  ),
                ),

                Divider(thickness: 1),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Dark Mode'),
                  leading: CustomSvgPicture(
                    path: 'assets/icons/darkModeOnPrefile.svg',
                    withColorFilter: true,
                  ),

                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themeNotifer,
                    builder: (BuildContext context, value, Widget? child) {
                      return Switch(
                        value: value == ThemeMode.dark,
                        onChanged: (bool value) async {
                          ThemeController().toggeleTheme();
                        },
                      );
                    },
                  ),
                ),

                Divider(thickness: 1),

                ListTile(
                  onTap: () async {
                    PreferencesManger().remove("username");
                    PreferencesManger().remove("motivation_quote");
                    PreferencesManger().remove("tasks");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return WelcomeScreen();
                        },
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text('Log Out'),
                  leading: CustomSvgPicture(
                    path: 'assets/icons/logOutOnProfile.svg',
                    withColorFilter: true,
                  ),
                  trailing: CustomSvgPicture(
                    path: 'assets/icons/rightArrow.svg',
                    withColorFilter: true,
                  ),
                ),
              ],
            ),
          );
  }
}
