import 'package:flutter/material.dart';
import 'package:hr_phelo/Components/Form_Components/text_fields.dart';

class LeaveForm extends StatelessWidget {
  const LeaveForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          children: [
            MyDropdownField(
              placeholder: 'Select leave type',
              label: 'Leave Type',
              items: [
                'Annual',
                'Sick',
                'Maternity',
                'Paternity',
                'Unpaid',
                'Study',
              ],
            ),
            MyDatePicker(
              placeholder: 'dd/mm/yyyy',
              label: 'Start date',
              firstDate: DateTime.now(),
            ),
            MyDatePicker(
              placeholder: 'dd/mm/yyyy',
              label: 'End date',
              firstDate: DateTime.now(),
            ),
            MyCustomTextField(
              label: 'Reason',
              placeholder: 'give reason for the leave',
            ),
          ],
        ),
      ),
    );
  }
}
