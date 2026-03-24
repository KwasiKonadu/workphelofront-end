import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_phelo/Functions/Users/app_user_model.dart';
import 'package:hr_phelo/components/app_widgets/cards/display_card.dart';
import 'package:unicons/unicons.dart';

import '../../../../../Components/App_Theme/text_styles.dart';
import 'departments_list.dart';

class ManageDepartmentPage extends ConsumerStatefulWidget {
  final VoidCallback onBack;
  final AppUser currentUser;
  const ManageDepartmentPage({
    super.key,
    required this.onBack,
    required this.currentUser,
  });

  @override
  ConsumerState<ManageDepartmentPage> createState() =>
      _ManageDepartmentPageState();
}

class _ManageDepartmentPageState extends ConsumerState<ManageDepartmentPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────
          ListTile(
            title: Text('Manage Departments', style: myTitleTextStyle(context)),
            subtitle: Text(
              'Create departments and assign to employees',
              style: myMainTextStyle(
                context,
              ).copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            trailing: IconButton(
              onPressed: widget.onBack,
              icon: Icon(UniconsLine.building),
            ),
          ),

          // ── Content ────────────────────────────────────
          Expanded(
            child: DisplayCard(
              child: DepartmentsList(currentUser: widget.currentUser),
            ),
          ),
        ],
      ),
    );
  }
}
