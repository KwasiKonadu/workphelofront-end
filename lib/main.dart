import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_phelo/Apps/Company/dashboard/company_dashboard.dart';
import 'package:hr_phelo/Components/app_theme/colors.dart';
import 'package:hr_phelo/Apps/Modules/dashboard.dart';
import 'package:hr_phelo/pages/get_started.dart';
import 'package:hr_phelo/pages/login_page/login_form_types.dart/login_page.dart';

import 'Apps/Super_Admin/super_admin_layout.dart';
import 'Functions/Users/app_user_model.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/platform/dashboard': (context) => SuperAdminLayout(),
        '/dashboard': (context) => CompanyDashboard(),
        '/home': (context) => DashboardPage(),
        '/login': (context) => LoginPage(),
        '/get-started': (context) {
          final user = ModalRoute.of(context)?.settings.arguments as AppUser;
          return GetStartedPage(currentUser: user);
        },
      },
      title: 'Work Phelo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      // theme: darkTheme,
      home: LoginPage(),
    );
  }
}
