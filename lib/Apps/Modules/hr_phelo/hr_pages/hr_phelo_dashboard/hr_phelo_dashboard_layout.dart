import 'package:flutter/material.dart';
import 'package:hr_phelo/Apps/Modules/hr_phelo/hr_pages/hr_phelo_dashboard/hr_phelo_dashboard_widgets.dart/employee_data.dart';
import 'package:hr_phelo/Functions/Users/app_user_model.dart';
import 'package:hr_phelo/components/app_widgets/cards/title_card.dart';
import 'package:intl/intl.dart';

class HrPheloDashboardLayout extends StatelessWidget {
  final AppUser currentUser;
  const HrPheloDashboardLayout({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            WelcomeCard(
              welcomeText: 'Welcome Back, ${currentUser.fullName}',
              date: DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
            ),
            EmployeeDataSummary(currentUser: currentUser),
          ],
        ),
      ),
    );
  }
}
