import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicons/unicons.dart';

import '../../../../../../../components/app_theme/misc.dart';
import '../../../../../../../components/app_theme/text_styles.dart';
import '../../../../../../../components/app_widgets/user_avators.dart';
import '../../../../../../../Functions/company_functions/onboarding_function/onboarding_model.dart';

List<Widget> buildEmployeeRowCells(
  BuildContext context,
  UserModel user,
  WidgetRef ref,
) {
  final cs = Theme.of(context).colorScheme;

  // Initials from first + last name
  final initials =
      '${user.firstName.isNotEmpty ? user.firstName[0] : ''}'
              '${user.lastName.isNotEmpty ? user.lastName[0] : ''}'
          .toUpperCase();

  return [
    // Cell 0 — Employee name + avatar
    Row(
      children: [
        UserAvatar(initials: initials),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                user.fullName,
                style: myMainTextStyle(
                  context,
                ).copyWith(fontWeight: FontWeight.w600, color: cs.onSurface),
              ),
              Text(
                user.email,
                style: myNoInfoStyle(
                  context,
                ).copyWith(color: cs.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    ),

    // Cell 1 — Department
    Text(
      user.department ?? '',
      style: myNoInfoStyle(
        context,
      ).copyWith(color: cs.onSurface, fontWeight: FontWeight.w500),
    ),

    // Cell 2 — Role
    Text(
      user.jobTitle,
      style: myNoInfoStyle(
        context,
      ).copyWith(color: cs.onSurface, fontWeight: FontWeight.w500),
    ),

    // Cell 3 — Year joined
    Text(
      user.hiredDate.year.toString(),
      style: myNoInfoStyle(context).copyWith(color: cs.onSurfaceVariant),
    ),

    // Cell 5 — Employment type
    Text(
      user.employmentType,
      style: myNoInfoStyle(context).copyWith(color: cs.onSurfaceVariant),
    ),

    // Cell 4 — Status
    _buildStatusChip(context, user.status),

    // Cell 5 — Actions
    IconButton(
      icon: const Icon(UniconsLine.ellipsis_v, size: 20),
      onPressed: () {
        // pass user to a details/edit sheet
      },
      tooltip: 'More actions',
    ),
  ];
}

Widget _buildStatusChip(BuildContext context, EmploymentStatus status) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: status.color.withAlpha(15),
      borderRadius: BorderRadius.circular(appRadius),
    ),
    child: Center(
      child: Text(
        status.label,
        style: myMainTextStyle(context).copyWith(
          color: status.color,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
