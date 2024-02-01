import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Account'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.person_3_sharp),
                title: const Text('Profile'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.mail),
                title: const Text('Email'),
              ),
              SettingsTile.navigation(
                title: const Text('Sign out'),
                leading: const Icon(Icons.logout),
              )
            ],
          ),
          SettingsSection(
            title: const Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.notifications),
                title: const Text('Notification'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('Privacy'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.category),
                title: const Text('Update Categories'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
