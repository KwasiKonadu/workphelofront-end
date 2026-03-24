import 'package:flutter/material.dart';
import 'package:hr_phelo/Components/App_Theme/colors.dart';
import 'package:hr_phelo/Apps/Modules/hr_phelo/hr_pages/hr_people_management/leave_management/leave_management_widgets/employee_leave_list.dart';
import 'package:hr_phelo/Apps/Modules/hr_phelo/hr_pages/hr_people_management/leave_management/leave_management_widgets/leave_form.dart';
import 'package:hr_phelo/components/app_widgets/lists/app_lists.dart';
import 'package:unicons/unicons.dart';

import '../../../../../../components/form_components/my_buttons.dart';
import '../../../../../../components/form_components/my_side_panel.dart';

class LeaveManagementLayout extends StatefulWidget {
  const LeaveManagementLayout({super.key});

  @override
  State<LeaveManagementLayout> createState() => _LeaveManagementLayoutState();
}

class _LeaveManagementLayoutState extends State<LeaveManagementLayout> {
  final _panel = SidePanelController();
  @override
  Widget build(BuildContext context) {
    return AppTableWidget(
      headerTitle: 'Employees',
      details: 'Manage your workforce',
      headerTrailing: MyOutlinedButton(
        btnText: 'Request Leave',
        btnIcon: UniconsLine.user_plus,
        btnAccent: myMainColor,
        isHovered: false,
        onPressed: () => _panel.show(
          context: context,
          formTitle: 'Leave Form',
          secOnPressed: () {},
          onPressed: () {},
          child: const LeaveForm(),
        ),
      ),

      // search: buildSearchAndActionsBar(context),
      columns: const [
        TableColumn(header: 'Employee', width: FlexColumnWidth(4)),
        TableColumn(header: 'Type', width: FlexColumnWidth(1)),
        TableColumn(header: 'start Date', width: FlexColumnWidth(1)),
        TableColumn(header: 'End Date', width: FlexColumnWidth(1)),
        TableColumn(header: 'Reason', width: FlexColumnWidth(1)),
        TableColumn(header: 'Status', width: FlexColumnWidth(1)),
        TableColumn(header: '', width: FixedColumnWidth(48)),
      ],
      itemCount: 10,
      rowBuilder: buildEmployeeLeaveRowCells,
    );
  }
}
