import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../config/theme_config.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String name;
  final String? hintText;
  final InputDecoration? decoration;
  final TextStyle? style;
  final bool obscureText;
  final bool autofocus;
  final AutovalidateMode autovalidateMode;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSubmitted;

  const PasswordField({
    super.key,
    this.controller,
    required this.name,
    this.hintText,
    this.decoration,
    this.style,
    this.obscureText = true,
    this.autofocus = false,
    this.autovalidateMode = AutovalidateMode.always,
    this.contentPadding,
    this.border,
    this.validator,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.name,
      controller: widget.controller,
      obscureText: _isObscured,
      decoration: (widget.decoration ?? const InputDecoration()).copyWith(
        hintText: widget.hintText,
        border: widget.border,
        contentPadding: widget.contentPadding,
        suffixIcon: IconButton(
          icon: Icon(
            color: ThemeConfig.n5,
            _isObscured ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _toggleVisibility,
        ),
      ),
      style: widget.style,
      autofocus: widget.autofocus,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
    );
  }
}
