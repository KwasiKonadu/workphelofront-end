import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_phelo/Functions/Super_Admin_Functions/company_state.dart';
import 'package:hr_phelo/Apps/Super_Admin/Pages/company_onboarding_form.dart';
import 'package:hr_phelo/Functions/Users/app_user_model.dart';
import 'package:hr_phelo/components/app_widgets/cards/title_card.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

import '../../../Components/app_theme/colors.dart';
import '../../../Functions/Super_Admin_Functions/onboard_company_model.dart';
import '../../../Functions/Users/login_functions/auth_state.dart';
import '../../../components/app_widgets/lists/app_lists.dart';
import '../../../components/form_components/my_buttons.dart';
import '../../../components/form_components/my_side_panel.dart';
import '../sa_widgets/company_onboarded_list.dart';

class SuperAdminPortal extends ConsumerStatefulWidget {
  final AppUser currentUser;
  final ValueChanged<CompanyModel> onCompanySelected;
  const SuperAdminPortal({
    super.key,
    required this.currentUser,
    required this.onCompanySelected,
  });

  @override
  ConsumerState<SuperAdminPortal> createState() => _SuperAdminPortalState();
}

class _SuperAdminPortalState extends ConsumerState<SuperAdminPortal> {
  late final _panel = SidePanelController();
  final _formKey = GlobalKey<CompanyOnboardingFormState>();
  String statDisplay(String value) => value == '0' ? '-' : value;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(companyProvider);
    final companies = state.companies;
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (previous?.isAuthenticated == true && !next.isAuthenticated) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    });
    

    // Move these above the stats list
    final totalCompanies = companies.length;
    final activeCompanies = companies
        .where((c) => c.status == CompanyStatus.active)
        .length;
    final inactiveCompanies = companies
        .where((c) => c.status == CompanyStatus.inactive)
        .length;
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;
    final newThisMonth = companies.where((c) {
      final d = c.onboardedDate;
      return d != null && d.month == currentMonth && d.year == currentYear;
    }).length;

    const double csize = 0.95;
    return Column(
      children: [
        TitleCard(
            introText: 'Good morning, ${widget.currentUser.fullName}',
            companyName: widget.currentUser.companyName,
            statTitle1: 'Total Companies',
            stat1: statDisplay('$totalCompanies'),
            statTitle2: 'Active Companies',
            stat2: statDisplay('$activeCompanies'),
            statTitle3: 'Inactive Companies',
            stat3: statDisplay('$inactiveCompanies'),
            statTitle4:
                'Companies for ${DateFormat('MMMM').format(DateTime.now())}',
            stat4: statDisplay('$newThisMonth'),
          ),
        Expanded(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * csize,
            child: AppTableWidget(
              headerTitle: 'Companies',
              headerTrailing: MyOutlinedButton(
                btnText: 'Onboard Company',
                btnIcon: UniconsLine.user_plus,
                btnAccent: myMainColor,
                isHovered: false,
                onPressed: () => _panel.show(
                  context: context,
                  formTitle: 'COMPANY ONBOARDING FORM',
                  onPressed: () {
                    final company = _formKey.currentState?.submit();
                    if (company == null) return;
                    ref.read(companyProvider.notifier).addCompany(company);
                    _panel.close();
                  },
                  secOnPressed: () => _formKey.currentState?.reset(),
                  child: CompanyOnboardingForm(
                    key: _formKey,
                    currentUser: widget.currentUser,
                  ),
                ),
              ),
              columns: const [
                TableColumn(header: 'Company Details', width: FlexColumnWidth(2)),
                TableColumn(header: 'Administrator', width: FlexColumnWidth(2)),
                TableColumn(header: 'Contact', width: FlexColumnWidth(1)),
                TableColumn(header: 'Date Created', width: FlexColumnWidth(1)),
                TableColumn(header: 'Industry', width: FlexColumnWidth(1)),
                TableColumn(header: 'Status', width: FixedColumnWidth(150)),
                TableColumn(header: '', width: FixedColumnWidth(50)),
              ],
              itemCount: companies.length,
              rowBuilder: (context, index) => buildCompanyOnboardedRowCells(
                context,
                companies[index],
                ref,
                onTap: () => widget.onCompanySelected(companies[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
