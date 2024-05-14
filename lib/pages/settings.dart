import 'package:flutter/material.dart';
import '../components/sideBar.dart';
import '../colors/color_set.dart';
import '../components/appbar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool setting1 = true;
  bool setting2 = false;
  bool setting3 = true;
  bool setting4 = false;
  bool setting5 = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: htaPrimaryColors.shade100,
        drawer: Sidebar(),
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
                child: MyAppBar(username: "Rosser"),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: htaPrimaryColors.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SettingsSection(
                          title: 'Settings set 1',
                          settings: [
                            SettingItem(
                              title: 'Setting A',
                              description: 'Description A',
                              value: setting1,
                              onChanged: (bool value) {
                                setState(() {
                                  setting1 = value;
                                });
                              },
                            ),
                            SettingItem(
                              title: 'Setting A',
                              description: 'Description A',
                              value: setting2,
                              onChanged: (bool value) {
                                setState(() {
                                  setting2 = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SettingsSection(
                          title: 'Settings set 2',
                          settings: [
                            SettingItem(
                              title: 'Setting A',
                              description: 'Description A',
                              value: setting3,
                              onChanged: (bool value) {
                                setState(() {
                                  setting3 = value;
                                });
                              },
                            ),
                            SettingItem(
                              title: 'Setting A',
                              description: 'Description A',
                              value: setting4,
                              onChanged: (bool value) {
                                setState(() {
                                  setting4 = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SettingsSection(
                          title: 'Settings set 3',
                          settings: [
                            SettingItem(
                              title: 'Setting A',
                              description: 'Description A',
                              value: setting5,
                              onChanged: (bool value) {
                                setState(() {
                                  setting5 = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<SettingItem> settings;

  const SettingsSection(
      {super.key, required this.title, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: settings,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingItem({
    super.key,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
