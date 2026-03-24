import 'package:flutter/material.dart';
import 'package:hr_phelo/Apps/Modules/hr_phelo/hr_pages/hr_people_management/employees/employee_page_wigets.dart/onboarding_form.dart';
import 'package:hr_phelo/Functions/Users/app_user_model.dart';
import 'package:hr_phelo/components/app_widgets/cards/display_card.dart';
import 'package:hr_phelo/components/app_widgets/cards/title_card.dart';

class OnboardingLayout extends StatefulWidget {
  final AppUser currentUser;
  const OnboardingLayout({super.key,required this.currentUser});

  @override
  State<OnboardingLayout> createState() => _OnboardingLayoutState();
}

class _OnboardingLayoutState extends State<OnboardingLayout> {
  @override
  Widget build(BuildContext context) {
    return DisplayCard(
      child: Column(
        children: [
          WelcomeCardAlt(
            title: 'Employee Onboarding',
            details: 'Add new employees to your systme',
          ),

          Flexible(child: OnboardingForm(currentUser: widget.currentUser,)),
        ],
      ),
    );
  }
}
