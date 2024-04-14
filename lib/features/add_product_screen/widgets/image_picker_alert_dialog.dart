import 'package:flutter/material.dart';
import 'package:shopsmart_admin_ar/features/add_product_screen/widgets/custom_text_button.dart';

class ImagePickeraAlertDialog extends StatelessWidget {
  const ImagePickeraAlertDialog({
    super.key,
    required this.onCamera,
    required this.onGallery,
    this.onRemove,
  });
  final void Function()? onCamera;
  final void Function()? onGallery;
  final void Function()? onRemove;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Choose Option",
          style: TextStyle(fontSize: 22),
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextButtonImageOption(
          text: 'Camera',
          icon: Icons.camera,
          onPressed: onCamera,
        ),
        CustomTextButtonImageOption(
          text: 'Gallery  ',
          icon: Icons.photo,
          onPressed: onGallery,
        ),
        CustomTextButtonImageOption(
          text: 'Remove',
          icon: Icons.remove_circle_outline,
          onPressed: onRemove,
          color: Colors.red,
        )
      ],
    );
  }
}
