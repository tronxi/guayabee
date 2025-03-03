import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/session_storage_service.dart' show SessionStorageService;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late SessionStorageService _sessionStorageService;
  Map<String, String?> _profileData = {};

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    _sessionStorageService = Get.find<SessionStorageService>();
    final profile = await _sessionStorageService.getProfile();
    setState(() {
      _profileData = {
        'given_name':
            profile['given_name'] != null
                ? fixEncoding(profile['given_name']!)
                : null,
        'family_name':
            profile['family_name'] != null
                ? fixEncoding(profile['family_name']!)
                : null,
        'email':
            profile['email'] != null ? fixEncoding(profile['email']!) : null,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${_profileData['given_name'] ?? 'Unknown'} ${_profileData['family_name'] ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${_profileData['email'] ?? 'Unknown'}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  String fixEncoding(String text) {
    return utf8.decode(latin1.encode(text));
  }
}
