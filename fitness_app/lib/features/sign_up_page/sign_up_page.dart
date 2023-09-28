import 'package:fitness_app/core/common_widgets/app_text_field_widget.dart';
import 'package:fitness_app/core/common_widgets/drop_down_with_title.dart';
import 'package:fitness_app/core/local_hive/pref_box.dart';
import 'package:fitness_app/core/local_hive/user_details.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/utils/app_ui_helper.dart';
import 'package:fitness_app/core/utils/app_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> dropDown = <String>[
    "Male",
    "Female",
    "Other",
  ];
  String selectedSex = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign-Up"),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: appHorizontalPadding15),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: [
                verticalSpace20,
                verticalSpace20,
                AppTextFieldWidget(
                  keyboardType: TextInputType.name,
                  hintText: "Enter your name",
                  textFieldController: nameController,
                  validator: AppValidation.nameValidator,
                  inputFormatters: AppValidation.fullNameFormatters(),
                  onTap: () {},
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                ),
                verticalSpace20,
                AppTextFieldWidget(
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Enter email address",
                  textFieldController: emailController,
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                  validator: AppValidation.checkEmailValidation,
                  onTap: () {},
                ),
                verticalSpace20,
                DropDownWithTitle(
                  selectedItem: "Male",
                  hint: "Select sex",
                  title: "Sex",
                  itemList: dropDown,
                  onChanged: (value) {
                    selectedSex = value ?? "";
                  },
                ),
                verticalSpace20,
                AppTextFieldWidget(
                  keyboardType: TextInputType.number,
                  validator: AppValidation.checkPhoneNumberValidation,
                  textFieldController: phoneController,
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                  hintText: "Enter phone number",
                  inputFormatters: AppValidation.phoneNumberFormatters(),
                ),
                verticalSpace20,
                AppTextFieldWidget(
                  keyboardType: TextInputType.number,
                  validator:  AppValidation.ageValidator,
                  textFieldController: ageController,
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                  hintText: "Enter age",
                  inputFormatters: AppValidation.numberFormatters(),
                ),
                verticalSpace20,
                AppTextFieldWidget(
                  keyboardType: TextInputType.number,
                  textFieldController: heightController,
                  validator:  AppValidation.heightValidator,
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                  hintText: "Enter height",
                  inputFormatters: AppValidation.numberFormatters(),
                ),
                verticalSpace20,
                AppTextFieldWidget(
                  keyboardType: TextInputType.number,
                  textFieldController: weightController,
                  validator:  AppValidation.weightValidator,
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                  hintText: "Enter weight",
                  inputFormatters: AppValidation.numberFormatters(),
                ),
                verticalSpaceLarge,
                MaterialButton(
                  onPressed: onTapContinue,
                  color: Colors.blue,
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  void onTapContinue() async {
    if (_formKey.currentState!.validate()) {
      final data=UserDetails(
        name: nameController.text,
        emailAddress: emailController.text,
        contactPhone: phoneController.text,
        age: ageController.text,
        height: heightController.text,
        weight: weightController.text,
        sex: selectedSex,
      );
      GetIt.I.get<PrefBox>().userPayload = data;
      print(GetIt.I.get<PrefBox>().userPayload );
      Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.exercisesPage, (Route<dynamic> route) => false);
    }
  }
}
