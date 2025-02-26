import 'package:flutter/material.dart';
import 'package:guayabee_app/components/scaffold/custom_scaffold_controller.dart';
import 'package:guayabee_app/routes.dart';
import 'package:guayabee_app/services/auth_service.dart';
import 'package:guayabee_app/services/logger_service.dart';
import 'package:openidconnect/openidconnect.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  OpenIdConfiguration? _discoveryDocument;
  AuthorizationResponse? _identity;
  Map<String, dynamic>? _userInfo;
  late final AuthService _authService;
  final CustomScaffoldController _customScaffoldController = Get.put(
    CustomScaffoldController(),
  );

  @override
  void initState() {
    _authService = Get.find<AuthService>();
    _loadDiscoveryDocument();
    super.initState();
  }

  Future<void> _loadDiscoveryDocument() async {
    try {
      final config = await OpenIdConnect.getConfiguration(
        dotenv.env['DISCOVERY_URL']!,
      );
      setState(() {
        LogService.info(config.issuer);
        _discoveryDocument = config;
      });
    } catch (e) {
      LogService.error("$e");
    }
    _authenticate();
  }

  Future<void> _authenticate() async {
    if (_discoveryDocument == null) {
      LogService.error("OpenID Connect Configuration is not loaded.");
      return;
    }

    try {
      final request = await InteractiveAuthorizationRequest.create(
        clientId: dotenv.env['CLIENT_ID']!,
        redirectUrl: dotenv.env['REDIRECT_URL']!,
        scopes: ["openid", "profile", "email", "address", "offline_access"],
        configuration: _discoveryDocument!,
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
          configuration: _discoveryDocument!,
        ),
      );

      setState(() {
        _identity = response;
        _userInfo = userInfo;
        _authService
            .login(_identity!.accessToken, _identity!.refreshToken)
            .then((_) {
              _customScaffoldController.changeIndex(0);
              Routes.change(Routes.homeRoute);
            });
      });
    } catch (e) {
      LogService.error("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
