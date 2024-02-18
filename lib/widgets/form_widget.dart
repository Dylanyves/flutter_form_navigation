import 'package:flutter/material.dart';
import '../utils/validators.dart';
import 'package:form_field_validator/form_field_validator.dart'; //$flutter pub add form_field_validator
// https://pub.dev/packages/form_field_validator/versions/1.0.1
import '../models/user_model.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key, required this.updateUser});

  final ValueChanged<User> updateUser;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void onSubmit() {
    final name = _nameController.text;
    final id = _idController.text;
    final email = _emailController.text;

    bool validate = _formKey.currentState!.validate();
    if (!validate) {
      return;
    }

    User newUser = User(id: int.parse(id), name: name, email: email);
    widget.updateUser(newUser);
    _nameController.clear();
    _idController.clear();
    _emailController.clear();

    print("Name: $name, ID: $id, Email: $email");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                controller: _nameController,
                validator:
                    RequiredValidator(errorText: "Please enter your name"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Full Name",
                )),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: _idController,
                validator: MultiValidator([
                  RequiredValidator(errorText: "Please enter your student ID"),
                  MinLengthValidator(11,
                      errorText: "Student ID must be 11 characters"),
                  MaxLengthValidator(11,
                      errorText: "Student ID must be 11 characters"),
                  PatternValidator(r'^[0-9]*$',
                      errorText: 'Student ID must be numeric')
                ]),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Student ID",
                )),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: _emailController,
                validator: MultiValidator([
                  RequiredValidator(errorText: "Please enter your email"),
                  EmailValidator(errorText: "Please enter a valid email")
                ]),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                )),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: onSubmit, child: Text("Login"))
          ],
        ));
  }
}
