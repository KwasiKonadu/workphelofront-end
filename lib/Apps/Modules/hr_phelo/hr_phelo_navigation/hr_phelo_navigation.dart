import 'package:flutter/material.dart';
import 'package:hr_phelo/Apps/Modules/hr_phelo/hr_pages/hr_people_management/appraisal/appraisal_layout.dart';
import 'package:hr_phelo/Apps/Modules/hr_phelo/hr_pages/hr_people_management/employees/employee_layout.dart';
import 'package:hr_phelo/Apps/Modules/hr_phelo/hr_pages/hr_people_management/leave_management/leave_management_layout.dart';
import 'package:hr_phelo/Apps/Modules/hr_phelo/hr_pages/hr_people_management/offboarding/offboarding_layout.dart';
import 'package:hr_phelo/Apps/Modules/hr_phelo/hr_pages/hr_people_management/onboarding/onboarding_layout.dart';
import 'package:hr_phelo/Apps/Modules/hr_phelo/hr_pages/work_force_management/my_schedules/schedules_layout.dart';
import 'package:hr_phelo/Apps/Modules/hr_phelo/hr_pages/work_force_management/my_time/my_time.dart';
import 'package:hr_phelo/Apps/Modules/hr_phelo/hr_pages/work_force_management/projects_tasks/projects_tasks_layout.dart';
import 'package:hr_phelo/Functions/Users/app_user_model.dart';
import 'package:hr_phelo/Functions/company_functions/permissions/app_module.dart';
import 'package:unicons/unicons.dart';

import '../../../../components/app_widgets/lists/navigation.dart';
import '../hr_pages/hr_phelo_dashboard/hr_phelo_dashboard_layout.dart';

// navigation_data.dart
List<NavItem> hrNavigationItems(
  AppUser currentUser,
  Set<AppModule> accessibleModules,
) => [
  NavSection('Overview'),

  NavDestination(
    icon: Icons.dashboard_outlined,
    title: 'Dashboard',
    pageIndex: 0,
    page: HrPheloDashboardLayout(currentUser: currentUser),
    // no requiredModule — always visible
  ),

  NavSection('Employee Management'),

  NavDestination(
    icon: UniconsLine.users_alt,
    title: 'Employees',
    pageIndex: 1,
    page: EmployeeLayout(currentUser: currentUser),
    requiredModule: AppModule.onboarding
    // no requiredModule — always visible
  ),

  if (accessibleModules.contains(AppModule.onboarding))
    NavDestination(
      icon: UniconsLine.user_plus,
      title: 'Onboarding',
      pageIndex: 2,
      page: OnboardingLayout(currentUser: currentUser),
      requiredModule: AppModule.onboarding,
    ),

  if (accessibleModules.contains(AppModule.offboarding))
    NavDestination(
      icon: UniconsLine.user_minus,
      title: 'Offboarding',
      pageIndex: 3,
      page: const OffboardingLayout(),
      requiredModule: AppModule.offboarding,
    ),

  if (accessibleModules.contains(AppModule.leaveManagement))
    NavDestination(
      icon: UniconsLine.calender,
      title: 'Leave Management',
      pageIndex: 4,
      page: const LeaveManagementLayout(),
      requiredModule: AppModule.leaveManagement,
    ),

  if (accessibleModules.contains(AppModule.appraisal))
    NavDestination(
      icon: UniconsLine.check_circle,
      title: 'Appraisal',
      pageIndex: 5,
      page: const AppraisalLayout(),
      requiredModule: AppModule.appraisal,
    ),

  NavSection('Time Management'),

  NavDestination(
    icon: UniconsLine.clock,
    title: 'My Time',
    pageIndex: 6,
    page: MyTimePlanner(),
  ),
  NavDestination(
    icon: UniconsLine.schedule,
    title: 'My Schedules',
    pageIndex: 7,
    page: SchedulesLayout(),
  ),
  NavDestination(
    icon: UniconsLine.clipboard_notes,
    title: 'My Projects & Tasks',
    pageIndex: 8,
    page: ProjectsTasksLayout(),
  ),
];
