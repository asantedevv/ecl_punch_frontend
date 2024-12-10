import 'package:flutter/material.dart';

class DynamicTextFormField extends StatelessWidget {
  final String? labelText; 
  const DynamicTextFormField({super.key, this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(decoration: InputDecoration(
      label: Text(labelText?? "")
    ),);
  }
}