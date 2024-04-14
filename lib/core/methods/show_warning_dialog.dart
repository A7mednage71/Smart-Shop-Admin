import 'package:flutter/material.dart';

import '../../features/add_product_screen/widgets/warning_alert_dialog.dart';

Future<void> showWarningDialog(BuildContext context, {required String text}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialogWidget(
        text: text,
      );
    },
  );
}
