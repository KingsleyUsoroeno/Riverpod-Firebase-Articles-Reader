import 'package:flutter/material.dart';
import 'package:sport_house/ui/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final Widget? suffixIcon;
  final String? label;
  final String? hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    this.suffixIcon,
    this.label,
    this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty)
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        const SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          validator: (value) {
            if (widget.validator != null) {
              setState(() {
                errorText = widget.validator!(value);
              });
              return errorText;
            }
            return null;
          },
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            errorStyle: const TextStyle(fontSize: 0.01, height: 0, color: Colors.red),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: errorText == null ? AppColors.white400 : Colors.red,
                  width: errorText == null ? 1 : 2),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: errorText == null ? AppColors.white400 : Colors.red,
                  width: errorText == null ? 1 : 2),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: errorText == null ? AppColors.white400 : Colors.red,
                  width: errorText == null ? 1 : 2),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorText == null ? AppColors.white400 : Colors.red,
                width: errorText == null ? 1 : 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: widget.hintText,
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Text(errorText ?? '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red)),
          ),
      ],
    );
  }
}
