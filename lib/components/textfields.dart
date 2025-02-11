import 'package:flutter/material.dart';

class PrimaryTextField extends StatefulWidget {
  const PrimaryTextField({
    this.hintText = '',
    this.prefixIcon,
    this.isObscure = false,
    this.controller,
    Key? key,
  }) : super(key: key);

  final IconData? prefixIcon;
  final String hintText;
  final bool isObscure;
  final TextEditingController? controller; // Added controller parameter

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 16,
      shadowColor: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2.5),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text'; // Basic validation
            }
            return null; // Return null if input is valid
          },
          obscureText: widget.isObscure,
          controller: widget.controller, // Use the controller provided
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
              widget.prefixIcon,
              size: 20,
              color: Colors.blue,
            )
                : const SizedBox.shrink(),
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
              color: Colors.grey, // Added color for better contrast
            ),
          ),
        ),
      ),
    );
  }
}
