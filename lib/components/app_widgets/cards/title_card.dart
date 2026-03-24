import 'package:flutter/material.dart';
import 'package:hr_phelo/Components/App_Theme/colors.dart';
import 'package:hr_phelo/components/app_theme/padding.dart';
import 'package:hr_phelo/components/app_theme/text_styles.dart';
import 'package:hr_phelo/components/form_components/my_buttons.dart';
import 'package:unicons/unicons.dart';

import '../../../Apps/Super_Admin/sa_widgets/company_onboarded_list.dart';
import '../../../Functions/Super_Admin_Functions/onboard_company_model.dart';

class TitleCard extends StatefulWidget {
  final String companyName;
  final String introText;
  final String? statTitle1;
  final String? stat1;
  final String? statTitle2;
  final String? stat2;
  final String? statTitle3;
  final String? stat3;
  final String? statTitle4;
  final String? stat4;
  const TitleCard({
    super.key,
    required this.introText,
    required this.companyName,
    this.statTitle1,
    this.stat1,
    this.statTitle2,
    this.stat2,
    this.statTitle3,
    this.stat3,
    this.statTitle4,
    this.stat4,
  });

  @override
  State<TitleCard> createState() => _TitleCardState();
}

class _TitleCardState extends State<TitleCard> {
  @override
  Widget build(BuildContext context) {
    const double csize = 0.47;
    return Padding(
      padding: menuItemPadding,
      child: Container(
        padding: myDisplayContentPadding,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [myMainColor, Colors.blue],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Wrap(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * csize,
              child: ListTile(
                title: Text(
                  widget.companyName,
                  style: myMainTextStyle(
                    context,
                  ).copyWith(color: Colors.amber[900]),
                ),
                subtitle: Text(
                  widget.introText,
                  style: myTitleTextStyle(
                    context,
                  ).copyWith(color: ColorScheme.of(context).surface),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * csize,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * csize * .25,
                    child: ListTile(
                      title: Text(
                        widget.statTitle1 ?? '',
                        style: myNoInfoStyle(
                          context,
                        ).copyWith(color: ColorScheme.of(context).surface),
                      ),
                      subtitle: Text(
                        widget.stat1 ?? '',
                        style: myMainTextStyle(
                          context,
                        ).copyWith(color: ColorScheme.of(context).surface),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * csize * .25,
                    child: ListTile(
                      title: Text(
                        widget.statTitle2 ?? '',
                        style: myNoInfoStyle(
                          context,
                        ).copyWith(color: ColorScheme.of(context).surface),
                      ),
                      subtitle: Text(
                        widget.stat2 ?? '',
                        style: myMainTextStyle(
                          context,
                        ).copyWith(color: ColorScheme.of(context).surface),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * csize * .25,
                    child: ListTile(
                      title: Text(
                        widget.statTitle3 ?? '',
                        style: myNoInfoStyle(
                          context,
                        ).copyWith(color: ColorScheme.of(context).surface),
                      ),
                      subtitle: Text(
                        widget.stat3 ?? '',
                        style: myMainTextStyle(
                          context,
                        ).copyWith(color: ColorScheme.of(context).surface),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * csize * .25,
                    child: ListTile(
                      title: Text(
                        widget.statTitle4 ?? '',
                        style: myNoInfoStyle(
                          context,
                        ).copyWith(color: ColorScheme.of(context).surface),
                      ),
                      subtitle: Text(
                        widget.stat4 ?? '',
                        style: myMainTextStyle(
                          context,
                        ).copyWith(color: ColorScheme.of(context).surface),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeCard extends StatefulWidget {
  final String date;
  final String welcomeText;

  const WelcomeCard({super.key, required this.welcomeText, required this.date});

  @override
  State<WelcomeCard> createState() => _WelcomeCardState();
}

class _WelcomeCardState extends State<WelcomeCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: menuItemPadding,
      child: Container(
        padding: myDisplayContentPadding,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [myMainColor, Colors.blue],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text(
                  widget.welcomeText,
                  style: myTitleTextStyle(
                    context,
                  ).copyWith(color: ColorScheme.of(context).surface),
                ),
                subtitle: Text(
                  widget.date,
                  style: myMainTextStyle(
                    context,
                  ).copyWith(color: Colors.amber[500]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeCardAlt extends StatefulWidget {
  final String details;
  final String title;

  const WelcomeCardAlt({super.key, required this.title, required this.details});

  @override
  State<WelcomeCardAlt> createState() => _WelcomeCardAltState();
}

class _WelcomeCardAltState extends State<WelcomeCardAlt> {
  @override
  Widget build(BuildContext context) {
    ColorScheme.of(context);
    return Padding(
      padding: myDisplayContentPadding,
      child: Center(
        child: ListTile(
          title: Text(
            widget.title,
            style: myTitleTextStyle(
              context,
            ).copyWith(color: ColorScheme.of(context).onSurface),
          ),
          subtitle: Text(widget.details, style: myMainTextStyle(context)),
        ),
      ),
    );
  }
}


class CompanyCard extends StatelessWidget {
  final CompanyModel company;
  final VoidCallback onDelete;
  final VoidCallback onToggleStatus;
  final VoidCallback onBack;

  const CompanyCard({
    super.key,
    required this.company,
    required this.onDelete,
    required this.onToggleStatus,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isActive = company.status == CompanyStatus.active;

    return Padding(
      padding: myContentPadding,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.outline.withAlpha(70)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            // Left — company info
            Expanded(
              child: ListTile(
                leading: IconButton(
                  onPressed: onBack,
                  icon: Icon(UniconsLine.estate),
                ),
                title: Row(
                  children: [
                    Text(
                      company.companyName,
                      style: myMainTextStyle(context).copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                    buildStatusChip(context, company.status),
                  ],
                ),
                subtitle: Text(
                  company.tenantSlug,
                  style: myNoInfoStyle(
                    context,
                  ).copyWith(color: cs.onSurfaceVariant),
                ),
              ),
            ),

            // Right — actions
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyOutlinedMenuButton(
                  onPressed: onDelete,
                  btnText: 'Delete Company',
                  btnIcon: UniconsLine.trash,
                  btnAccent: Colors.redAccent,
                  isHovered: false,
                ),
                const SizedBox(width: 10),
                MyOutlinedMenuButton(
                  onPressed: onToggleStatus,
                  btnText: isActive ? 'Deactivate' : 'Activate',
                  btnIcon: isActive ? UniconsLine.pen : UniconsLine.check,
                  btnAccent: myMainColor,
                  isHovered: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
