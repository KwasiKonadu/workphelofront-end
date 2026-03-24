import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_phelo/Functions/Users/app_user_model.dart';

import '../../../../../../Functions/company_functions/departments/department_state.dart';
import '../../../../../../Functions/company_functions/onboarding_function/user_state.dart';
import '../../../../../../components/app_widgets/lists/app_grid.dart';

class EmployeeLayout extends ConsumerStatefulWidget {
  final AppUser currentUser;
  const EmployeeLayout({super.key, required this.currentUser});

  @override
  ConsumerState<EmployeeLayout> createState() => _EmployeeLayoutState();
}

class _EmployeeLayoutState extends ConsumerState<EmployeeLayout> {
  String _search = '';
  String? _departmentFilter;

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(
      usersByTenantProvider(widget.currentUser.tenantSlug),
    );
    final departments = ref.watch(
      departmentsByTenantProvider(widget.currentUser.tenantSlug),
    );

    final filtered = users.where((u) {
      final matchesSearch =
          _search.isEmpty ||
          u.fullName.toLowerCase().contains(_search.toLowerCase()) ||
          u.email.toLowerCase().contains(_search.toLowerCase()) ||
          u.jobTitle.toLowerCase().contains(_search.toLowerCase());

      final matchesDept =
          _departmentFilter == null ||
          _departmentFilter == 'All departments' ||
          u.department == _departmentFilter;

      return matchesSearch && matchesDept;
    }).toList();

    return EmployeeCardGrid(
      users: filtered,
      departments: departments,
      currentUser: widget.currentUser,
      search: _search,
      departmentFilter: _departmentFilter,
      onSearchChanged: (v) => setState(() => _search = v),
      onDepartmentChanged: (v) => setState(() => _departmentFilter = v),
      onCardTap: (user) {
        // open employee detail panel
      },
    );
  }
}
