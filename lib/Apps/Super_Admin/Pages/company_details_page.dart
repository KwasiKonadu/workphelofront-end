import 'package:flutter/material.dart';
import 'package:hr_phelo/components/app_theme/padding.dart';
import 'package:hr_phelo/components/app_theme/text_styles.dart';
import 'package:hr_phelo/components/app_widgets/cards/company_details_card.dart';
import 'package:hr_phelo/components/app_widgets/cards/display_card.dart';
import 'package:hr_phelo/components/app_widgets/cards/title_card.dart';

import '../../../Functions/Super_Admin_Functions/onboard_company_model.dart';
import '../../../Functions/Users/app_user_model.dart';
import 'module_config_card.dart';

class CompanyDetailPage extends StatelessWidget {
  final CompanyModel company;
  final AppUser currentUser;
  final VoidCallback onBack;

  const CompanyDetailPage({
    super.key,
    required this.company,
    required this.currentUser,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb
        Padding(
          padding: formPadding,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Dashboard > ', style: myNoInfoStyle(context)),
                TextSpan(
                  text: company.companyName,
                  style: myNoInfoStyle(context).copyWith(color: cs.onSurface),
                ),
              ],
            ),
          ),
        ),

        // Top bar — status + actions
        CompanyCard(
          company: company,
          onDelete: () {},
          onToggleStatus: () {},
          onBack: onBack,
        ),

        // Middle row — detail card + placeholder
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: CompanyDetailCard(company: company)),
              Expanded(child: ModuleConfigCard(company: company)),
            ],
          ),
        ),

        // Bottom row — placeholder
        Expanded(
          child: DisplayCard(
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 200),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cs.outlineVariant),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
