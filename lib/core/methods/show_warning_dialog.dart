import 'package:flutter/material.dart';

import '../../features/add_product_screen/widgets/warning_alert_dialog.dart';

Future<void> showWarningDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return const AlertDialogWidget(
        text: 'Category is Empty',
      );
    },
  );
}
