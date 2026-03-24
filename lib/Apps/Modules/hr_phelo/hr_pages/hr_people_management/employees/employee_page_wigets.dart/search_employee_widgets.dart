import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../../../../../../components/form_components/my_buttons.dart';
import '../../../../../../../components/form_components/text_fields.dart';

Widget buildSearchAndActionsBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Flexible(
                flex: 3,
                child: CustomSearchField(
                  hinttext: 'Search by name, email, department...',
                  onChanged: (value) {
                    // filter logic
                  },
                ),
              ),
              Flexible(
                child: MyDropdownField(
                  placeholder: 'filter',
                  items: [
                    'By name',
                    'By department',
                    'By role',
                    'By year',
                    'By status',
                  ],
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        const SizedBox(width: 16),
        Builder(
          builder: (context) {
            return WidgetButton(
              btnText: 'export',
              btnPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              btnIcon: UniconsLine.export,
            );
          },
        ),
        const SizedBox(width: 12),
      ],
    ),
  );
}
