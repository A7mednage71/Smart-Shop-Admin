import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopsmart_admin_ar/core/consts/app_constants.dart';
import 'package:shopsmart_admin_ar/core/methods/show_warning_dialog.dart';
import 'package:shopsmart_admin_ar/core/models/product_model.dart';
import 'package:shopsmart_admin_ar/core/widgets/app_name_shimmer.dart';
import 'package:shopsmart_admin_ar/core/widgets/showTopSnackbar.dart';
import 'package:shopsmart_admin_ar/features/add_product_screen/widgets/custom_material_button.dart';
import 'package:shopsmart_admin_ar/features/add_product_screen/widgets/image_picker_alert_dialog.dart';
import 'package:shopsmart_admin_ar/features/add_product_screen/widgets/text_form.dart';
import 'package:uuid/uuid.dart';

class AddOrUpdateProductScreen extends StatefulWidget {
  const AddOrUpdateProductScreen({super.key, this.productModel});
  static const routname = 'AddProductScreen ';
  final ProductModel? productModel;
  @override
  State<AddOrUpdateProductScreen> createState() =>
      _AddOrUpdateProductScreenState();
}

class _AddOrUpdateProductScreenState extends State<AddOrUpdateProductScreen> {
  late TextEditingController _textEditingController;
  late TextEditingController _priceEditingController;
  late TextEditingController _quantityEditingController;
  late TextEditingController _descriptionEditingController;

  final AutovalidateMode _autovalidateMode = AutovalidateMode.always;
  GlobalKey<FormState> key = GlobalKey();
  var imagePicker = ImagePicker();
  XFile? pickedImage;

  String? category;
  String? productmodelimage;
  String? productImageUrl;
  bool isEditing = false;

  bool isloading = false;

  @override
  void initState() {
    if (widget.productModel != null) {
      isEditing = true;
      productmodelimage = widget.productModel!.productImage;
    }
    _textEditingController =
        TextEditingController(text: widget.productModel?.productTitle);
    _priceEditingController =
        TextEditingController(text: widget.productModel?.productPrice);
    _quantityEditingController =
        TextEditingController(text: widget.productModel?.productQuantity);
    _descriptionEditingController =
        TextEditingController(text: widget.productModel?.productDescription);
    super.initState();
  }

  void clearForm() {
    _textEditingController.clear();
    _priceEditingController.clear();
    _quantityEditingController.clear();
    _descriptionEditingController.clear();
    setState(() {
      pickedImage = null;
      productmodelimage = null;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _priceEditingController.dispose();
    _quantityEditingController.dispose();
    _descriptionEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.45;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppNameWidget(name: "Upload a new product"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              autovalidateMode: _autovalidateMode,
              child: Column(
                children: [
                  Stack(
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
                          child: isEditing
                              ? (productmodelimage != null
                                  ? FancyShimmerImage(
                                      imageUrl: productmodelimage!,
                                      boxFit: BoxFit.fill,
                                    )
                                  : (pickedImage != null
                                      ? Image.file(
                                          File(pickedImage!.path),
                                          fit: BoxFit.fill,
                                        )
                                      : const Center(
                                          child: Text(
                                          "Product image",
                                        ))))
                              : (pickedImage == null
                                  ? const Center(
                                      child: Text("Product image"),
                                    )
                                  : Image.file(
                                      File(pickedImage!.path),
                                      fit: BoxFit.fill,
                                    )),
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
                                        pickedImage = image;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    onGallery: () async {
                                      var image = await imagePicker.pickImage(
                                          source: ImageSource.gallery);

                                      setState(() {
                                        pickedImage = image;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    onRemove: () {
                                      setState(() {
                                        pickedImage = null;
                                        productmodelimage = null;
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButton<String>(
                    hint: Text(isEditing
                        ? widget.productModel!.productCategory
                        : "Select Category"),
                    value: category,
                    items: AppConstants.dropdowlist(),
                    onChanged: (String? value) {
                      setState(() {
                        category = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultCustomFormField(
                    textfieldcontroller: _textEditingController,
                    inputaction: TextInputAction.next,
                    inputtype: TextInputType.multiline,
                    hint: 'Product title',
                    maxLength: 80,
                    maxlines: 2,
                    massege: 'Please enter a valid title',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width,
                        child: DefaultCustomFormField(
                          textfieldcontroller: _priceEditingController,
                          inputaction: TextInputAction.next,
                          inputtype: TextInputType.number,
                          hint: 'Price',
                          massege: 'Price is missing',
                          formatter: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width,
                        child: DefaultCustomFormField(
                          textfieldcontroller: _quantityEditingController,
                          inputaction: TextInputAction.next,
                          inputtype: TextInputType.number,
                          hint: 'Qty',
                          massege: 'Quantity is missed',
                          formatter: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultCustomFormField(
                    textfieldcontroller: _descriptionEditingController,
                    inputaction: TextInputAction.done,
                    inputtype: TextInputType.text,
                    hint: 'Product description',
                    maxLength: 1000,
                    minlines: 3,
                    maxlines: 10,
                    massege: 'Description is missed',
                    textCaptilize: TextCapitalization.sentences,
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    clearForm();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Clear",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (isEditing) {
                        editingProduct();
                      } else {
                        uPloadingProduct();
                      }
                    },
                    icon: const Icon(
                      Icons.upload,
                    ),
                    label: isloading
                        ? const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator())
                        : Text(
                            isEditing ? "Edit Product" : "Upload product",
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uPloadingProduct() async {
    if (pickedImage == null) {
      showWarningDialog(context, text: 'make sure to pick up an image');
      return;
    }
    if (category == null) {
      showWarningDialog(context, text: 'Category is Empty');
      return;
    }

    if (key.currentState!.validate()) {
      key.currentState!.save();
      isloading = true;
      setState(() {});
      try {
        String productId = const Uuid().v4();
        await storeUserImage(productId: productId);
        await storeProductData(productId: productId);
        showTopSnakbar(
            context: context,
            success: true,
            message: "Product has been added Successfully");
        // Navigator.pushNamed(context, RootPage.routname);
      } on FirebaseException catch (e) {
        debugPrint('$e');
        showTopSnakbar(
          context: context,
          success: false,
          message: "there was an error with Firebase",
        );
      } catch (e) {
        showTopSnakbar(
          context: context,
          success: false,
          message: "there was an error",
        );
      }
      isloading = false;
      setState(() {});
    } else {}
  }

  Future<void> storeUserImage({required String productId}) async {
    final refernce = FirebaseStorage.instance
        .ref()
        .child("productsImages")
        .child("$productId.jpg");
    await refernce.putFile(File(pickedImage!.path));
    productImageUrl = await refernce.getDownloadURL();
  }

  Future<void> storeProductData({required String productId}) async {
    FirebaseFirestore.instance.collection("products").doc(productId).set({
      "productId": productId,
      "productTitle": _textEditingController.text.trim(),
      "productPrice": _priceEditingController.text.trim(),
      "productCategory": category,
      "productDescription": _descriptionEditingController.text.trim(),
      "productImage": productImageUrl,
      "productQuantity": _quantityEditingController.text.trim(),
      "timestamp": Timestamp.now(),
    });
  }

  Future<void> updateProductData({required String productId}) async {
    FirebaseFirestore.instance.collection("products").doc(productId).update({
      "productId": productId,
      "productTitle": _textEditingController.text.trim(),
      "productPrice": _priceEditingController.text.trim(),
      "productCategory": category ?? widget.productModel!.productCategory,
      "productDescription": _descriptionEditingController.text.trim(),
      "productImage": productImageUrl ?? productmodelimage,
      "productQuantity": _quantityEditingController.text.trim(),
      "timestamp": Timestamp.now(),
    });
  }

  Future<void> editingProduct() async {
    if (pickedImage == null && productmodelimage == null) {
      showWarningDialog(context, text: 'Please pick up an image');
      return;
    }
    if (key.currentState!.validate()) {
      key.currentState!.save();
      isloading = true;
      setState(() {});
      try {
        String productId = widget.productModel!.productId;
        if (pickedImage != null) {
          await storeUserImage(productId: productId);
        }
        await updateProductData(productId: productId);
        showTopSnakbar(
            context: context,
            success: true,
            message: "Product has been Updated Successfully");
      } on FirebaseException catch (e) {
        debugPrint('$e');
        showTopSnakbar(
          context: context,
          success: false,
          message: "there was an error with Firebase",
        );
      } catch (e) {
        showTopSnakbar(
          context: context,
          success: false,
          message: "there was an error",
        );
      }
      isloading = false;
      setState(() {});
    } else {}
  }
}
