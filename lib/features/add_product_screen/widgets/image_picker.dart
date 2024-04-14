import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopsmart_admin_ar/features/add_product_screen/widgets/custom_material_button.dart';
import 'package:shopsmart_admin_ar/features/add_product_screen/widgets/image_picker_alert_dialog.dart';

class CustomImagePicker extends StatefulWidget {
  const CustomImagePicker({super.key});

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  XFile? photo;
  @override
  Widget build(BuildContext context) {
    var imagePicker = ImagePicker();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
            border: Border.all(width: 1.2, color: Colors.black),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: photo == null
                ? const Center(child: Text("Product image"))
                : Image.file(
                    File(photo!.path),
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        Positioned(
          right: -10,
          top: -8,
          child: CustomMaterialButton(
            icon: const Icon(Icons.add_a_photo_outlined),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: ImagePickeraAlertDialog(
                      onCamera: () async {
                        var image = await imagePicker.pickImage(
                            source: ImageSource.camera);
                        setState(() {
                          photo = image;
                        });
                        Navigator.of(context).pop();
                      },
                      onGallery: () async {
                        var image = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          photo = image;
                        });
                        Navigator.of(context).pop();
                      },
                      onRemove: () {
                        setState(() {
                          photo = null;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
