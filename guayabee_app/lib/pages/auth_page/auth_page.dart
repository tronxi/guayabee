import 'package:flutter/material.dart';
import 'package:guayabee_app/config/logger_service.dart';
import 'package:openidconnect/openidconnect.dart';

import 'credentials.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  OpenIdConfiguration? discoveryDocument;
  AuthorizationResponse? identity;
  Map<String, dynamic>? userInfo;
  bool isLoading = false;

  @override
  void initState() {
    print("init state");
    _loadDiscoveryDocument();
    super.initState();
  }

  Future<void> _loadDiscoveryDocument() async {
    try {
      print("intentand");
      await OpenIdConnect.initalizeEncryption("1234567890123456");
      final config = await OpenIdConnect.getConfiguration(defaultDiscoveryUrl);
      print("tengo");
      setState(() {
        LogService.info(config.issuer);
        discoveryDocument = config;
      });
    } catch (e) {
      LogService.error("$e");
    }
    _authenticate();
  }

  Future<void> _authenticate() async {
    if (discoveryDocument == null) {
      LogService.error("OpenID Connect Configuration is not loaded.");
      return;
    }

    setState(() => isLoading = true);

    try {
      final request = await InteractiveAuthorizationRequest.create(
        clientId: defaultClientId,
        redirectUrl: defaultRedirectUrl,
        scopes: defaultscopes,
        configuration: discoveryDocument!,
        autoRefresh: true,
        useWebPopup: true,
      );

      final response = await OpenIdConnect.authorizeInteractive(
        context: context,
        title: "Login",
        request: request,
      );

      final userInfo = await OpenIdConnect.getUserInfo(
        request: UserInfoRequest(
          accessToken: response!.accessToken,
          configuration: discoveryDocument!,
        ),
      );

      setState(() {
        identity = response;
        this.userInfo = userInfo;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      LogService.error("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isLoading
            ? const CircularProgressIndicator()
            : TextButton.icon(
              onPressed: _authenticate,
              icon: const Icon(Icons.login),
              label: const Text("Login with Keycloak"),
            ),
        if (identity != null)
          Column(
            children: [
              Text("Bienvenido, ${userInfo?['name'] ?? 'Usuario'}"),
              Text(identity?.accessToken ?? "aa"),
              TextButton.icon(
                onPressed: _logout,
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ],
          ),
      ],
    );
  }

  Future<void> _logout() async {
    setState(() {
      identity = null;
      userInfo = null;
    });
  }
}
