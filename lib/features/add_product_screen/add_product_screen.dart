import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopsmart_admin_ar/core/consts/app_constants.dart';
import 'package:shopsmart_admin_ar/core/methods/show_warning_dialog.dart';
import 'package:shopsmart_admin_ar/core/utils/validators/my_validator.dart';
import 'package:shopsmart_admin_ar/core/widgets/app_name_shimmer.dart';
import 'package:shopsmart_admin_ar/features/add_product_screen/widgets/text_form.dart';
import 'package:shopsmart_admin_ar/features/add_product_screen/widgets/warning_alert_dialog.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  static const routname = 'AddProductScreen ';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late TextEditingController _textEditingController;
  late TextEditingController _priceEditingController;
  late TextEditingController _quantityEditingController;
  late TextEditingController _descriptionEditingController;

  final AutovalidateMode _autovalidateMode = AutovalidateMode.always;
  GlobalKey<FormState> key = GlobalKey();

  String? category;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    _priceEditingController = TextEditingController();
    _quantityEditingController = TextEditingController();
    _descriptionEditingController = TextEditingController();
    super.initState();
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
                  DropdownButton<String>(
                    hint: const Text("Select Category"),
                    value: category,
                    items: AppConstants.dropdowlist(),
                    onChanged: (String? value) {
                      setState(() {
                        category = value;
                      });
                    },
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
                  onPressed: () {},
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
                      if (category == null) {
                        return showWarningDialog(context);
                      }
                    },
                    icon: const Icon(
                      Icons.upload,
                    ),
                    label: const Text(
                      "Upload product",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
