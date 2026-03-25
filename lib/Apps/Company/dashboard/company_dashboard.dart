import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_phelo/Apps/Company/company_pages/management_pages/management_page_layout.dart';
import 'package:hr_phelo/Apps/Company/company_pages/management_pages/tmp_pages.dart';
import 'package:hr_phelo/Apps/Modules/module_options.dart';
import 'package:hr_phelo/components/app_theme/app_images.dart';
import 'package:hr_phelo/components/app_widgets/user_avators.dart';
import 'package:unicons/unicons.dart';

import '../../../Components/app_theme/colors.dart';
import '../../../Functions/Users/app_user_model.dart';
import '../../../Functions/Users/login_functions/auth_state.dart';
import '../../../Functions/company_functions/onboarding_function/onboarding_model.dart';
import '../../../Functions/company_functions/onboarding_function/user_state.dart';
import '../../../components/app_theme/misc.dart';
import '../../../components/app_widgets/cards/title_card.dart';
import '../../../components/app_widgets/lists/horizontal_navigation_tabs.dart';
import '../../../pages/log_out/user_details_popup.dart';
import '../company_pages/management_pages/manage_departments/manage_department_page.dart';
import '../company_pages/management_pages/permissions_roles_pages/roles_permissions_page.dart';

class CompanyDashboard extends ConsumerStatefulWidget {
  const CompanyDashboard({super.key});

  @override
  ConsumerState<CompanyDashboard> createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends ConsumerState<CompanyDashboard> {
  late AppUser user;
  int _currentIndex = 0;
  int _managementSubIndex = -1;
  String statDisplay(String value) => value == '0' ? '-' : value;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is Map) {
      user = args['user'] as AppUser;
      _currentIndex = args['initialIndex'] as int? ?? 0;
    } else if (args is AppUser) {
      // normal login flow — keep existing behaviour
      user = args;
      _currentIndex = 0;
    } else {
      user = AppUser(
        uid: '',
        email: 'unknown',
        fullName: 'Guest',
        role: 'guest',
        companyName: 'company_name',
        lastLogin: DateTime.now(),
        tenantSlug: '',
        companyStatus: '',
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(usersByTenantProvider(user.tenantSlug));
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (previous?.isAuthenticated == true && !next.isAuthenticated) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    });
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        backgroundColor: ColorScheme.of(context).surface,
        leading: appLogo,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppNavItem(
              label: 'Portal',
              icon: UniconsLine.home_alt,
              isSelected: _currentIndex == 0,
              onTap: () => setState(() => _currentIndex = 0),
            ),
            AppNavItem(
              label: 'Modules',
              icon: UniconsLine.apps,
              isSelected: _currentIndex == 1,
              onTap: () => setState(() => _currentIndex = 1),
            ),

            AppNavItem(
              label: 'Management',
              icon: UniconsLine.building,
              isSelected: _currentIndex == 2,
              onTap: () => setState(() => _currentIndex = 2),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: myMainColor),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(UniconsLine.setting, color: myMainColor),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: InkWell(
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              ),
              borderRadius: BorderRadius.circular(appRadius),
              child: UserDashIcon(
                onIconPressed: (details) {
                  UserDetailsPopup.show(
                    context,
                    details.globalPosition,
                    user,
                    ref,
                  );
                },
                initials: user.fullName.isNotEmpty
                    ? user.fullName
                          .trim()
                          .split(' ')
                          .map((e) => e[0])
                          .take(2)
                          .join()
                    : 'G',
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
        ],
      ),
      body: Column(
        children: [
          TitleCard(
            companyName: user.companyName,
            introText: 'Good morning, ${user.fullName}',
            stats: [
              TitleCardStat(
                title: 'Employees',
                value: statDisplay(users.length.toString()),
              ),
              TitleCardStat(
                title: 'On Leave',
                value: statDisplay(
                  users
                      .where((u) => u.status == EmploymentStatus.active)
                      .length
                      .toString(),
                ),
              ),
              TitleCardStat(
                title: 'Assets',
                value: statDisplay(
                  ref
                      .watch(userProvider)
                      .users
                      .where((u) => u.status == EmploymentStatus.onLeave)
                      .length
                      .toString(),
                ),
              ),
              TitleCardStat(title: 'Company Assets', value: '-'),
            ],
          ),

          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [_portalPage(), _modulesPage(), _managementPage()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _portalPage() {
    return Center(child: Text('Home Page'));
  }

  Widget _modulesPage() {
    return Center(child: ModuleOptions(currentUser: user));
  }

  Widget _managementPage() {
    return _managementSubIndex == -1
        ? ManagementPage(
            onNavigate: (i) => setState(() => _managementSubIndex = i),
          )
        : _managementSubPages()[_managementSubIndex];
  }

  List<Widget> _managementSubPages() => [
    ManageDepartmentPage(
      onBack: () => setState(() => _managementSubIndex = -1),
      currentUser: user,
    ),
    Employees(onBack: () => setState(() => _managementSubIndex = -1)),
    RolesPermissionsPage(
      onBack: () => setState(() => _managementSubIndex = -1),
      currentUser: user,
    ),
    AdminAcc(),
    AuditLog(),
    GeneralSettings(),
  ];
}
