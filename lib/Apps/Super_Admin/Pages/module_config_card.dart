import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_phelo/Functions/Super_Admin_Functions/onboard_company_model.dart';
import 'package:hr_phelo/components/app_widgets/cards/display_card.dart';
import 'package:unicons/unicons.dart';

import '../../../Components/App_Theme/text_styles.dart';
import '../../../Components/app_theme/colors.dart';
import '../../../Functions/Super_Admin_Functions/company_state.dart';
import '../../../components/form_components/my_buttons.dart';

class ModuleConfigCard extends ConsumerStatefulWidget {
  final CompanyModel company;
  final VoidCallback? onSave;

  const ModuleConfigCard({super.key, this.onSave, required this.company});

  @override
  ConsumerState<ModuleConfigCard> createState() => _ModuleConfigCardState();
}

class _ModuleConfigCardState extends ConsumerState<ModuleConfigCard> {
  late final List<ModuleConfig> _modules;
  @override
  void initState() {
    super.initState();
    _modules = [
      ModuleConfig(
        key: 'hr',
        name: 'HR Module',
        description: 'Manage employees, attendance, payroll...',
        icon: UniconsLine.users_alt,
        isEnabled: widget.company.enabledModules.contains('hr'),
      ),
      ModuleConfig(
        key: 'accounting',
        name: 'Accounting Module',
        description: 'Manage invoices, expenses, reports...',
        icon: UniconsLine.money_bill,
        isEnabled: widget.company.enabledModules.contains('accounting'),
      ),
      ModuleConfig(
        key: 'marketing',
        name: 'Marketing Module',
        description: 'Manage campaigns, leads, analytics...',
        icon: UniconsLine.chart_bar,
        isEnabled: widget.company.enabledModules.contains('marketing'),
      ),
      ModuleConfig(
        key: 'operations',
        name: 'Operations Module',
        description: 'Manage tickets, agents, responses...',
        icon: UniconsLine.question_circle,
        isEnabled: widget.company.enabledModules.contains('operations'),
      ),
    ];
  }

  void _save() {
    final enabled = _modules
        .where((m) => m.isEnabled)
        .map((m) => m.key)
        .toList();

    ref
        .read(companyProvider.notifier)
        .updateEnabledModules(widget.company.tenantSlug, enabled);
  }

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);

    return DisplayCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              'Module Configuration',
              style: myMainTextStyle(context).copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: cs.onSurface,
              ),
            ),
            subtitle: Text(
              'Enable or disable modules available to this company.',
              style: myNoInfoStyle(
                context,
              ).copyWith(color: cs.onSurfaceVariant),
            ),
            trailing: MyOutlinedButton(
              btnText: 'Save Configuration',
              btnIcon: UniconsLine.save,
              btnAccent: myMainColor,
              isHovered: true,
              onPressed: _save,
            ),
          ),
          // Header

          // Module list
          ..._modules.map((module) => _buildModuleTile(context, module)),
        ],
      ),
    );
  }

  Widget _buildModuleTile(BuildContext context, ModuleConfig module) {
    final cs = ColorScheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Icon box
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: myMainColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(module.icon, color: Colors.white, size: 22),
          ),
          SizedBox(width: 10),

          // Name + description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  module.name,
                  style: myMainTextStyle(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600, color: cs.onSurface),
                ),
                const SizedBox(height: 2),
                Text(
                  module.description,
                  style: myNoInfoStyle(
                    context,
                  ).copyWith(color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),

          // Toggle
          Switch(
            value: module.isEnabled,
            activeThumbColor: myMainColor,
            onChanged: (val) => setState(() => module.isEnabled = val),
          ),
        ],
      ),
    );
  }
}
