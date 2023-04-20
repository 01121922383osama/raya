// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raya/Features/constens/conestans.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class BodyOfTheAdminPage extends StatefulWidget {
  const BodyOfTheAdminPage({Key? key}) : super(key: key);

  @override
  State<BodyOfTheAdminPage> createState() => _BodyOfTheAdminPageState();
}

class _BodyOfTheAdminPageState extends State<BodyOfTheAdminPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController squadController = TextEditingController();
  final TextEditingController divisionController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController paymentsController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  @override
  void dispose() {
    clearTexrFormField();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(
            width: double.infinity,
            height: 600,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Card(
                color: KPrimaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'الاسم',
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                            hintStyle: TextStyle(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15),
                                top: Radius.circular(15),
                              ),
                            ),
                            hintTextDirection: TextDirection.rtl,
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.start,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: squadController,
                          decoration: const InputDecoration(
                            labelText: 'الفرقه',
                            alignLabelWithHint: true,
                            hintTextDirection: TextDirection.rtl,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15),
                                top: Radius.circular(15),
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.start,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your squad';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: divisionController,
                          decoration: const InputDecoration(
                            labelText: 'الشعبه',
                            alignLabelWithHint: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15),
                                top: Radius.circular(15),
                              ),
                            ),
                            hintTextDirection: TextDirection.rtl,
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.start,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your division';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: ageController,
                          decoration: const InputDecoration(
                            labelText: 'العمر',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15),
                                top: Radius.circular(15),
                              ),
                            ),
                            alignLabelWithHint: true,
                            hintTextDirection: TextDirection.rtl,
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.start,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.tryParse(value) == null) {
                              return 'Please enter a valid age';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: paymentsController,
                          decoration: const InputDecoration(
                            labelText: 'المصاريف',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15),
                                top: Radius.circular(15),
                              ),
                            ),
                            alignLabelWithHint: true,
                            hintTextDirection: TextDirection.rtl,
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.start,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.tryParse(value) == null) {
                              return 'Please enter a valid payment amount';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: codeController,
                          decoration: const InputDecoration(
                            labelText: 'كود الطالب',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15),
                                top: Radius.circular(15),
                              ),
                            ),
                            alignLabelWithHint: true,
                            hintTextDirection: TextDirection.rtl,
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.start,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.tryParse(value) == null) {
                              return 'Please enter a valid code';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: KAppBarColors,
                            elevation: 10,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final code = codeController.text;
                              final querySnapshot = await FirebaseFirestore
                                  .instance
                                  .collection('DataOfUsers')
                                  .where('code', isEqualTo: code)
                                  .limit(1)
                                  .get();
                              if (querySnapshot.docs.isNotEmpty) {
                                // Document with the same code already Saved
                                if (kDebugMode) {
                                  print('Data with code $code already Saved');
                                }
                                return AwesomeDialog(
                                  context: context,
                                  title: 'error',
                                  body: Column(
                                    children: <Widget>[
                                      Text(
                                        'Data with code $code already Saved',
                                      ),
                                    ],
                                  ),
                                  dialogType: DialogType.info,
                                ).show();
                              }
                              FirebaseFirestore.instance
                                  .collection('DataOfUsers')
                                  .add({
                                'name': nameController.text,
                                'squad': squadController.text,
                                'division': divisionController.text,
                                'age': ageController.text,
                                'code': code,
                                'payments': paymentsController.text,
                              }).then((DocumentReference document) {
                                print(
                                    'Data saved successfully with ID: ${document.id}');
                                return AwesomeDialog(
                                  context: context,
                                  title: 'Success',
                                  body: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Data saved successfully'),
                                    ],
                                  ),
                                  dialogType: DialogType.success,
                                ).show();
                              }).catchError((e) {
                                print('Error saving data: $e');
                                return AwesomeDialog(
                                  context: context,
                                  title: 'error',
                                  body: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Error saving data: $e',
                                      ),
                                    ],
                                  ),
                                  dialogType: DialogType.error,
                                ).show();
                              });
                            }
                          },
                          child: const Text(
                            'Send data to Students',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void clearTexrFormField() {
    nameController.dispose();
    squadController.dispose();
    divisionController.dispose();
    ageController.dispose();
    paymentsController.dispose();
    codeController.dispose();
    nameController.clear();
    squadController.clear();
    divisionController.clear();
    ageController.clear();
    paymentsController.clear();
    codeController.clear();
    super.dispose();
  }
}
